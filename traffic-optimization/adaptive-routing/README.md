# adaptive-routing

> 토폴로지 변화를 반영해 이기종 스위치에 라우팅 정책을 일관되게 적용·갱신하는 SDN 적응형 라우팅 엔진

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `traffic-optimization` |
| 담당 기관 (Owner) | ㈜아크릴 (ACRYL Inc.) (`@acryl-fabric/fabric-acryl`) |
| 개발 연차 (Year) | 1차(설계) → 2차(개발) |
| 계획서상 산출물명 (Deliverable) | SDN 기반 적응형 라우팅 정책 모델·갱신 절차 설계서 (1차, docs/), SDN 기반 적응형 라우팅 엔진 소스코드 (2차) |
| 상태 (Status) | 1차년도 설계서 작성 중 (12월 제출), 코드는 2차년도 예정 |

## 개요 (Overview)

토폴로지 변화를 반영해 이기종 스위치에 라우팅 정책을 일관되게 적용·갱신하는 SDN 적응형 라우팅 엔진

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
