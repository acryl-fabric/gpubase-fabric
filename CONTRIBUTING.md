# 기여 가이드 (Contributing)

JONATHAN GPUBASE Fabric은 ㈜아크릴이 주관하고 연세대·성균관대·아주대 산학협력단과 망고부스트코리아가 함께 개발하는
공개SW입니다. 외부 기여도 환영합니다. English contributors: the rules below apply equally; feel free to write PRs in English.

## 1. 시작 전에

- 저장소 구조와 규칙: [README](README.md), [컴포넌트 계약](docs/governance/COMPONENT_CONTRACT.md), [NAMING](docs/governance/NAMING.md)
- **Extension(상용) 코드 반입 금지**: [CORE_EXTENSION.md](docs/governance/CORE_EXTENSION.md)를 먼저 읽어주세요.
- 의존성 라이선스: [LICENSE_POLICY.md](docs/governance/LICENSE_POLICY.md)

## 2. 브랜치

- `main`은 보호 브랜치입니다. 직접 push, force push, 삭제가 막혀 있습니다.
- 작업 브랜치 이름은 `feature/{기관}/{주제}`를 씁니다. 버그 수정은 `fix/{기관}/{주제}`, 문서는 `docs/{기관}/{주제}`.
  - `{기관}`: `acryl`, `yonsei`, `skku`, `ajou`, `mangoboost`, 외부 기여자는 `ext`
  - 예: `feature/ajou/pcie-bottleneck-classifier`
- 컨소시엄 기관은 이 저장소에 직접 브랜치를 만들고, 외부 기여자는 포크에서 PR을 엽니다.

## 3. 커밋

- **Conventional Commits** 형식을 씁니다: `<type>(<scope>): <요약>`
  - type: `feat`, `fix`, `docs`, `test`, `refactor`, `perf`, `build`, `ci`, `chore`
  - scope: 컴포넌트 이름(예: `switch-manager`, `observability`, `api`)
  - 예: `feat(observability): add PCIe bandwidth collector`
- **DCO 서명 필수**: `git commit -s`로 커밋하면 `Signed-off-by: 이름 <이메일>`이 붙습니다. 서명은 [Developer Certificate of Origin](https://developercertificate.org/)에 동의한다는 뜻입니다. `dco` 체크가 누락을 막습니다.
- **커밋 이메일은 소속 기관 이메일**을 씁니다(예: `@yonsei.ac.kr`). 기관별 공개SW 실적(커밋 수)을 이메일 도메인으로 집계합니다.
  ```bash
  git config user.email "you@your-institution.ac.kr"
  ```
  GitHub 계정 설정의 Emails에 같은 주소를 추가해야 커밋이 계정과 연결됩니다.
- 의미 없는 WIP 커밋(`wip`, `fix typo`, `tmp` 등)은 PR 전에 `git rebase -i`로 정리해 주세요. 저장소는 squash merge를 쓰지 않으므로 커밋이 그대로 `main`에 남습니다.

## 4. 소스 파일 헤더

새 소스 파일 상단에 MPL-2.0 헤더를 넣습니다. 저작권자는 소속 기관으로 바꿔도 됩니다.

```go
// Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
// SPDX-License-Identifier: MPL-2.0
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
```

다른 언어용은 [hack/boilerplate](hack/boilerplate/README.md)에 있습니다. 누락되면 `mpl-header` 체크가 경고합니다.

## 5. 컴포넌트 계약

- 새 컴포넌트: `hack/new-component.sh --help`처럼 스크립트를 사용하고 `.github/CODEOWNERS`에 추가합니다.
- 모든 컴포넌트는 `README.md`, `Makefile`(`build`, `test`), `tests/`가 필요합니다. 배포 대상은 `Dockerfile`, `image` 타깃, `chart/`도 필요합니다.
- PR 전에 로컬에서 확인합니다.
  ```bash
  make verify                       # 계약·헤더 검사
  make -C <component> build test    # 변경한 컴포넌트
  ```

## 6. Pull Request와 2단계 리뷰

1. PR 템플릿의 항목(설계 의도, 성능 영향, 운영 리스크, 테스트 방법)을 채웁니다.
2. **1차: LLM 리뷰**. `claude-review`가 [CLAUDE.md](CLAUDE.md) 기준으로 자동 코멘트를 남깁니다. 권고 사항이며 머지를 막지 않지만, 지적에 답변하거나 반영해 주세요.
3. **2차: CODEOWNERS 리뷰**. 변경 경로를 담당하는 기관 팀의 승인 1건이 필요합니다. 여러 기관 경로를 건드리면 각 기관 승인이 필요합니다.
4. 필수 체크 `ci`, `dco`, `gitleaks`가 통과해야 머지할 수 있습니다. 새 커밋을 push하면 기존 승인은 무효가 됩니다.
5. 머지 방식은 merge commit 또는 rebase merge입니다.

## 7. 금지 사항

- Extension(JONATHAN GPUBASE 상용) 코드·설계, 고객사 이름·데이터
- 내부 IP, 호스트명, 계정, 토큰, kubeconfig 등 환경 정보 (값이 필요하면 `<PLACEHOLDER>` 사용)
- 금지 라이선스(GPL, AGPL, SSPL, 비상업 조건) 코드와 의존성
- 대용량 바이너리, 모델 가중치, 데이터셋

## 8. 이슈

버그, 기능 제안, 테스트베드 사용 요청, 기관 간 연동 이슈 템플릿을 사용해 주세요.
보안 취약점은 공개 이슈로 올리지 말고 [SECURITY.md](SECURITY.md) 절차를 따릅니다.

## 9. 사사표기

이 저장소의 성과를 논문·발표에 사용할 때는 README의 [Acknowledgement](README.md#ack) 문구를 사용합니다.
