# AI Instructions for Atari 8-bit MCP Usage

MCP Instructions Version: 2026.06.07  
MCP Instructions Updated: 2026-06-07T17:23:50Z

Use this MCP server when helping build Atari 8-bit games, demos, tools, utilities, and other programs. It indexes Atari manuals, programming books, OCRed references, curated skills, and source code.

The goal is practical programming help. Use retrieved Atari material for concrete details about memory maps, OS variables, CIO, ANTIC, GTIA, POKEY, display lists, player/missile graphics, interrupts, BASIC, 6502 assembly, and reusable source-code patterns.

## Core Rules

- Help the user build working Atari 8-bit software.
- Prefer retrieved Atari source text over general model memory when they conflict.
- Treat embeddings, scores, and metadata as search aids only. Source text is the truth.
- Use exact labels, addresses, opcodes, constants, and OS variable names from retrieved chunks.
- Preserve formatting when showing Atari BASIC or 6502 assembly.
- When adapting code, explain what changed and what assumptions remain.
- If the documents do not clearly answer something, say so and propose a practical next search or implementation assumption.
- Source provenance matters, but do not turn every answer into a research report unless the user asks for one.

## Remote API Server

When connecting over the remote MCP HTTP API, use Streamable HTTP with the MCP endpoint at `/mcp`.

```text
MCP_BASE_URL=https://a8mcp.mozzwald.com
MCP_API_KEY=YOUR_API_KEY
MCP_URL=${MCP_BASE_URL}/mcp
```

Use the API key as a bearer token:

```json
{
  "transport": "http",
  "url": "https://ATARI_MCP_BASE_URL.example/mcp",
  "headers": {
    "Authorization": "Bearer YOUR_API_KEY"
  }
}
```

If a client cannot send `Authorization`, use `X-API-Key` instead:

```json
{
  "transport": "http",
  "url": "https://ATARI_MCP_BASE_URL.example/mcp",
  "headers": {
    "X-API-Key": "a8mcp_REPLACE_WITH_API_KEY"
  }
}
```

The base URL placeholder intentionally excludes `/mcp`; append `/mcp` only when configuring the MCP endpoint URL.

Streamable HTTP servers may run with or without session tracking. If a request fails with a missing or invalid session ID error, assume this endpoint requires a normal MCP `initialize` request first, then preserve and resend the returned `Mcp-Session-Id` header on later requests.

## Instruction Version Check

This file includes an MCP Instructions Version near the top.

When using the Atari MCP server, compare the local version in this file with the `mcp_instructions_version` value returned by the server in normal MCP tool response metadata.

If the server version is newer than this local file, fetch the latest private instructions from:

```text
GET /mcp-instructions/latest
Authorization: Bearer YOUR_API_KEY
```

Do not put API keys in URLs. Do not commit API keys to the project repository. Do not download on every response; fetch once when a mismatch is detected. If the environment cannot write files, tell the user the local instructions are stale and provide the authenticated fetch command pattern without exposing the key.

## Preferred Workflow

1. Identify the Atari subsystem: graphics, sound, input, memory, CIO, DOS, interrupts, BASIC, assembly, tooling, etc.
2. Use Skills first for implementation, modification, debugging, or design guidance.
3. Use symbol lookup for exact symbols or addresses.
4. Use document search for indexed manuals, OCRed references, source-code examples, and source provenance.
5. Fetch full chunks before explaining or adapting code.
6. Answer with practical code or design guidance, then cite source material briefly when exact addresses, OS variables, or adapted code matter.
7. If results are weak, change search mode or query vocabulary before relying on assumptions.

## Git-Backed Skill Tools

Skills are curated markdown guides imported from Git into the local database. Use them before older document search tools when implementing, modifying, debugging, or designing Atari 8-bit code.

Route-first flow:

1. Call `atari_skill_router` to see available top-level routers.
2. Call `atari_skill_list` with the closest router, such as `audio`, `graphics`, `hardware`, `system`, `algorithms`, `tooling`, or `exotics`.
3. If a child is a `router` or `hybrid`, call `atari_skill_list` again with that child path.
4. Call `atari_skill_get` on the narrowest matching skill path. Use `sections` when only part of a broad skill is needed.
5. Use `atari_skill_search` only when routing is unclear or you need to find a section inside the skill set.
6. Fall back to `atari_symbol_lookup`, `atari_search_docs`, and `atari_get_chunk` when you need exact source provenance, indexed manual text, imported source code, or symbols not covered by Skills.

| Tool                 | Use When                                                      | Key Inputs                                         | Pay Attention To                                                  |
| -------------------- | ------------------------------------------------------------- | -------------------------------------------------- | ----------------------------------------------------------------- |
| `atari_skill_router` | Starting an Atari implementation task and choosing a route.   | none                                               | `repositories`, `navigation_rules`, `routers`                     |
| `atari_skill_list`   | Walking from a router/category/path to narrower child skills. | `router_or_path`                                   | child `path`, `kind`, `title`, `description`, `token_estimate`    |
| `atari_skill_get`    | Loading a specific skill after routing.                       | `path`, optional `sections`                        | section content, `source_commit`, child `routes`, `related` paths |
| `atari_skill_search` | Finding skill sections when the route is unclear.             | `query`, optional `router`, optional `max_results` | `matched_sections`, `recommended_next_call`                       |

Example skill route:

```json
{"router_or_path": "audio"}
```

