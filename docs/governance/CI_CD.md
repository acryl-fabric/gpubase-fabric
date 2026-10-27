# CI/CD 파이프라인 설계

![pipeline](../images/workflow.svg)

## 1. 원칙

- GitHub Actions는 **GitHub 호스팅 러너만** 사용합니다. self-hosted runner는 쓰지 않습니다(공개 저장소에서 포크 PR이 내부망 러너를 실행하는 위험 차단).
- 테스트베드 접근(내부망, 자격증명)은 GitHub에 두지 않습니다. 배포는 GitLab이 담당합니다.
- 워크플로 권한은 최소로 둡니다(`permissions:`를 job마다 명시).
- `main` 보호 규칙과 포크 PR 승인 정책은 `hack/apply-ruleset.sh`로 적용합니다(재실행 가능).

## 2. GitHub CI (이 저장소)

| 워크플로 | 트리거 | 하는 일 | 필수 체크 |
|---|---|---|---|
| `ci.yml` | PR, `main` push | 변경 컴포넌트를 경로로 감지해 `make build test` 실행(컴포넌트 파일을 보고 Go·Python·Node·Helm 툴체인 자동 설치), 컴포넌트 계약 검사. 집계 job 이름 `ci` | **`ci`** |
| `dco.yml` | PR | 모든 커밋의 `Signed-off-by`가 작성자와 일치하는지 확인 | **`dco`** |
| `gitleaks.yml` | PR, `main` push | 시크릿 스캔 (gitleaks CLI) | **`gitleaks`** |
| `claude-review.yml` | PR (같은 저장소 브랜치만) | LLM 1차 리뷰. [CLAUDE.md](../../CLAUDE.md) 기준으로 PR 코멘트 작성 | 아니요 (권고) |
| `mpl-header.yml` | PR | 새 소스 파일의 MPL-2.0 헤더 확인. 누락 시 경고만 | 아니요 |
| `links.yml` | Markdown 변경 PR, 매주 | 문서 링크 검사 | 아니요 |
| `images.yml` | `main` push | 변경된 배포 대상 컴포넌트 이미지 GHCR 게시 (태그 `<sha>`, `main`) | — |
| `release.yml` | `v*` 태그 | 전체 배포 대상 이미지 버전 태그 게시 + umbrella Helm 차트를 `oci://ghcr.io/acryl-fabric/charts`에 게시 | — |

### 흐름

1. 기여자가 `feature/{기관}/{주제}` 브랜치에서 PR을 엽니다.
2. `ci`, `dco`, `gitleaks`가 실행되고 `claude-review`가 코멘트를 답니다.
3. CODEOWNERS 기관 팀이 리뷰하고 승인합니다(필수 1명, 새 push 시 기존 승인 무효).
4. merge commit 또는 rebase merge로 `main`에 들어갑니다(squash 비활성: 기관별 커밋 이력 보존).
5. `images.yml`이 변경된 컴포넌트 이미지를 게시합니다.

## 3. GitLab CD (사내, 구현 예정)

> 상태: **구현 예정** (1차년도 말~2차년도 초). 사내 GitLab에서 관리하며 이 저장소에는 설계만 기록합니다.

| 단계 | 내용 |
|---|---|
| 변경 감지 | GitHub `main` 변경 감지(GitLab pull mirror 또는 주기적 폴링). Extension 저장소의 Core submodule 포인터 갱신 |
| 배포 | GHCR의 `<sha>` 태그 이미지와 Extension을 테스트베드 클러스터에 Helm으로 배포 |
| 벤치마크 | RoCEv2 성능 메트릭(처리량, 지연, NCCL 집합통신 대역폭 등) 측정 |
| 결과 보고 | GitHub REST API로 해당 커밋에 결과 요약 코멘트 게시. 내부 주소·호스트명은 제외 |

- GitHub에 쓰는 토큰은 커밋 코멘트 권한만 있는 fine-grained token 또는 GitHub App으로 제한하고 GitLab에만 보관합니다.
- 벤치마크 결과 요약 형식은 2차년도 시작 전에 `field-test/scenarios/`에 정의합니다.
