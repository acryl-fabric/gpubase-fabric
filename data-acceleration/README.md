# data-acceleration

> **AI Data Processing Acceleration Layer** (AI 데이터 처리 가속 계층)

DPU 오프로딩으로 LLM 추론의 KV 캐시 전송과 연산을 줄여 GPU–네트워크 데이터 경로를 가속합니다.

| Component | 설명 | 담당 기관 | 연차 | 상태 |
|---|---|---|---|---|
| [`kv-skipping`](kv-skipping/README.md) | DPU 오프로딩으로 맥락 정보 기반 KV 전송을 사전 프루닝하는 KV 스키핑 모듈 | 연세대학교 산학협력단 | 2차 | 2차년도 예정 |
| [`prefix-offload`](prefix-offload/README.md) | episodic 메타데이터 기반 KV prefix 재사용·연산 생략을 DPU로 오프로딩하는 모듈 | 연세대학교 산학협력단 | 2차 | 2차년도 예정 |
| [`semantic-cache`](semantic-cache/README.md) | RDMA 기반 Semantic 캐시 공유와 DPU 중심 캐시 관리·재분배 모듈 | 연세대학교 산학협력단 | 3차 | 3차년도 예정 |
| [`vector-search`](vector-search/README.md) | GPU와 DPU가 역할을 분담하는 벡터 탐색 엔진 | 연세대학교 산학협력단 | 3차 | 3차년도 예정 |

계층 공통 문서와 연차 산출물은 [`docs/`](docs/README.md)에 있습니다.

컴포넌트 규칙은 [COMPONENT_CONTRACT.md](../docs/governance/COMPONENT_CONTRACT.md)를 따릅니다.
