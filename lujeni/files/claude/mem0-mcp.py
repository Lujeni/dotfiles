#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["mem0ai", "fastembed", "mcp<2"]
# ///
"""Local mem0 MCP server: numberly gateway as LLM, fastembed on CPU, on-disk qdrant.

One memory per agent (mem0 agent_id). Stdio, one process per claude session.
"""
import os
import time
from contextlib import contextmanager

os.environ.setdefault("MEM0_TELEMETRY", "False")  # read at import time

from mcp.server.fastmcp import FastMCP
from mem0 import Memory
from mem0.llms.vllm import VllmLLM

# gateway's guided decoding is broken: with response_format=json_object it stops after '{"'
_generate = VllmLLM.generate_response
VllmLLM.generate_response = lambda self, messages, response_format=None, **kw: _generate(self, messages, **kw)

DATA = os.path.expanduser("~/.local/share/mem0")
USER = os.environ.get("USER", "default")
CONFIG = {
    "llm": {
        "provider": "vllm",
        "config": {
            "model": "numberly-code-assistant",
            "vllm_base_url": "https://coding-assistant.numberly.in/v1",
            "api_key": "dummy-key",
            # reasoning model: leave room for thinking before the json answer
            "max_tokens": 8000,
        },
    },
    # gateway has no /v1/embeddings
    "embedder": {
        "provider": "fastembed",
        "config": {"model": "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"},
    },
    "vector_store": {
        "provider": "qdrant",
        "config": {"path": f"{DATA}/qdrant", "collection_name": "mem0", "embedding_model_dims": 384, "on_disk": True},
    },
    "history_db_path": f"{DATA}/history.db",
}


# ponytail: on-disk qdrant allows one client at a time, so open per call and wait for the lock.
# Reloads the embedder each call (~seconds); move to a shared qdrant server if that hurts.
@contextmanager
def memory(timeout=120):
    deadline = time.monotonic() + timeout
    while True:
        try:
            m = Memory.from_config(CONFIG)
            break
        except RuntimeError as e:
            if "already accessed" not in str(e) or time.monotonic() > deadline:
                raise
            time.sleep(1)
    try:
        yield m
    finally:
        m.close()


mcp = FastMCP("mem0")


@mcp.tool()
def add_memory(agent: str, text: str) -> dict:
    """Store a durable fact, preference or decision in `agent`'s own memory (agent = your agent name)."""
    with memory() as m:
        return m.add(text, user_id=USER, agent_id=agent)


@mcp.tool()
def search_memories(agent: str, query: str, limit: int = 5) -> dict:
    """Search `agent`'s own memory (agent = your agent name)."""
    with memory() as m:
        return m.search(query, filters={"user_id": USER, "agent_id": agent}, limit=limit)


@mcp.tool()
def list_memories(agent: str) -> dict:
    """List everything in `agent`'s own memory (agent = your agent name)."""
    with memory() as m:
        return m.get_all(filters={"user_id": USER, "agent_id": agent})


@mcp.tool()
def delete_memory(memory_id: str) -> dict:
    """Delete a memory by id."""
    with memory() as m:
        return m.delete(memory_id)


if __name__ == "__main__":
    mcp.run()
