.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


.PHONY: lint
lint:  ## Linter the code.
	@echo "🚨 Linting code"
<<<<<<< HEAD
	poetry run cruft check
	poetry run isort safe_route_path tests --check
	poetry run flake8 safe_route_path tests
	poetry run mypy safe_route_path
	poetry run black safe_route_path tests --check --diff
=======
	isort safe_route_path tests --check
	flake8 safe_route_path tests
	mypy safe_route_path
	black safe_route_path tests --check --diff
>>>>>>> 27d3f5c48a52475a758113e657a3ba19fd189bb8


.PHONY: format
format:
	@echo "🎨 Formatting code"
	isort safe_route_path tests
	autoflake --remove-all-unused-imports --recursive --remove-unused-variables --in-place safe_route_path tests --exclude=__init__.py
	black safe_route_path tests


.PHONY: tests
test:  ## Test your code.
	@echo "🍜 Running pytest"
	pytest tests/ --cov=safe_route_path --cov-report=term-missing:skip-covered --cov-report=xml --cov-fail-under 100


.PHONY: publish
publish:  ## Publish release to PyPI
	@echo "🔖 Publish to PyPI"
	python setup.py bdist_wheel
	twine upload dist/*
