.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


.PHONY: lint
lint:  ## Linter the code.
	@echo "🚨 Linting code"
<<<<<<< HEAD
	poetry run cruft check
	poetry run isort lost_endpoint tests --check
	poetry run flake8 lost_endpoint tests
	poetry run mypy lost_endpoint
	poetry run black lost_endpoint tests --check --diff
=======
	isort lost_endpoint tests --check
	flake8 lost_endpoint tests
	mypy lost_endpoint
	black lost_endpoint tests --check --diff
>>>>>>> 27d3f5c48a52475a758113e657a3ba19fd189bb8


.PHONY: format
format:
	@echo "🎨 Formatting code"
	isort lost_endpoint tests
	autoflake --remove-all-unused-imports --recursive --remove-unused-variables --in-place lost_endpoint tests --exclude=__init__.py
	black lost_endpoint tests


.PHONY: tests
test:  ## Test your code.
	@echo "🍜 Running pytest"
	pytest tests/ --cov=lost_endpoint --cov-report=term-missing:skip-covered --cov-report=xml --cov-fail-under 100


.PHONY: publish
publish:  ## Publish release to PyPI
	@echo "🔖 Publish to PyPI"
	python setup.py bdist_wheel
	twine upload dist/*
