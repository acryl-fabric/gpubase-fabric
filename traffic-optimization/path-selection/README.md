# path-selection

> 메시지 크기와 노드 자원 상태에 따라 GDR/Host-staged 전송 경로를 동적으로 선택하는 엔진

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `traffic-optimization` |
| 담당 기관 (Owner) | 아주대학교 산학협력단 (`@acryl-fabric/fabric-ajou`) |
| 개발 연차 (Year) | 2차 |
| 계획서상 산출물명 (Deliverable) | NIC-GPU 전송 경로별 비용 모델 설계서 (2차), 동적 전송 경로 선택 엔진 소스코드 (2차), Host-staged 전송 경로 파이프라이닝 및 pool 메커니즘 소스코드 (2차) |
| 상태 (Status) | 2차년도 예정 |

## 개요 (Overview)

메시지 크기와 노드 자원 상태에 따라 GDR/Host-staged 전송 경로를 동적으로 선택하는 엔진

<!-- 설계 배경, 주요 기능, 다른 컴포넌트·api/ 와의 관계를 기술합니다. -->

## 빌드·실행 (Build & Run)

```bash
make build   # 빌드
make test    # 테스트 (tests/ 포함)
```

## 라이선스 (License)

[MPL-2.0](https://github.com/acryl-fabric/gpubase-fabric/blob/main/LICENSE).
모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다 ([hack/boilerplate](https://github.com/acryl-fabric/gpubase-fabric/tree/main/hack/boilerplate)).
