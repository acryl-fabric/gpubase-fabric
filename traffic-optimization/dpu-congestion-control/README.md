# dpu-congestion-control

> DPU 기반 고성능 혼잡제어(PCC)와 패킷 스프레이·재정렬 연동 API 및 라이브러리

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `traffic-optimization` |
| 담당 기관 (Owner) | 망고부스트코리아(주) (`@acryl-fabric/fabric-mangoboost`) |
| 개발 연차 (Year) | 2차 → 3차 |
| 계획서상 산출물명 (Deliverable) | DPU 기반 PCC 엔진 API 문서 및 라이브러리 (2차), 혼잡제어/패킷분산 기능을 포함한 고성능 RoCEv2 DPU 설계문서 (2차) |
| 상태 (Status) | 2차년도 예정 |

## 개요 (Overview)

DPU 기반 고성능 혼잡제어(PCC)와 패킷 스프레이·재정렬 연동 API 및 라이브러리

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
