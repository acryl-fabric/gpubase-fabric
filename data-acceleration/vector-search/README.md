# vector-search

> GPU와 DPU가 역할을 분담하는 벡터 탐색 엔진

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `data-acceleration` |
| 담당 기관 (Owner) | 연세대학교 산학협력단 (`@acryl-fabric/fabric-yonsei`) |
| 개발 연차 (Year) | 3차 |
| 계획서상 산출물명 (Deliverable) | GPU–DPU 역할 분담 기반 벡터 탐색 엔진 소스코드 (3차) |
| 상태 (Status) | 3차년도 예정 |

> 📌 이 폴더 구성은 연구개발계획서 기준 **잠정안**입니다. 첫 코드 반입 시 담당 기관이 같은 계층 안에서 합치기·나누기·이름 바꾸기를 할 수 있습니다. → [기존 코드 반입 가이드](../../docs/guides/importing-existing-code.md)

## 개요 (Overview)

GPU와 DPU가 역할을 분담하는 벡터 탐색 엔진

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
