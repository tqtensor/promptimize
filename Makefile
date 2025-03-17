SHELL := /bin/bash
.PHONY: menu

toml-sort:
	poetry run toml-sort -i pyproject.toml --no-sort-tables --sort-table-keys

lock-requirements:
	poetry self add poetry-plugin-export@latest
	poetry export --with dev --without-hashes -f requirements.txt > /tmp/requirements_poetry_all.txt
	pip-compile --output-file=requirements.txt --resolver=backtracking /tmp/requirements_poetry_all.txt --allow-unsafe

menu:
	@echo "Choose an action:"
	@echo "1. Sort pyproject.toml"
	@echo "2. Lock requirements"
	@read -p "Enter a number (1-2): " choice; \
	case $$choice in \
		1) make toml-sort ;; \
		2) make lock-requirements ;; \
		*) echo "Invalid input. Please enter a number between 1 and 2." && exit 1 ;; \
	esac
