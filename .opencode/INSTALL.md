# Installing herdr for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed
- [Herdr](https://github.com/herdrdev/herdr) installed, and OpenCode running
  inside a Herdr pane (`HERDR_ENV=1`)

## Installation

Add the plugin to the `plugin` array in your `opencode.json` (global or
project-level):

```json
{
  "plugin": ["herdr-skills@git+https://github.com/dEitY719/herdr-skills.git"]
}
```

Restart OpenCode. If you also use Claude Code, Codex, or another harness,
install this plugin separately for each one.

## Usage

Use OpenCode's native `skill` tool:

```
use skill tool to list skills
use skill tool to load control
```

## Tool mapping

The authoritative OpenCode tool mapping for every `dEitY719/*-skills` repo is
owned by
[`dEitY719/harness-skills`](https://github.com/dEitY719/harness-skills/blob/main/references/opencode-tools.md).
Short version: "Run a shell command" -> `bash` (every `herdr` call); "Read a
file" -> `read`; "Ask the user" -> stop and ask in your reply.

## Getting Help

Report issues: https://github.com/dEitY719/herdr-skills/issues
