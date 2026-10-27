# libs/python

Python 공용 라이브러리. 라이브러리마다 `pyproject.toml`을 둔 독립 패키지로 만들고,
사용하는 컴포넌트는 상대 경로로 설치합니다(예: `pip install -e ../../libs/python/<name>`).

아직 라이브러리가 없습니다. 첫 라이브러리는 `hack/new-component.sh --type basic --path libs/python/<name> ...`로 만든 뒤 패키지 구성을 추가합니다.
