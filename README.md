# herdr-skills

> 에이전트 스킬 마켓플레이스 repo. `herdr` 플러그인 하나가 [Herdr](https://github.com/herdrdev/herdr)(코딩 에이전트용 터미널 멀티플렉서)를 다루는 스킬을 번들합니다.

## 설치

Claude Code:

```
/plugin marketplace add dEitY719/herdr-skills
/plugin install herdr@herdr-skills
```

다른 하네스(Codex / Kimi / Hermes / OpenCode / Antigravity / Gemini CLI)는 각자의
플러그인 설치 경로를 씁니다. 매니페스트는 모두 repo 루트에 있습니다.

## 스킬 목록

| 스킬 | 설명 | 가이드 / 사용 예시 |
|------|------|--------------------|
| `herdr:control` | Control Herdr, a terminal multiplexer for coding agents. 사용자가 Herdr 를 명시할 때만 동작하며 `HERDR_ENV=1` 이 필요합니다. | [guide](docs/skill-guides/control.html) · [usage](docs/skill-output/control-usage.md) |

향후 작업(별도 이슈, 아직 미포함): `herdr:update`(herdr CLI 업데이트·채널 관리),
`herdr:integration`(에이전트별 상태 감지 hook 설치·진단).

## herdr:control 은 upstream vendor 본입니다

`skills/control/SKILL.md` 는 herdr upstream 이 배포하는 공식 agent skill
(`herdrdev/herdr` `skills/herdr/SKILL.md`, herdr 0.9.5 기준)을 원문 그대로 옮긴 것입니다.
로컬 변경은 frontmatter `name: herdr` -> `name: control` 1건뿐입니다.
출처·커밋·갱신 절차는 [`skills/control/references/upstream.md`](skills/control/references/upstream.md).

설치된 herdr 바이너리와 본문이 어긋났는지 확인:

```
bash skills/control/scripts/upstream-drift.selfcheck.sh
```

## 구조

1 repo = 1 plugin. 매니페스트는 루트, 스킬은 평면 `skills/` 하나입니다.

```
.
├── .claude-plugin/{marketplace,plugin}.json   Claude Code
├── .codex-plugin/plugin.json                  Codex
├── .kimi-plugin/plugin.json                   Kimi CLI
├── .hermes-plugin/{plugin.yaml,__init__.py}   Hermes Agent
├── .opencode/plugins/herdr.js                 OpenCode
├── .agents/plugins/marketplace.json           Antigravity
├── gemini-extension.json + GEMINI.md          Gemini CLI
├── skills/control/                            SKILL.md (vendored) + references/ + scripts/
├── docs/skill-guides/ · docs/skill-output/
└── README.md
```

## License

MIT © 2026 dEitY719, 단 `skills/control/` 는 upstream 라이선스인 Apache-2.0 을
따릅니다(`skills/control/LICENSE.txt`, 원저작: herdrdev/herdr).
