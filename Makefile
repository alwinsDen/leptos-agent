.PHONY: generate go-types kotlin-types

generate: go-types kotlin-types   ## regenerate both sides from services/api.yaml

go-types:                          ## regenerate Go types -> services/leptos-agent/gen.go
	go tool oapi-codegen -config services/leptos-agent/oapi-codegen.yaml services/api.yaml

kotlin-types:                     ## regenerate Kotlin models -> shared/payloads/build/generated
	./gradlew :apps:leptos-agent:shared:sharedLogic:openApiGenerate
