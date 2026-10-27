# testbed

> RoCEv2 GPU 클러스터 실험 인프라 구성 절차·검증 스크립트·보고서 (내부 주소·자격증명 제외)

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `field-test` |
| 담당 기관 (Owner) | ㈜아크릴 (ACRYL Inc.) (`@acryl-fabric/fabric-acryl`) |
| 개발 연차 (Year) | 1차 → 3차 |
| 계획서상 산출물명 (Deliverable) | RoCEv2 GPU 클러스터 확장성 실험 인프라 구축 완료 보고서 (1차), 확장 인프라 부하 테스트 실증 완료 보고서 (3차) |
| 상태 (Status) | 1차년도 보고서 작성 중 (12월 제출) |

## 개요 (Overview)

RoCEv2 GPU 클러스터 실험 인프라 구성 절차·검증 스크립트·보고서 (내부 주소·자격증명 제외)

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
