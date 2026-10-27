# traffic-optimization

> **RDMA Traffic Optimization Layer** (RDMA 트래픽 전송 최적화 계층)

적응형 라우팅, 다중경로 전송, 자원 격리·QoS, 관측과 워크로드 배치, 전송 경로 선택, DPU 혼잡제어로 RoCEv2 트래픽의 전송 효율을 높입니다.

| Component | 설명 | 담당 기관 | 연차 | 상태 |
|---|---|---|---|---|
| [`adaptive-routing`](adaptive-routing/README.md) | 토폴로지 변화를 반영해 이기종 스위치에 라우팅 정책을 일관되게 적용·갱신하는 SDN 적응형 라우팅 엔진 | ㈜아크릴 (ACRYL Inc.) | 1차(설계) → 2차(개발) | 1차년도 설계서 작성 중 (12월 제출), 코드는 2차년도 예정 |
| [`dpu-congestion-control`](dpu-congestion-control/README.md) | DPU 기반 고성능 혼잡제어(PCC)와 패킷 스프레이·재정렬 연동 API 및 라이브러리 | 망고부스트코리아(주) | 2차 → 3차 | 2차년도 예정 |
| [`gpu-native-rdma`](gpu-native-rdma/README.md) | GPU 주도 RDMA 통신을 위한 다중 앱 관리·CPU-GPU 하이브리드 QoS 통합 관리 시스템 및 라이브러리 | 아주대학교 산학협력단 | 3차 | 3차년도 예정 |
| [`multipath-transport`](multipath-transport/README.md) | 지연 기반 선행적 혼잡 감지와 RDMA 트래픽 다중경로 전송 제어 엔진 | ㈜아크릴 (ACRYL Inc.) | 2차(개발) → 3차(공개) | 2차년도 예정 |
| [`observability`](observability/README.md) | 네트워크–PCIe 통합 관측 모니터링 툴과 병목 원인 분류 모듈 | 아주대학교 산학협력단 | 1차 | 1차년도 개발 중 (12월 제출, 코드 반입 대기) |
| [`path-selection`](path-selection/README.md) | 메시지 크기와 노드 자원 상태에 따라 GDR/Host-staged 전송 경로를 동적으로 선택하는 엔진 | 아주대학교 산학협력단 | 2차 | 2차년도 예정 |
| [`qos-isolation`](qos-isolation/README.md) | 테넌트·워크로드 단위 RNIC 자원 격리와 최소 보장·최대 제한·우선순위 QoS 제어 | ㈜아크릴 (ACRYL Inc.) | 1차(설계) → 2차(개발) → 3차(검증) | 1차년도 설계서 작성 중 (12월 제출) |
| [`workload-placement`](workload-placement/README.md) | 토폴로지를 인지해 GPU 워크로드를 배치·재배치하는 정책 엔진 | 아주대학교 산학협력단 | 1차 | 1차년도 개발 중 (12월 제출, 코드 반입 대기) |

컴포넌트 규칙은 [COMPONENT_CONTRACT.md](../docs/governance/COMPONENT_CONTRACT.md)를 따릅니다.
