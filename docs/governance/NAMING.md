# NAMING — 브랜드 식별자 고정

이 문서의 식별자는 **고정값**입니다. 변경하려면 fabric-acryl 승인과 별도 PR이 필요합니다.
CI(`hack/verify-contract.sh`)와 LLM 리뷰가 이 규칙을 검사합니다.

| 항목 | 값 | 예시 |
|---|---|---|
| 표시 이름 | `JONATHAN GPUBASE Fabric` | README, 문서 제목 |
| GitHub 저장소 | `acryl-fabric/gpubase-fabric` | |
| Go 모듈 경로 | `github.com/acryl-fabric/gpubase-fabric` | `import "github.com/acryl-fabric/gpubase-fabric/api/plugin/v1alpha1"` |
| 컨테이너 이미지 | `ghcr.io/acryl-fabric/gpubase-fabric/<component>` | `ghcr.io/acryl-fabric/gpubase-fabric/switch-manager:<tag>` |
| Helm 차트 (umbrella) | `gpubase-fabric` | `helm install gpubase-fabric oci://ghcr.io/acryl-fabric/charts/gpubase-fabric` |
| Helm 차트 OCI 저장 위치 | `oci://ghcr.io/acryl-fabric/charts` | |
| Helm 서브차트 이름 | `<component>` (디렉터리 이름과 동일) | `switch-manager` |
| CRD API 그룹 | `fabric.gpubase.acryl.ai` | `apiVersion: fabric.gpubase.acryl.ai/v1alpha1` |
| proto 패키지 | `gpubase.fabric.<version>` | `gpubase.fabric.v1alpha1` |
| 라벨·어노테이션 접두어 | `gpubase.acryl.ai/` | `gpubase.acryl.ai/component: switch-manager` |
| 메트릭 접두어 | `gpubase_fabric_` | `gpubase_fabric_build_info` |
| Kubernetes 네임스페이스(기본) | `gpubase-fabric` | |

## 컴포넌트 이름

- 소문자와 하이픈만 사용합니다(`^[a-z0-9]+(-[a-z0-9]+)*$`). 디렉터리 이름 = 이미지 이름 = 서브차트 이름입니다.
- 계층 이름은 이미지 경로에 넣지 않습니다(`.../gpubase-fabric/switch-manager`, `.../fabric-manager/switch-manager`가 아님).

## 표준 라벨

모든 Kubernetes 리소스에 다음 라벨을 붙입니다(컴포넌트 템플릿 `_helpers.tpl`에 포함됨).

```yaml
app.kubernetes.io/name: <component>
app.kubernetes.io/instance: <release>
app.kubernetes.io/part-of: gpubase-fabric
gpubase.acryl.ai/component: <component>
gpubase.acryl.ai/layer: <layer>        # fabric-manager | traffic-optimization | data-acceleration | security | field-test
```

## OCI 이미지 라벨

```
org.opencontainers.image.title    = gpubase-fabric/<component>
org.opencontainers.image.source   = https://github.com/acryl-fabric/gpubase-fabric
org.opencontainers.image.licenses = MPL-2.0
org.opencontainers.image.vendor   = ACRYL Inc.
```

## 이미지 태그

| 이벤트 | 태그 |
|---|---|
| `main` push | `<git sha 전체>`, `main` |
| `v*` 태그 | `<버전, v 제외>` (예: `0.1.0`), `<git sha>` |

## Extension(상용)과의 구분

상용 Extension은 위 식별자를 **재사용하지 않습니다**. Extension 전용 접두어와 그룹은 사내 GitLab에서 따로 정하며,
이 저장소에는 기록하지 않습니다.
