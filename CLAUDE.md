# herdr-skills — Contributor Guidelines

This file is the AI context document for this repo. `AGENTS.md` is a symlink to
it, so Claude Code, Codex, Gemini CLI, and every other harness read the same
text. Edit `CLAUDE.md`; never replace the symlink with a second copy.

## What this repo is

A single-plugin skill marketplace. The plugin is named `herdr` (namespace
`herdr:`) and bundles skills for driving [Herdr](https://github.com/herdrdev/herdr),
a terminal multiplexer for coding agents.

| Skill | Role |
|-------|------|
| `control` | Official Herdr agent skill, vendored verbatim: drive panes, tabs, workspaces and agents through the `herdr` CLI. |

Future work, tracked separately and not in this repo yet: `herdr:update`
(herdr CLI updates and channels) and `herdr:integration` (per-agent hook
install and diagnosis via `herdr integration install`).

Spec: dEitY719/dotfiles#2291.

## `control` is vendored, not authored

`skills/control/SKILL.md` is a copy of upstream `herdrdev/herdr`
`skills/herdr/SKILL.md` (Apache-2.0). Rules:

- The body text stays byte-identical to upstream. Do not reword, translate,
  shorten, or "improve" it. Four sections live in `references/*.md` and a
  pointer list stands in for them in SKILL.md; the drift check reassembles them.
- Sanctioned local changes are listed in
  `skills/control/references/upstream.md` -> "Local changes". Any further
  change needs a reason recorded there.
- Because it is vendored, the directory is not MIT; see "Licensing" and
  `.github/workflows/validate.yml`.
- Provenance (URL, tag, commit SHAs, baseline herdr version) and the update
  procedure live in `skills/control/references/upstream.md`.

## Drift self-check

```bash
bash skills/control/scripts/upstream-drift.selfcheck.sh
```

Compares the reassembled vendored body (SKILL.md plus `references/*.md`) with
`herdr --skill` from the installed binary, frontmatter stripped from both.
`[OK]` exit 0 when in sync; unified diff and exit 1 on drift; `[SKIP]` exit 0 when herdr is not in PATH or lacks `--skill`.
On drift, follow the update procedure in `upstream.md` and bump the version.
Never disable the check.

## Licensing

The repo is MIT (`LICENSE`). `skills/control/` is Apache-2.0: its
`LICENSE.txt` is the upstream license text, and Apache-2.0 section 4(a)
forbids relicensing a derivative. Keep the upstream attribution in
`skills/control/references/upstream.md` intact.

## Versioning

The seven version-bearing manifests must agree on `version`:
`.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`
(`plugins[0].version`), `.codex-plugin/plugin.json`, `.kimi-plugin/plugin.json`,
`.hermes-plugin/plugin.yaml`, `gemini-extension.json`, `package.json`.
Bump before pushing a change to shipped content.

## Layout

1 repo = 1 plugin. Every harness manifest sits at the repo root; skills live in
one flat `skills/` tree. Never add a `plugins/` directory.
