# switch-manager

> SONiC 기반 범용 이더넷 스위치를 gNMI/gNOI 표준 인터페이스로 제어·관제하는 엔진

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `fabric-manager` |
| 담당 기관 (Owner) | ㈜아크릴 (ACRYL Inc.) (`@acryl-fabric/fabric-acryl`) |
| 개발 연차 (Year) | 1차(설계·골격) → 2차(고도화) → 3차(호환성 확장) |
| 계획서상 산출물명 (Deliverable) | 범용 이더넷 스위치 제어관제 엔진 소스코드 (2차), 이기종 스위치 통합 제어·정책 적용 API/운영 절차서 (3차) |
| 상태 (Status) | 1차년도 설계·골격 구현 중 |

## 개요 (Overview)

SONiC 기반 범용 이더넷 스위치를 gNMI/gNOI 표준 인터페이스로 제어·관제하는 엔진

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
