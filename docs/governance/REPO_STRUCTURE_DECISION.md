# 저장소 구조 결정 (GitHub · GitLab 이원화)

| 항목 | 내용 |
|---|---|
| 결정일 | 2026-10 (1차년도) |
| 결정 | 공개 Core는 GitHub **단일 모노레포**, Extension과 테스트베드 CD는 사내 GitLab. GitLab Extension 저장소가 Core를 **Git Submodule**로 포함 |
| 결정자 | ㈜아크릴 (주관기관) |

## 1. 구조

```text
GitHub (public, MPL-2.0)                      ACRYL internal GitLab (private)
acryl-fabric/gpubase-fabric  ───────────────▶ jonathan-gpubase-fabric-extension
  api/  fabric-manager/  traffic-optimization/   ├── core/   ← git submodule (gpubase-fabric)
  data-acceleration/  security/  field-test/     ├── extension 코드 (상용)
  deploy/  docs/  .github/ (CI, 이미지 게시)       └── CD: 테스트베드 배포·벤치마크
```

- **GitHub**: 컨소시엄 5개 기관이 공동 개발하는 공개 Core. PR, CI, 리뷰, 이미지·차트 게시까지 담당합니다.
- **GitLab**: 아크릴의 비공개 Extension(JONATHAN GPUBASE)과 테스트베드 배포(CD). Core를 submodule로 고정해 버전별로 통합합니다.

## 2. 계획서와의 대응

| 계획서 기술 | 쪽 | 이 구조에서의 구현 |
|---|---|---|
| 사내 GitLab 기반 분산 협력 개발 체계 및 통합 관리 시스템 | p.65 | 사내 GitLab이 Extension 통합, 테스트베드 CD, 기술 자산(이슈 로그, 테스트 스크립트) 축적을 담당 |
| 메인 저장소와 참여기관별 서브 저장소 연계, **Git Submodule** 활용 | p.65, p.107 | GitLab Extension 저장소가 GitHub Core를 submodule로 포함. 기관은 필요하면 자체 작업 저장소에서 개발한 뒤 Core에 PR로 반영 |
| 승인된 PR이 클러스터에 자동 배포되어 RoCEv2 성능 메트릭을 즉시 검증 | p.65 | GitHub CI가 이미지를 GHCR에 게시하고, GitLab CD가 `main` 변경을 감지해 테스트베드에 배포·벤치마크 후 결과를 GitHub 커밋 코멘트로 게시 ([CI_CD.md](CI_CD.md)) |
| Branch Protection Rules, LLM Agent 1차 리뷰 + 합동 리뷰 2단계 품질 게이트 | p.65, p.107 | `main` ruleset, `claude-review` 워크플로(1차, 권고), CODEOWNERS 기관 팀 리뷰(2차, 필수) |
| GitHub 기반 분산 협력 개발 체계, 주관기관 중심 메인 공개 저장소 | p.107 | `acryl-fabric/gpubase-fabric` 1개 저장소 |
| 공개SW 지표: 저장소 1개 3년 운영, 커밋 200, 스타 100 | p.107 | 단일 저장소에 커밋·스타가 모이도록 기관별 저장소를 따로 공개하지 않음 |
| Core-Extension 분리 구조 기반 라이선스 운영 | p.108 | MPL-2.0 파일 단위 copyleft + Extension 별도 저장소 ([CORE_EXTENSION.md](CORE_EXTENSION.md)) |

## 3. 대안과 기각 사유

| 대안 | 기각 사유 |
|---|---|
| 기관별 공개 저장소 5개 + 메인 저장소가 submodule로 묶음 | 공개SW 지표가 "저장소 1개" 기준이라 커밋·스타가 분산됨. submodule 버전 고정 때문에 공동 PR, 경로 기반 CI, CODEOWNERS 리뷰가 어려움 |
| GitLab 단일 저장소에서 개발하고 GitHub에 미러링 | 외부 기여(PR, 이슈, 스타)를 받을 수 없어 공개SW 활성화 목표와 맞지 않음 |
| Core와 Extension을 한 저장소에서 디렉터리로 분리 | 상용 코드 유출 위험. 공개 전환 시 이력 정리가 불가능에 가까움 |

## 4. 연차실적보고서 기재용 문안

> 공개SW 저장소는 주관기관 중심의 GitHub 단일 모노레포(acryl-fabric/gpubase-fabric)로 구축하여 5개 참여기관이 공동 개발하고, 사내 GitLab의 상용 Extension 저장소가 이를 Git Submodule로 포함하는 이원화 구조를 통해 계획서의 Submodule 기반 모듈화·자동 배포 검증·2단계 품질 게이트 체계를 구현하였음.
