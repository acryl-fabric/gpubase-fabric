# topology-engine

> SDN 기반으로 GPU 클러스터의 물리·논리 토폴로지를 인식하고 그래프 모델로 제공하는 엔진

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `fabric-manager` |
| 담당 기관 (Owner) | ㈜아크릴 (ACRYL Inc.) (`@acryl-fabric/fabric-acryl`) |
| 개발 연차 (Year) | 1차(설계) → 2차(개발) |
| 계획서상 산출물명 (Deliverable) | SDN 기반 클러스터 토폴로지 인식 엔진 소스코드 (2차), 토폴로지 그래프 모델 및 가상 패브릭 설정·식별자 관리 규격서 (2차) |
| 상태 (Status) | 2차년도 예정 |

## 개요 (Overview)

SDN 기반으로 GPU 클러스터의 물리·논리 토폴로지를 인식하고 그래프 모델로 제공하는 엔진

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
