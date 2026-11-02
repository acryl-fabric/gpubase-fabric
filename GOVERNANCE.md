# 거버넌스 (Governance)

이 문서는 JONATHAN GPUBASE Fabric에서 **누가 무엇을 결정하는지**를 정합니다. 기여 절차는
[CONTRIBUTING.md](CONTRIBUTING.md), 참여자 명단은 [MAINTAINERS.md](MAINTAINERS.md), 행동 규범은
[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)를 따릅니다.

이 프로젝트는 과학기술정보통신부·IITP 과제(RS-2026-25525457, 2026-04 ~ 2028-12)로 개발되며, 주관기관 ㈜아크릴이
저장소를 유지관리합니다. 과제 협약상 책임이 주관기관에 있으므로 최종 결정권도 주관기관에 둡니다.

## 1. 역할

| 역할 | 누구 | 권한과 책임 |
|---|---|---|
| 기여자 (Contributor) | 이슈나 PR을 올리는 누구나 (외부 기여자 포함) | 이슈 제기, PR 제안, 리뷰 코멘트 |
| 컴포넌트 메인테이너 (Component Maintainer) | 각 기관 팀(`fabric-<기관>`) 구성원. 경로는 [CODEOWNERS](.github/CODEOWNERS)로 지정 | 담당 경로의 PR 승인, 이슈 분류, 컴포넌트 README와 산출물 기록 유지 |
| 프로젝트 메인테이너 (Project Maintainer) | 주관기관 팀 `fabric-acryl` | 공통 경로(`api/`, `libs/`, `deploy/`, `hack/`, `.github/`, `docs/`) 승인, 저장소 설정, 릴리스, 분쟁 조정, 이 문서 개정 |

- 기관 팀 구성원은 각 기관의 연구책임자가 지정하고, 프로젝트 메인테이너가 팀에 추가합니다.
- 외부 기여자도 의미 있는 기여가 이어지면 해당 컴포넌트 메인테이너의 추천으로 리뷰어나 메인테이너가 될 수 있습니다.
- 6개월 이상 활동이 없는 구성원은 소속 기관과 협의해 명단에서 내립니다(emeritus로 기록).

## 2. 의사결정

기본은 **PR 기반 합의(lazy consensus)** 입니다. 필요한 승인을 받고 반대 의견이 없으면 머지합니다.

| 변경 유형 | 필요한 승인 | 비고 |
|---|---|---|
| 한 컴포넌트 내부 변경 | 해당 기관 팀 1명 | 대부분의 PR |
| 여러 기관 경로를 건드리는 변경 | 관련 기관 팀 각 1명 | CODEOWNERS가 자동 요청 |
| `api/` 계약 추가·변경, `libs/` 변경 | `fabric-acryl` 1명 + 영향받는 기관 확인 | "기관 간 연동 이슈"로 먼저 논의 |
| 새 컴포넌트 추가, 컴포넌트 합치기·나누기·이름 변경 | 해당 기관 팀 + `fabric-acryl` | CODEOWNERS와 `docs/deliverables/` 갱신 포함 |
| Core–Extension 경계가 애매한 기능 | `fabric-acryl` 결정 | [CORE_EXTENSION.md](docs/governance/CORE_EXTENSION.md) §3에 기록 |
| 거버넌스·라이선스·NAMING 문서, CI 필수 체크 변경 | `fabric-acryl` + 모든 기관에 공지, 7일 의견 기간 | 긴급 보안 조치는 예외 |
| 보안 취약점 대응 | `fabric-acryl` | [SECURITY.md](SECURITY.md)에 따라 비공개로 처리 |

### 의견이 맞지 않을 때

1. 해당 PR이나 이슈에서 근거(측정값, 계획서 조항, 문서 규칙)를 들어 논의합니다.
2. 결론이 나지 않으면 `status/blocked` 라벨을 달고 컨소시엄 정기 회의 안건으로 올립니다.
3. 회의에서도 합의가 안 되면 프로젝트 메인테이너(`fabric-acryl`)가 결정하고, 결정과 이유를 이슈에 남깁니다.

## 3. 회의와 기록

- 컨소시엄 정기 회의에서 저장소 관련 결정이 나오면 GitHub 이슈나 문서 PR로 옮겨 기록합니다. 저장소 밖에서만 남은 결정은 효력이 없는 것으로 봅니다.
- 회의록 중 고객 정보, 상용(Extension) 계획, 미공개 특허 내용은 저장소에 올리지 않습니다.

## 4. 릴리스

- 버전은 [Semantic Versioning](https://semver.org/)을 따르며, 과제 기간에는 `0.x`를 씁니다. 연차 말에 그해 공개 산출물을 묶어 릴리스합니다(예: 1차년도 `v0.1.0`).
- `v*` 태그는 프로젝트 메인테이너가 붙입니다. 태그를 붙이면 `release.yml`이 이미지와 Helm 차트를 게시합니다([CI_CD.md](docs/governance/CI_CD.md)).
- `api/`의 `v1alpha1`은 바뀔 수 있으며, 바꿀 때는 PR과 릴리스 노트에 명시합니다.

## 5. 문서 개정

이 문서는 §2의 "거버넌스 문서 변경" 절차로 고칩니다. 과제 종료(2028-12) 이후의 운영 방식은 3차년도 중 이 문서에 정합니다.
