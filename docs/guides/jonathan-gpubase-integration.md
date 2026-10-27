# JONATHAN GPUBASE 연계 활용 가이드 (골격)

> 상태: **골격**. 계획서 p.108 "JONATHAN GPUBASE와 연계한 공개 SW 활용 가이드 제공"에 대응하는 문서입니다.
> 각 절은 해당 기능이 공개되는 연차에 채웁니다.

## 1. 개요

- **JONATHAN GPUBASE Fabric (이 저장소)**: 오픈소스 Core. 토폴로지 인식, 제어 인터페이스, 기본 트래픽 제어
- **JONATHAN GPUBASE**: ㈜아크릴의 상용 AI 인프라 관리 플랫폼. 대규모 클러스터 운영, 고급 정책 관리, 통합 시각화, 운영 자동화, 상용 기술 지원
- 경계: [CORE_EXTENSION.md](../governance/CORE_EXTENSION.md)
- 제품 정보: [JONATHAN GPUBASE](TODO_JONATHAN_URL)

## 2. 어떤 구성을 선택할까

| 상황 | 권장 구성 |
|---|---|
| 연구·PoC, 소규모 RoCEv2 클러스터, 직접 운영 | Core 단독 (`helm install gpubase-fabric ...`) |
| 다수 테넌트·대규모 클러스터 운영, 정책 관리·통합 시각화·기술 지원 필요 | JONATHAN GPUBASE + Core |
| 자체 플랫폼에 일부 기능만 통합 | Core + `api/` 플러그인 SPI·gRPC API |

## 3. Core 단독 설치

TODO(1차년도 말): `deploy/gpubase-fabric` values 예시, 사전 요구사항(SONiC 스위치 gNMI 활성화, DRA 지원 Kubernetes, DCGM).

## 4. JONATHAN GPUBASE와 함께 쓰기

Extension은 Core 차트를 바꾸지 않고 **별도 릴리스로 얹습니다** ([CORE_EXTENSION.md §4](../governance/CORE_EXTENSION.md)).

```bash
helm install gpubase-fabric oci://ghcr.io/acryl-fabric/charts/gpubase-fabric -n gpubase-fabric   # Core
helm install gpubase-ext <JONATHAN GPUBASE 레지스트리>/jonathan-gpubase-fabric-ext -n gpubase-fabric   # Extension (상용)
```

TODO(2차년도):
- 버전 호환 표 (Core 버전 ↔ JONATHAN GPUBASE 버전)
- Core가 노출하는 API(`api/`)와 JONATHAN GPUBASE가 사용하는 범위
- 기존 Core 설치에서 JONATHAN GPUBASE로 전환하는 절차

## 5. 플러그인으로 확장하기

TODO(2차년도): `api/plugin/v1alpha1` 기반 플러그인 작성 예제, 등록·배포 방법.

## 6. 지원

- 오픈소스 Core: GitHub Issues
- 상용 기술 지원: ㈜아크릴 ([acryl.ai](https://www.acryl.ai/))
