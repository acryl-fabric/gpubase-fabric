# workload-placement

> 토폴로지를 인지해 GPU 워크로드를 배치·재배치하는 정책 엔진

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `traffic-optimization` |
| 담당 기관 (Owner) | 아주대학교 산학협력단 (`@acryl-fabric/fabric-ajou`) |
| 개발 연차 (Year) | 1차 |
| 계획서상 산출물명 (Deliverable) | 토폴로지 인지 워크로드 배치 및 재배치 정책 엔진 소스코드 (1차) |
| 상태 (Status) | 1차년도 개발 중 (12월 제출, 코드 반입 대기) |

## 개요 (Overview)

토폴로지를 인지해 GPU 워크로드를 배치·재배치하는 정책 엔진

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
