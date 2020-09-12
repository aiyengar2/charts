ci: bootstrap
	./scripts/ci

prepare: bootstrap
	./scripts/prepare

bootstrap:
	./scripts/bootstrap

charts: bootstrap prepare
	./scripts/generate-charts

patch: bootstrap
	./scripts/generate-patch

validate: bootstrap
	./scripts/validate

mirror: bootstrap
	./scripts/image-mirror

clean:
	./scripts/clean

interactive-rebase:
	./scripts/interactive-rebase

.DEFAULT_GOAL := ci

