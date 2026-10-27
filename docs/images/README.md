# Images

| File | Content | Source |
|---|---|---|
| `arch.svg` | Layered architecture (Core / api / Extension boundary) | `python3 hack/diagrams/arch.py` |
| `workflow.svg` | GitHub CI → review → GHCR, GitLab testbed CD loop | `python3 hack/diagrams/workflow.py` |
| `consortium.png` | Consortium and funding logos banner (README footer) | `hack/diagrams/consortium.sh` (source `hack/diagrams/consortium.html`) |

Edit the generator scripts, not the SVG files, and re-run them from the repository root.
A final designer-made `arch.png` may replace `arch.svg` in the README later.
