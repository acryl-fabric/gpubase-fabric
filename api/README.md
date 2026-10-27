# api

> JONATHAN GPUBASE Fabric의 공개 인터페이스 계약: gRPC proto, CRD, 플러그인 SPI

| 항목 | 내용 |
|---|---|
| 계층 (Layer) | `api` (전 계층 공통) |
| 담당 기관 (Owner) | ㈜아크릴 (ACRYL Inc.) (`@acryl-fabric/fabric-acryl`), 변경 시 영향 기관 합동 리뷰 |
| 개발 연차 (Year) | 1차(인터페이스 정의) → 2·3차(확장) |
| 계획서상 산출물명 (Deliverable) | 개방형 인터페이스 및 제어 API (p.79), 플러그인 구조와 문서화된 인터페이스 (p.108) |
| 상태 (Status) | 1차년도 인터페이스 정의 중 (`v1alpha1`) |

## 개요 (Overview)

이 디렉터리는 다음 세 가지 경계에서 쓰이는 **유일한 계약 지점**입니다.

1. **컴포넌트 ↔ 컴포넌트**: 컨소시엄 기관이 만든 모듈 사이의 연동
2. **Core ↔ Extension**: 상용 Extension(JONATHAN GPUBASE)은 이 디렉터리의 인터페이스만 사용합니다.
   Core는 Extension을 알지 못합니다 ([CORE_EXTENSION.md](../docs/governance/CORE_EXTENSION.md)).
3. **본 과제 ↔ 타 과제**: AI 클라우드 경쟁력강화 사업 내 다른 과제와 연계할 때 쓰는 제어 API

| 경로 | 내용 | 상태 |
|---|---|---|
| [`plugin/v1alpha1`](plugin/v1alpha1) | 플러그인 SPI: in-process Go 인터페이스와 레지스트리 (out-of-process gRPC는 proto로 정의 예정) | 골격 |
| [`proto/gpubase/fabric/v1alpha1`](proto/gpubase/fabric/v1alpha1) | gRPC 제어 API (proto 패키지 `gpubase.fabric.v1alpha1`) | 1차년도 정의 예정 |
| [`crd`](crd) | CRD (API 그룹 `fabric.gpubase.acryl.ai`) | 1차년도 정의 예정 |

### 언어 정책

- **proto(gRPC)가 1급 계약**입니다. 컴포넌트 언어와 관계없이 proto에서 언어별 바인딩(Go, Python 등)을 생성해 씁니다.
- CRD는 Kubernetes API로 접근하므로 언어와 무관합니다.
- 플러그인 SPI는 두 가지 방식을 제공합니다(1차년도 인터페이스 정의 단계에서 확정).
  - **in-process (Go)**: `plugin/v1alpha1`의 Go 인터페이스를 구현해 같은 바이너리에 등록
  - **out-of-process (언어 무관)**: proto로 정의한 플러그인 gRPC 서비스를 구현한 별도 프로세스·컨테이너로 연결

### 버전 정책

- `v1alpha1`: 호환성을 보장하지 않습니다. 변경 시 PR에 영향받는 컴포넌트를 명시해야 합니다.
- `v1beta1` 이후: 하위 호환을 깨는 변경은 새 버전 디렉터리를 추가하는 방식으로만 합니다.
- 이름 규칙은 [NAMING.md](../docs/governance/NAMING.md)를 따릅니다.

## 빌드·실행 (Build & Run)

```bash
make build   # go build ./api/...
make test    # go vet + go test ./api/...
```

## 라이선스 (License)

[MPL-2.0](../LICENSE). 모든 소스 파일 상단에 MPL-2.0 헤더가 필요합니다.
