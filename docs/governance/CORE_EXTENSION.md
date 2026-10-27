# Core–Extension 경계 (초안)

> 상태: **초안**. "확인 필요" 항목은 주관기관(아크릴) 결정 후 확정합니다.
> 근거: 연구개발계획서 p.78~79(Core–Extension 분리 구조를 통한 단계적 상용화 전략), p.108(Core-Extension 분리 구조 기반의 전략적 라이선스 운영)

## 1. 원칙

| 구분 | Core (이 저장소, MPL-2.0) | Extension (JONATHAN GPUBASE, 상용) |
|---|---|---|
| 계획서 정의 (p.108) | 토폴로지 인식, 제어 인터페이스, 기본 트래픽 제어 등 공통 핵심 기능 | 대규모 클러스터 운영, 고급 정책 관리, 통합 시각화, 상용 기술 지원 |
| 계획서 정의 (p.79) | 토폴로지 인식, 라우팅 정책 적용, 트래픽 제어 인터페이스 | 고급 정책 관리, 통합 시각화, **운영 자동화**, 상용 지원 |
| 저장소 | GitHub `acryl-fabric/gpubase-fabric` | 사내 GitLab (비공개) |
| 의존 방향 | Extension을 참조하지 않음 | Core를 Git Submodule로 포함하고 `api/`만 사용 |

1. **의존 방향은 Extension → Core 단방향입니다.** Core 코드, 차트, 문서에 Extension의 패키지 경로, 이미지, 엔드포인트, 설정 키가 나타나면 안 됩니다.
2. **확장점은 `api/`의 플러그인 SPI와 공개 API로만 제공합니다.** Extension 전용 hook이나 숨은 플래그를 Core에 추가하지 않습니다.
3. Core 단독으로 설치하고 동작해야 합니다. Extension이 없다고 기능이 깨지면 안 됩니다.
4. Extension에서 검증된 일반 기능을 Core로 환류할 때(p.108 "공개 SW Core로 환류")는 일반 PR로 올리고, 고객 정보와 Extension 전용 설정을 제거합니다.

## 2. 컴포넌트별 배치 (현재 안)

| 컴포넌트 | 배치 | 비고 |
|---|---|---|
| `fabric-manager/*` (switch, node, topology, virtual-fabric) | Core | 계획서상 공개 산출물 |
| `fabric-manager/dashboard` | Core (프로토타입·기본 관제) | 항목 (a) |
| `traffic-optimization/*` | Core | `qos-isolation`은 항목 (e) |
| `data-acceleration/*`, `security/*` | Core | 공동기관 공개 산출물 |
| `deploy/` 통합 배포 패키지 | Core만 포함 | 항목 (b) |
| 데이터 트래픽 가시화 엔진 | Extension 후보 | 항목 (c) |

## 3. 확인 필요 항목

| ID | 쟁점 | 제안 | 상태 |
|---|---|---|---|
| (a) | 1차 공개 산출물 "통합 운영 대시보드 프로토타입" vs Extension "통합 시각화" | 프로토타입과 기본 관제 화면(상태·토폴로지·기본 메트릭 조회)은 Core. 고도화된 통합 가시화(다계층 VM-to-VM 매핑, 장애 전파 분석 등)는 Extension | **확인 필요** |
| (b) | 3차 "대규모·고성능 AI 인프라용 GPU 클러스터 네트워크 패브릭 관리 오픈소스 플랫폼 통합 배포 패키지" vs Extension "대규모 클러스터 운영" | 배포 패키지(`deploy/gpubase-fabric`)에는 Core 컴포넌트만 포함. 대규모 운영 기능은 Extension 쪽 패키지에서 추가 | **확인 필요** |
| (c) | 2·3차 "RDMA 네트워크 기반의 데이터 트래픽 가시화 엔진"은 공개 산출물 목록(p.59~63)에 없음 | Extension 후보. 다만 Core 대시보드에 필요한 기본 플로우 수집 API는 `api/`에 둘지 결정 필요 | **확인 필요** |
| (d) | 의존 방향과 확장 방식 | Extension → Core 단방향. 확장점은 `api/` 플러그인 SPI로만 제공 | 제안 확정 대기 |
| (e) | 2차 "네트워크 자원 격리 및 QoS 제어 엔진"은 개발 항목에 있으나, 공개 산출물은 1차 설계서와 3차 검증 보고서뿐이고 엔진 소스코드가 공개 목록에 없음 | 기본 격리·QoS 제어(=기본 트래픽 제어)는 Core로 공개. 고급 정책 관리는 Extension | **확인 필요** |
| (f) | p.79는 Extension에 "운영 자동화"를 포함하고 p.108은 포함하지 않음 | 계획서상 Extension 범위를 p.79 기준(운영 자동화 포함)으로 해석할지 결정 필요 | **확인 필요** |

## 4. 리뷰 체크리스트

PR 리뷰에서 다음 중 하나라도 해당하면 경계 위반으로 봅니다.

- Extension, 사내 GitLab, 고객사 환경을 가리키는 import, URL, 이미지, 설정 키
- 상용 기능 이름(예: 고급 정책 관리 기능)의 구현 또는 상세 설계
- `api/`를 거치지 않는 Extension 전용 분기(`if enterprise { ... }` 등)
- 고객 데이터, 고객사 이름, 내부 운영 수치