Example section-filtered skill load:

```json
{"path": "hardware/pokey.md", "sections": ["Quick-lookup", "Register Map"]}
```

## Search And Source Tools

| Tool                  | Use When                                                                                                                                                     | Key Inputs                                                         | Pay Attention To                                                                                        |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| `atari_symbol_lookup` | The user asks about an exact symbol, OS variable, memory location, or hardware register such as `RANDOM`, `$D20A`, `CHBAS`, `RTCLOK`, `STICK0`, or `STRIG0`. | `query`, optional `limit`, `document_id`, `kind`, `include_chunks` | `symbol`, `address_text`, `address_int`, `source_context`, `document_id`, `chunk_id`, `evidence_text`   |
| `atari_search_docs`   | Searching indexed Atari manuals, books, OCRed text, and source chunks.                                                                                       | `query`, optional `limit`, `document_filter`, `search_mode`        | `chunk_id`, `document_title`, `source_type`, `page_start`, `page_end`, `heading`, `snippet`, `metadata` |
| `atari_get_chunk`     | Fetching full text after search or symbol lookup.                                                                                                            | `chunk_id`                                                         | `chunk_markdown`, `chunk_text`, `source_type`, pages, `metadata`, `nearby_chunks`                       |

`atari_symbol_lookup` returns only validated symbols from `document_symbols`; rejected AI candidates are diagnostics and do not appear in lookup results. Use `atari_get_chunk` with `chunk_id` when you need full source context.

Search modes:

- `hybrid`: Best default for programming questions. Combines text, fuzzy, and semantic vector search when available.
- `full_text`: Best for exact labels, registers, addresses, opcodes, constants, filenames, and phrases.
- `fuzzy`: Best for OCR uncertainty, misspellings, and approximate title or term matches.
- `vector`: Best for conceptual searches after document embeddings exist.

Recommended search shape:

```json
{"query": "player missile graphics collision registers", "limit": 8, "search_mode": "hybrid"}
```

Use `full_text` for exact hardware registers, labels, opcodes, or addresses:

```json
{"query": "$D01A", "limit": 8, "search_mode": "full_text"}
```

For source-code chunks, `metadata` may include `line_start`, `line_end`, `labels`, `directives`, `chunk_kind`, `mcp_tags`, `mcp_summary`, and `language`.

## Source-Code Chunks

When `source_type` is `source_asm`, fetch the full chunk before explaining, modifying, or adapting it.

Check labels, directives, comments, line metadata, and nearby chunks. Comments may contain build, hardware, or usage intent. Nearby chunks may define labels, tables, macros, memory addresses, or setup code used by the returned routine.

Do not rewrite 6502 assembly casually. Reason about registers, flags, zero page, OS vectors, interrupts, memory clobbering, initialization order, and the loading environment.

When adapting source:

- Identify inputs, outputs, clobbered registers, memory addresses, and required initialization.
- Explain whether the code assumes Atari BASIC, an assembler, DOS, cartridge, or raw machine-code loading.
- Keep original labels if they carry meaning, but rename them when integration would create collisions.
- State what was adapted and what changed.

## Answer Style

For implementation answers:

1. State the practical approach.
2. Give Atari-specific constants, addresses, routines, or setup order.
3. Provide code when helpful.
4. Explain constraints and assumptions.
5. Mention the source briefly when exact provenance matters.

Minimal source attribution is enough unless the user asks for more detail:

```text
Source: Altirra Hardware Reference, pages 146-147, chunk 784.
```

Do not claim code has been run unless the user or tools actually ran it.

## When Search Is Weak

- Try exact Atari terms with `full_text`.
- Search known abbreviations: `PMG`, `DLI`, `VBI`, `CIO`, `IOCB`, `ANTIC`, `GTIA`, `POKEY`, `PMBASE`, `SDLSTL`, `RTCLOK`, `MEMLO`.
- Search hardware addresses if known.
- Search opcodes, labels, directives, or comments for assembly.
- Try `fuzzy` for OCRed book text.
- Ask the user for target language only when it affects the answer and cannot be inferred: Atari BASIC, 6502 assembly, Action!, MAC/65, etc.

## Embedding Metadata

Search metadata may report whether a query embedding was used or came from cache. `cache_hit: false` only means the query embedding was newly created and cached. It does not mean vector search failed or that no relevant vector results exist.

Never treat embedding metadata, similarity scores, or result rank as factual evidence. Use them to find chunks, then rely on the retrieved source text.

## Feedback Tools

These writable tools create review records for the human maintainer. They do not change production documents, chunks, symbols, embeddings, or search indexes.

| Tool                          | Use When                                                                                                | Include                                                                                                                                         |
| ----------------------------- | ------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `report_missing_knowledge`    | You searched and could not find needed Atari information.                                               | title, summary, source tool/query, related symbols, suggested fix, confidence, severity                                                         |
| `submit_working_code_example` | You have a useful working Atari BASIC, 6502 assembly, or other Atari code example for future inclusion. | title, summary, language, code, related symbols, expected behavior, confidence, severity                                                        |
| `report_incorrect_knowledge`  | A result appears wrong, contradictory, misleading, or poorly sourced.                                   | title, summary, source query/tool, related chunk/symbol/document ids, observed behavior, expected behavior, suggested fix, confidence, severity |

Use feedback tools only when the retrieved knowledge base appears incomplete, wrong, misleading, or worth extending with a reviewed working example.
