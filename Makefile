SHELL := /bin/bash
.PHONY: menu

toml-sort:
	poetry run toml-sort -i pyproject.toml --no-sort-tables --sort-table-keys
