# Upstream provenance — herdr:control

`skills/control/SKILL.md` is a vendored copy of the official Herdr agent skill.
It is not authored in this repo. Do not edit its body; replace it from upstream.

## Source

| Field | Value |
|-------|-------|
| Original | https://github.com/herdrdev/herdr/blob/master/skills/herdr/SKILL.md |
| Upstream repo | `herdrdev/herdr` (formerly `ogulcancelik/herdr`) |
| Vendored from tag | `v0.9.5` = commit `2ecf19a92fc3a7fff75b6ce3655ef04f4625ec01` |
| Last upstream commit touching the file | `7e26bad94044eba205033111a0ce8033ede7e24f` |
| Baseline herdr version | `0.9.5` |
| Captured with | `herdr --skill` from the installed herdr 0.9.5 binary |

The captured bundle was verified byte-identical to `skills/herdr/SKILL.md` at
tag `v0.9.5` and at `master` as of 2026-10-26.

Baseline note: the spec (dEitY719/dotfiles#2291) named herdr `0.9.0` as the
initial baseline. The baseline is `0.9.5` instead, because the installed binary
is 0.9.5, and the drift self-check compares against the installed binary.

## License

Upstream is licensed under the Apache License, Version 2.0. The full text ships
next to the skill as `skills/control/LICENSE.txt` (copied from the upstream
`LICENSE` at `v0.9.5`). Upstream has no `NOTICE` file. Apache-2.0 section 4(a)
forbids relicensing, so this directory stays Apache-2.0 while the rest of the
repo is MIT.

## Local changes (the complete list)

1. Frontmatter `name: herdr` -> `name: control`, so Claude Code exposes the
   skill as `/herdr:control` instead of `/herdr:herdr`.
2. Frontmatter `license: Apache-2.0` added. The shared CI license check
   (`.github/workflows/validate.yml` `license-exceptions`) requires a
   `license:` key in every SKILL.md; upstream's frontmatter has none.

3. Progressive-disclosure split (owner decision, authoring:skill-refactor):
   the sections "Understand layout, panes, and agents", "Use IDs and caller
   context", "Start and coordinate an agent" and "Run an ordinary command in
   another pane" moved verbatim to `references/*.md`, replaced in SKILL.md by a
   pointer list. Text is unchanged, but SKILL.md no longer matches upstream, so
   `scripts/upstream-drift.selfcheck.sh` compares the reassembled body.

4. Frontmatter `metadata.model_recommendation` added (tier sonnet), to satisfy
   authoring:skill-check Check 13.
5. Frontmatter comment `# Check 16: ...` added above `description:`, to satisfy
   Check 16 (description is 328 chars). The description text is unchanged.

Nothing else differs. The `description` and all moved text are byte-identical
to upstream, apart from the two-line title prepended to each `references/*.md`
and the pointer list in SKILL.md (both ignored/replaced by the drift check).

## Update procedure

1. Upgrade herdr, then capture the bundled copy:
   `herdr --skill > /tmp/herdr-skill.md`
2. Replace `skills/control/SKILL.md` with that file, then re-apply local
   changes 1, 2, 4 and 5 above (frontmatter edits).
3. Re-split per local change 3 (moved sections go to `references/*.md`, in
   upstream order, each prefixed by a two-line title). Run the drift
   self-check. It must print `[OK] in sync with herdr <version>`:
   `bash skills/control/scripts/upstream-drift.selfcheck.sh`
4. Update the table above (tag, commits, baseline version), and refresh
   `LICENSE.txt` if upstream changed it.
5. Bump `version` in `.claude-plugin/plugin.json` and keep the other six
   version-bearing manifests in agreement.

A failing self-check means drift. Follow this procedure. Never disable or
ignore the self-check.
