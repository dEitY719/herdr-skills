"""Hermes Agent registration for the `herdr` skills plugin."""

import os
from pathlib import Path

# Sentinel skill used to recognise a correctly laid out skills/ tree.
_SENTINEL = ("control", "SKILL.md")


def _skills_dir() -> str:
    """Locate the stock skills/ tree for either supported install layout.

    - git-clone install: the plugin dir is the repo root, so `.hermes-plugin/`
      and `skills/` are siblings and this module resolves `../skills`.
    - flattened install: `skills/` sits next to this module.

    Raises loudly when neither matches — a bootstrap that silently skips is how
    a broken install masquerades as a working one.
    """
    here = os.path.dirname(os.path.realpath(__file__))
    candidates = (
        os.path.realpath(os.path.join(here, "..", "skills")),
        os.path.realpath(os.path.join(here, "skills")),
    )
    for cand in candidates:
        if os.path.isfile(os.path.join(cand, *_SENTINEL)):
            return cand
    raise RuntimeError(
        "herdr plugin: cannot find the skills/ tree "
        f"(looked at {candidates}). Reinstall with "
        "`hermes plugins install dEitY719/herdr-skills`."
    )


def register(ctx):
    skills_dir = _skills_dir()
    for name in sorted(os.listdir(skills_dir)):
        skill_md = os.path.join(skills_dir, name, "SKILL.md")
        if os.path.isfile(skill_md):
            ctx.register_skill(name, Path(skill_md))
