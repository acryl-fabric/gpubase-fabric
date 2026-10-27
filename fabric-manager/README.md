# fabric-manager

> **Network Fabric Control & Operations Layer** (네트워크 패브릭 제어·운영 계층)

범용 이더넷 스위치(SONiC)와 GPU 노드 자원을 표준 인터페이스(gNMI/gNOI, Kubernetes DRA)로 제어하고, 토폴로지와 가상 패브릭을 관리합니다.

| Component | 설명 | 담당 기관 | 연차 | 상태 |
|---|---|---|---|---|
| [`dashboard`](dashboard/README.md) | 패브릭 상태를 보여주는 통합 운영 대시보드 프로토타입 (기본 관제 화면) | ㈜아크릴 (ACRYL Inc.) | 1차 | 1차년도 개발 중 (12월 제출) |
| [`node-resource-manager`](node-resource-manager/README.md) | Kubernetes DRA와 DCGM 기반으로 GPU·NIC 등 노드 자원을 통합 제어·관제하는 엔진 | ㈜아크릴 (ACRYL Inc.) | 1차(설계·골격) → 2차(고도화) | 1차년도 설계·골격 구현 중 |
| [`switch-manager`](switch-manager/README.md) | SONiC 기반 범용 이더넷 스위치를 gNMI/gNOI 표준 인터페이스로 제어·관제하는 엔진 | ㈜아크릴 (ACRYL Inc.) | 1차(설계·골격) → 2차(고도화) → 3차(호환성 확장) | 1차년도 설계·골격 구현 중 |
| [`topology-engine`](topology-engine/README.md) | SDN 기반으로 GPU 클러스터의 물리·논리 토폴로지를 인식하고 그래프 모델로 제공하는 엔진 | ㈜아크릴 (ACRYL Inc.) | 1차(설계) → 2차(개발) | 2차년도 예정 |
| [`virtual-fabric`](virtual-fabric/README.md) | VXLAN/GENEVE 오버레이 기반으로 테넌트별 RoCEv2 가상 패브릭을 구성·격리하는 엔진 | ㈜아크릴 (ACRYL Inc.) | 2차 | 2차년도 예정 |

컴포넌트 규칙은 [COMPONENT_CONTRACT.md](../docs/governance/COMPONENT_CONTRACT.md)를 따릅니다.
