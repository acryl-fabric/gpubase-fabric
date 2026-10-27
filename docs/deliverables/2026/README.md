# 1차년도(2026) 공개 산출물

- 근거: 연구개발계획서 p.59~60 "공개 산출물(SW, 기술문서 등)"
- 제출 기한: 2026-12 (1차년도 종료 2026-12-31)
- 상태 표기: ⬜ 미착수 · 🟨 작성/개발 중 · 🟦 PR 리뷰 중 · ✅ `main` 반영 완료

| # | 기관 | 산출물 | 유형 | 위치 | 상태 |
|---|---|---|---|---|---|
| 1 | 아크릴 | RoCEv2 GPU 클러스터 확장성 실험 인프라 구축 완료 보고서 | 기술문서 | [`field-test/testbed/`](../../../field-test/testbed/README.md) | 🟨 |
| 2 | 아크릴 | 통합 운영 대시보드 프로토타입 | SW | [`fabric-manager/dashboard/`](../../../fabric-manager/dashboard/README.md) | 🟨 |
| 3 | 아크릴 | SDN 기반 적응형 라우팅 정책 모델·갱신 절차 설계서 | 기술문서 | [`traffic-optimization/adaptive-routing/docs/`](../../../traffic-optimization/adaptive-routing/docs/README.md) | 🟨 |
| 4 | 아크릴 | RDMA 자원 격리 정책 모델·아키텍처 설계서 | 기술문서 | [`traffic-optimization/qos-isolation/docs/`](../../../traffic-optimization/qos-isolation/docs/README.md) | 🟨 |
| 5 | 연세대 | GPU–DPU 연동 데이터 경로 실험 환경 구축 완료 보고서 | 기술문서 | [`data-acceleration/docs/`](../../../data-acceleration/docs/README.md) | ⬜ |
| 6 | 연세대 | AI/ML 학습·추론 워크로드의 episodic/semantic 메모리 접근 특성 분석 보고서 | 기술문서 | [`data-acceleration/docs/`](../../../data-acceleration/docs/README.md) | ⬜ |
| 7 | 연세대 | DPU 오프로딩 기반 GPU–네트워크 데이터 경로 설계 문서 | 기술문서 | [`data-acceleration/docs/`](../../../data-acceleration/docs/README.md) | ⬜ |
| 8 | 성균관대 | GPU 클러스터 인프라 대상 공격자 모델 보고서 | 기술문서 | [`security/docs/`](../../../security/docs/README.md) | ⬜ |
| 9 | 성균관대 | k8s 기반 인프라 보안분석 환경 프레임워크 코드 | SW | [`security/security-framework/`](../../../security/security-framework/README.md) | ⬜ |
| 10 | 아주대 | 통합 관측 모니터링 툴 소스코드 | SW | [`traffic-optimization/observability/`](../../../traffic-optimization/observability/README.md) | ⬜ |
| 11 | 아주대 | 병목 원인 분류 모듈 소스코드 | SW | [`traffic-optimization/observability/`](../../../traffic-optimization/observability/README.md) | ⬜ |
| 12 | 아주대 | 토폴로지 인지 워크로드 배치 및 재배치 정책 엔진 소스코드 | SW | [`traffic-optimization/workload-placement/`](../../../traffic-optimization/workload-placement/README.md) | ⬜ |

## 제출 체크리스트 (산출물마다)

- [ ] 지정 위치에 반영되어 `main`에 머지됨 (PR 링크를 표에 기록)
- [ ] 컴포넌트 README의 상태·산출물명 갱신
- [ ] SW: `make build test` 통과, 소스 파일 MPL-2.0 헤더 포함
- [ ] 기술문서: 표지에 과제번호(RS-2026-25525457)와 사사 문구 포함
- [ ] 내부 IP·호스트명·계정·고객사 정보 없음 (gitleaks와 리뷰로 확인)
- [ ] Extension(상용) 관련 내용 없음
- [ ] 연차실적보고서 첨부용 링크(커밋 해시 고정 URL) 확보

## 공개SW 지표 (1차년도 목표)

| 지표 | 당해 목표 | 누적 목표 | 확인 방법 |
|---|---|---|---|
| 저장소 운영 | 1 | 1 | 이 저장소 |
| 커밋 수 | 50 | 50 | `git rev-list --count main` (기관별: `git shortlog -se main`) |
| 스타 수 | 20 | 20 | 저장소 Stars |
