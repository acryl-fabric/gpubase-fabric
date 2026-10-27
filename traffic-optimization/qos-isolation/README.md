# qos-isolation

> 테넌트·워크로드 단위 RNIC 자원 격리와 최소 보장·최대 제한·우선순위 QoS 제어

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `traffic-optimization` |
| 담당 기관 (Owner) | ㈜아크릴 (ACRYL Inc.) (`@acryl-fabric/fabric-acryl`) |
| 개발 연차 (Year) | 1차(설계) → 2차(개발) → 3차(검증) |
| 계획서상 산출물명 (Deliverable) | RDMA 자원 격리 정책 모델·아키텍처 설계서 (1차, docs/), 네트워크 자원 격리 기반 QoS 검증 실험 결과 보고서 (3차) |
| 상태 (Status) | 1차년도 설계서 작성 중 (12월 제출) |

## 개요 (Overview)

테넌트·워크로드 단위 RNIC 자원 격리와 최소 보장·최대 제한·우선순위 QoS 제어

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
