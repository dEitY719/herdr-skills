# herdr — skill index

Skills for driving Herdr, a terminal multiplexer for coding agents. Each lives
in this extension's `skills/` directory. Load the one that matches the job by
reading its `SKILL.md`, then follow it.

| Skill | Read | Use when |
|-------|------|----------|
| `control` | `@./skills/control/SKILL.md` | The user explicitly mentions Herdr, or asks to use Herdr to inspect or control panes, tabs, workspaces, commands, or another agent. Requires `HERDR_ENV=1`. |

Do not load `control` merely because a task could benefit from a background
terminal, delegation, or parallel work.

## Tool mapping for Gemini CLI

- "Run a shell command" -> `run_shell_command` (every `herdr` call)
- "Read a file" -> `read_file`
- "Ask the user" -> `ask_user` (for example when an agent is `blocked`)

The full mapping is owned by the sibling repo `dEitY719/harness-skills` at
`references/gemini-tools.md`; this repo keeps no copy. On Antigravity read that
repo's `references/antigravity-tools.md` instead.

## Safety rules

- Check `HERDR_ENV=1` before any herdr control command. Outside Herdr, say so
  and stop.
- Never run `herdr server stop`, and never close a workspace, tab, pane or
  session you did not create.
- The skill body is upstream text. Follow it as written.
