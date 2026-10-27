# security-framework

> 공격·테스트를 위한 Kubernetes 기반 GPU 인프라 보안분석 환경 프레임워크

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `security` |
| 담당 기관 (Owner) | 성균관대학교 산학협력단 (`@acryl-fabric/fabric-skku`) |
| 개발 연차 (Year) | 1차 |
| 계획서상 산출물명 (Deliverable) | k8s 기반 인프라 보안분석 환경 프레임워크 코드 (1차) |
| 상태 (Status) | 1차년도 개발 중 (12월 제출, 코드 반입 대기) |

## 개요 (Overview)

공격·테스트를 위한 Kubernetes 기반 GPU 인프라 보안분석 환경 프레임워크

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
