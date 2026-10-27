# 기존 코드 반입 가이드

기관이 이미 개발하던 코드를 이 저장소에 넣는 방법입니다.
규칙의 근거는 [COMPONENT_CONTRACT.md](../governance/COMPONENT_CONTRACT.md)입니다.

## 1. 컴포넌트 폴더는 잠정안입니다

미리 만들어 둔 컴포넌트 폴더는 연구개발계획서의 엔진·산출물 단위로 나눈 **잠정안**입니다.
첫 코드 반입 때 기관이 자기 코드에 맞게 정합니다.

- **바꿀 수 있는 것**: 같은 계층 안에서 컴포넌트를 합치기, 나누기, 이름 바꾸기. 폴더 안의 구조, 언어, 빌드 도구
- **지켜야 하는 것**: 계층(`traffic-optimization/` 등), 이름 규칙(소문자-하이픈), 컴포넌트 계약(README, Makefile `build`/`test`, `tests/`)

## 2. 합칠지 나눌지 정하는 기준

기준은 **실행·배포 단위**입니다.

| 상황 | 처리 |
|---|---|
| 한 바이너리·프로세스·패키지가 여러 기능(산출물)을 함께 수행 | 하나의 컴포넌트로 합침 |
| 바이너리나 컨테이너는 따로지만 공통 코드를 공유 | 컴포넌트는 나눠 두고 공통 코드를 [`libs/<언어>/`](../../libs/README.md)로 뺌 |
| 하나의 개발 건(PR)이 여러 컴포넌트를 함께 수정 | 합칠 필요 없음. PR 하나로 여러 폴더를 고치면 CI가 각 컴포넌트를 빌드하고 폴더별 담당 팀이 리뷰함 |

계획서 산출물과 폴더가 1:1이 아니어도 됩니다. 산출물과 폴더의 대응은 각 컴포넌트 README의
"계획서상 산출물명"과 [`docs/deliverables/`](../deliverables/2026/README.md)에서 추적합니다.

## 3. 반입 절차

### 3-1. 그대로 넣기 (기본)

```bash
git switch -c feature/<기관>/import-<이름>

# 기존 코드를 컴포넌트 폴더에 복사 (.git 폴더는 제외)
rsync -a --exclude .git <기존 저장소>/ traffic-optimization/observability/
```

기존 빌드 명령을 부르는 얇은 `Makefile`을 둡니다. 예를 들어 Python 프로젝트라면 다음과 같습니다.

```make
.PHONY: build test
build:
	python3 -m pip install -q -e '.[test]'
test:
	python3 -m pytest -q tests
```

C/C++(CMake) 프로젝트라면 `build`에서 `cmake -B build && cmake --build build`,
`test`에서 `ctest --test-dir build`를 실행하면 됩니다.

### 3-2. 컴포넌트 합치기 예시

아주대 코드 하나가 관측, 병목 분류, 워크로드 배치를 함께 수행하는 경우입니다.

```bash
git mv traffic-optimization/observability traffic-optimization/fabric-insight
rsync -a --exclude .git <기존 저장소>/ traffic-optimization/fabric-insight/
git rm -r traffic-optimization/workload-placement      # 흡수된 빈 폴더 삭제
```

함께 고칠 곳은 다음과 같습니다.

- [ ] `fabric-insight/README.md`: "계획서상 산출물명"에 흡수한 산출물을 모두 기재
- [ ] `.github/CODEOWNERS`: 경로 변경
- [ ] `docs/deliverables/<연도>/README.md`: 산출물 위치 링크 변경
- [ ] 계층 README(`traffic-optimization/README.md`)의 컴포넌트 표
- [ ] 배포 대상이면 `deploy/gpubase-fabric/Chart.yaml`의 `dependencies`

### 3-3. 나누기

한 폴더에 있던 코드의 배포 단위가 갈라지면 `hack/new-component.sh`로 새 컴포넌트를 만들고 해당 부분을 옮깁니다.
위 체크리스트를 똑같이 적용합니다.

### 3-4. 기존 커밋 이력을 살리고 싶을 때 (선택)

```bash
git subtree add --prefix=traffic-optimization/observability <기존 저장소 URL> <브랜치>
```

- 기존 이력이 이 저장소의 커밋으로 들어옵니다. 공개SW 커밋 수 산정에 포함될 수 있으니 **아크릴과 먼저 협의**하세요.
- 기존 커밋은 DCO 서명이 없어서 `dco` 체크를 통과하지 못합니다. 이 경우 아크릴 관리자가 별도로 처리합니다.
- 기존 이력에 시크릿이나 내부 주소가 있었다면 삭제한 뒤에도 이력에 남습니다. **이력을 가져오기 전에 gitleaks로 전체 이력을 검사**하세요.

## 4. 반입 전 점검

- [ ] 내부 IP, 호스트명, 계정, 토큰, kubeconfig 제거 (`gitleaks dir .`로 확인)
- [ ] 고객사·협력사 이름, 상용(Extension) 관련 코드 제거
- [ ] 모든 소스 파일에 MPL-2.0 헤더 ([hack/boilerplate](../../hack/boilerplate/README.md))
- [ ] 의존성 라이선스가 [LICENSE_POLICY.md](../governance/LICENSE_POLICY.md)에 맞음
- [ ] 데이터셋, 모델 가중치, 패킷 캡처 등 대용량 파일 제외 (외부 위치를 README에 링크)
- [ ] 외부에서 복사한 코드는 원본 라이선스와 출처 유지
- [ ] `make verify`와 `make -C <컴포넌트> build test` 통과
