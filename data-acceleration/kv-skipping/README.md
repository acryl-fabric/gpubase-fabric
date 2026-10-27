# kv-skipping

> DPU 오프로딩으로 맥락 정보 기반 KV 전송을 사전 프루닝하는 KV 스키핑 모듈

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `data-acceleration` |
| 담당 기관 (Owner) | 연세대학교 산학협력단 (`@acryl-fabric/fabric-yonsei`) |
| 개발 연차 (Year) | 2차 |
| 계획서상 산출물명 (Deliverable) | DPU 기반 맥락 인지 KV 스키핑 모듈 소스코드 (2차) |
| 상태 (Status) | 2차년도 예정 |

> 📌 이 폴더 구성은 연구개발계획서 기준 **잠정안**입니다. 첫 코드 반입 시 담당 기관이 같은 계층 안에서 합치기·나누기·이름 바꾸기를 할 수 있습니다. → [기존 코드 반입 가이드](../../docs/guides/importing-existing-code.md)

## 개요 (Overview)

DPU 오프로딩으로 맥락 정보 기반 KV 전송을 사전 프루닝하는 KV 스키핑 모듈

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
