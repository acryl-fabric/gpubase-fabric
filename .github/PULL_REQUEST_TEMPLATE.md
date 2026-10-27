## 관련 이슈

<!-- 예: Closes #12 / 관련 산출물: docs/deliverables/2026 #10 -->

## 변경 내용

<!-- 무엇을 바꿨는지 간단히. 영향받는 컴포넌트를 적어주세요. -->

## 설계 의도

<!-- 왜 이렇게 설계했는지, 검토한 대안, api/ 계약 변경 여부 -->

## 성능 영향

<!-- 제어·데이터 경로 성능, 리소스 사용량, 메트릭 cardinality 등. 측정했다면 수치를 적어주세요. 영향 없음이면 "없음". -->

## 운영 리스크

<!-- 장애 시 동작, 스위치·노드에 대한 파괴적 동작, 권한(RBAC) 범위, 롤백 방법, 하위 호환성 -->

## 테스트 방법

<!-- 실행한 명령과 결과. 예: make -C traffic-optimization/observability test -->

## 체크리스트

- [ ] 모든 커밋에 DCO 서명(`git commit -s`)을 했고, 커밋 이메일은 소속 기관 이메일입니다.
- [ ] 새 소스 파일 상단에 MPL-2.0 헤더를 넣었습니다.
- [ ] 컴포넌트 계약(README / Makefile build·test / tests/, 배포 대상은 Dockerfile·image·chart/)을 지켰습니다. (`make verify`)
- [ ] Extension(상용) 코드·설계, 고객 정보, 내부 IP·호스트명·자격증명이 포함되지 않았습니다.
- [ ] 새 의존성의 라이선스가 정책(LICENSE_POLICY.md)에 맞습니다.
- [ ] 논문·발표·보고서용 산출물이라면 사사표기(README Acknowledgement)를 포함했습니다.
