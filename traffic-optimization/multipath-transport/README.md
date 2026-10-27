# multipath-transport

> 지연 기반 선행적 혼잡 감지와 RDMA 트래픽 다중경로 전송 제어 엔진

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `traffic-optimization` |
| 담당 기관 (Owner) | ㈜아크릴 (ACRYL Inc.) (`@acryl-fabric/fabric-acryl`) |
| 개발 연차 (Year) | 2차(개발) → 3차(공개) |
| 계획서상 산출물명 (Deliverable) | 선행적 혼잡 감지 및 RDMA 다중 경로 전송 엔진 소스코드 (3차), 선행적 혼잡 회피·다중경로 전송 기반 성능 검증 보고서 (3차) |
| 상태 (Status) | 2차년도 예정 |

## 개요 (Overview)

지연 기반 선행적 혼잡 감지와 RDMA 트래픽 다중경로 전송 제어 엔진

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
