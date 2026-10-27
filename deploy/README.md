# deploy

통합 Helm umbrella 차트 **`gpubase-fabric`** (TANGO2의 `devops/`에 해당).

- 배포 대상 컴포넌트의 `chart/`를 `file://` 의존성으로 묶습니다. **Core 컴포넌트만** 포함합니다.
- 상용 Extension은 이 차트에 넣지 않고, 같은 클러스터에 **별도 릴리스로 얹습니다**. 그래서 Service 이름·포트·CRD는 안정된 계약으로 유지합니다([CORE_EXTENSION.md §4](../docs/governance/CORE_EXTENSION.md)).
- 서드파티 차트(Prometheus 등)는 저장소에 복사(vendoring)하지 않고, 필요하면 `dependencies`에 upstream 저장소로 추가합니다.
- 릴리스(`v*` 태그) 시 `oci://ghcr.io/acryl-fabric/charts/gpubase-fabric`로 게시됩니다.

```bash
make -C deploy lint                 # helm dependency update + lint
helm install gpubase-fabric deploy/gpubase-fabric -n gpubase-fabric --create-namespace
```

새 배포 대상 컴포넌트를 추가하면 `gpubase-fabric/Chart.yaml`의 `dependencies`와 `values.yaml`에 `<component>.enabled`를 추가합니다.
환경별 값(주소, 자격증명)은 `values-<site>.private.yaml`로 따로 관리하며 커밋하지 않습니다.
