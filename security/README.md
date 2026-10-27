# security

> **Security Layer** (보안 계층)

GPU 클러스터 인프라의 위협 모델링, 취약점 검증, 멀티테넌트 RDMA 접근제어, 보안 관제를 다룹니다.

| Component | 설명 | 담당 기관 | 연차 | 상태 |
|---|---|---|---|---|
| [`access-control`](access-control/README.md) | 멀티테넌트 RDMA 동적 ACL·보안 필터링과 하드웨어 기반(CVM) 고신뢰 접근제어 엔진 | 성균관대학교 산학협력단 | 3차 | 3차년도 예정 |
| [`security-framework`](security-framework/README.md) | 공격·테스트를 위한 Kubernetes 기반 GPU 인프라 보안분석 환경 프레임워크 | 성균관대학교 산학협력단 | 1차 | 1차년도 개발 중 (12월 제출, 코드 반입 대기) |
| [`security-monitoring`](security-monitoring/README.md) | 통합 보안 관제 및 무결성 모니터링 시스템과 UI | 성균관대학교 산학협력단 | 3차 | 3차년도 예정 |

계층 공통 문서와 연차 산출물은 [`docs/`](docs/README.md)에 있습니다.

컴포넌트 규칙은 [COMPONENT_CONTRACT.md](../docs/governance/COMPONENT_CONTRACT.md)를 따릅니다.
