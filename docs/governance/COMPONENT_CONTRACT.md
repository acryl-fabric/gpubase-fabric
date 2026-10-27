# 컴포넌트 계약 (Component Contract)

여러 기관이 각자 언어와 일정으로 개발하면서도 한 저장소에서 같은 방식으로 빌드·테스트·배포하기 위한 최소 규칙입니다.
CI의 `contract` 단계(`hack/verify-contract.sh`)가 자동으로 검사합니다.

## 1. 컴포넌트의 정의

- `api/`는 하나의 컴포넌트입니다.
- 계층 디렉터리(`fabric-manager/`, `traffic-optimization/`, `data-acceleration/`, `security/`, `field-test/`)의
  **직계 하위 디렉터리**가 각각 컴포넌트입니다. 예외로 `docs/`는 계층 공통 문서 폴더입니다.
- `libs/<언어>/<이름>/`도 각각 컴포넌트(공용 라이브러리)입니다.
- 새 컴포넌트는 `hack/new-component.sh`로 만들고 `.github/CODEOWNERS`에 추가합니다.
  템플릿은 `--type basic`(모든 언어), `go-service`, `python-service`가 있습니다.
- 미리 만들어 둔 컴포넌트 폴더는 계획서 기준 **잠정안**입니다. 첫 코드 반입 때 담당 기관이 **같은 계층 안에서**
  합치기·나누기·이름 바꾸기를 할 수 있습니다. 기준은 실행·배포 단위이며, CODEOWNERS·산출물 색인·계층 README를 함께 고칩니다.
  절차: [기존 코드 반입 가이드](../guides/importing-existing-code.md)

## 2. 모든 컴포넌트 필수 항목

| 항목 | 요구사항 |
|---|---|
| `README.md` | 다음 항목 필수: **개요 / 담당 기관 / 개발 연차 / 계획서상 산출물명 / 상태 / 빌드·실행 / 라이선스** |
| `Makefile` | `build`, `test` 타깃. GitHub 호스팅 러너(`ubuntu-latest`)에서 추가 설정 없이 성공해야 함 |
| `tests/` | 테스트 코드 위치. 아직 테스트가 없으면 README만 둠 |
| 라이선스 헤더 | 모든 소스 파일 상단에 MPL-2.0 헤더 ([hack/boilerplate](../../hack/boilerplate/README.md)) |

아직 코드가 없는 컴포넌트는 README의 상태를 **"N차년도 예정"**으로 적고, `Makefile`은 템플릿의 placeholder 타깃을 그대로 둡니다.

## 3. 배포 대상 컴포넌트 추가 필수 항목

`Dockerfile`이 있는 컴포넌트를 **배포 대상**으로 봅니다.

| 항목 | 요구사항 |
|---|---|
| `Dockerfile` | 빌드 컨텍스트는 저장소 루트. OCI 라벨은 [NAMING.md](NAMING.md)를 따름. 비루트 사용자로 실행 |
| `Makefile` `image` 타깃 | `ghcr.io/acryl-fabric/gpubase-fabric/<component>:$(TAG)` 이미지 빌드 |
| `chart/` | Helm 차트. `name`은 컴포넌트 이름, `values.yaml`의 `image.repository`는 위 이미지 경로, 표준 라벨 포함 |
| 헬스체크 | `/healthz` (권장), 메트릭은 `/metrics`에서 `gpubase_fabric_` 접두어로 노출 |

배포 대상 컴포넌트는 `deploy/gpubase-fabric/Chart.yaml`의 `dependencies`에 등록해야 umbrella 차트에 포함됩니다.

## 4. 언어와 기관 자율 영역

이 저장소는 **다국어(polyglot) 모노레포**입니다. 계약은 언어가 아니라 `Makefile` 인터페이스로 정의합니다.

- 언어, 내부 디렉터리 구조, 빌드 도구는 기관이 정합니다(Go, Python, C/C++, Rust, TypeScript, P4 등).
- CI는 컴포넌트 안의 파일을 보고 툴체인을 설치합니다. 그 밖의 도구는 `Makefile`에서 설치합니다.

  | 컴포넌트 안에 있는 파일 | CI가 설치하는 것 |
  |---|---|
  | `*.go`, `go.mod` | Go (컴포넌트 `go.mod`가 있으면 그 버전, 없으면 루트 `go.mod` 버전) |
  | `pyproject.toml`, `requirements*.txt` | Python 3.12 |
  | `package.json` | Node.js 22 |
  | `chart/Chart.yaml` | Helm |
  | 그 밖의 언어(C/C++ 등) | 러너 기본 도구(gcc, make, cmake) 또는 `Makefile`에서 설치 |

- **Go**: 기본은 루트 모듈(`github.com/acryl-fabric/gpubase-fabric`) 하나입니다. 의존성이 무겁거나 버전 충돌이 있는 컴포넌트는 자체 `go.mod`를 둘 수 있습니다.
- **Python**: 컴포넌트마다 `pyproject.toml`과 `.venv`를 둡니다(`python-service` 템플릿 참조).
- 하드웨어 설계물(RTL, FPGA 비트스트림 등)은 공개 범위를 기관이 정하며, 공개하는 경우에도 `Makefile`로 정적 검사나 시뮬레이션 테스트를 제공합니다.

## 5. 컴포넌트 간 공유

- **컴포넌트끼리 직접 import하지 않습니다.** 예를 들어 `traffic-optimization/adaptive-routing`이 `fabric-manager/switch-manager`의 내부 코드를 가져다 쓰면 안 됩니다.
- 같은 언어의 공용 코드는 [`libs/<언어>/<이름>/`](../../libs/README.md)에 둡니다.
- 컴포넌트 간 연동 계약과 언어를 넘는 공유는 [`api/`](../../api/README.md)의 proto(gRPC)·CRD로만 합니다.

## 6. `research/`

논문 재현·실험 코드는 계약을 완화합니다. 필수 항목은 다음 두 가지뿐입니다.

- 하위 폴더마다 `README.md` (논문/실험 정보, 담당 기관, 재현 방법)
- 소스 파일의 MPL-2.0 라이선스 헤더

`research/`는 CI 빌드 대상이 아닙니다. 대용량 데이터·체크포인트는 커밋하지 않고 외부 위치를 README에 링크합니다.

## 7. 금지 사항

- Extension(상용) 코드, 설계, 고객 정보 반입 ([CORE_EXTENSION.md](CORE_EXTENSION.md))
- 내부 IP, 호스트명, 계정, 토큰 등 환경 정보. 값이 필요하면 `<NFS_SERVER_IP>` 같은 placeholder를 씀
- 금지 라이선스 의존성 ([LICENSE_POLICY.md](LICENSE_POLICY.md))
