# Component template

`hack/new-component.sh` renders these files into a new component directory.

| Directory | Used by `--type` | Content |
|---|---|---|
| `common/` | all | `README.md`, placeholder `Makefile`, `tests/` |
| `go-service/` | `go-service` | Go entrypoint (`cmd/`), `Makefile`, `Dockerfile` |
| `python-service/` | `python-service` | Python package (`pyproject.toml`, `src/`), pytest, `Makefile`, `Dockerfile` |
| `chart/` | `go-service`, `python-service` | Helm chart rendered into `<component>/chart/` |

Placeholders: `__NAME__`, `__PYNAME__` (name with `_`), `__PATH__`, `__ROOT__`, `__LAYER__`,
`__ORG__`, `__TEAM__`, `__YEAR__`, `__DELIVERABLE__`, `__STATUS__`, `__SUMMARY__`.

Components in other languages (C/C++, Rust, TypeScript, P4, …) start from `--type basic` and
implement `build` / `test` (and `image` if deployable) themselves. See
[COMPONENT_CONTRACT.md](../../../docs/governance/COMPONENT_CONTRACT.md).
