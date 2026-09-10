# AGENTS.md

Kotlin Multiplatform app (Android + iOS) built from the JetBrains KMP template. Gradle KTS + version catalog (`gradle/libs.versions.toml`); versions there are the source of truth (Kotlin 2.4.x, AGP 9.x, Compose Multiplatform 1.11.x, compileSdk 36 / minSdk 24).

## Commands

```sh
./gradlew :androidApp:assembleDebug   # build Android app
./gradlew allTests                    # all module tests (kotlin-test/JUnit)
./gradlew :sharedLogic:allTests       # tests for one module
./gradlew :androidApp:installDebug    # install to connected device/emulator
```

- iOS: run from Xcode (`iosApp/iosApp.xcodeproj`) — no Gradle iOS app target.
- `org.gradle.configuration-cache=true` is set; if a task fails under config cache, retry with `--no-configuration-cache` before assuming a code error.

## Module graph

`:androidApp` → `:sharedUI` (Compose Multiplatform, `api(project(":sharedLogic"))`) → `:sharedLogic`.

- `sharedLogic` — shared non-UI logic; also produces the static framework `SharedLogic` (iosArm64, iosSimulatorArm64) consumed by the iOS app.
- `sharedUI` — shared Compose UI; Compose resources live in `sharedUI/src/commonMain/composeResources` (accessed via generated `Res` class).
- `androidApp` — Android entry (`com.alwinsden.liptosagent.MainActivity`).

## Gotchas

- **Only `sharedLogic` exports an iOS framework.** The iOS app is currently pure SwiftUI (`iosApp/iosApp/`) and imports only `SharedLogic`. Shared Compose UI in `sharedUI` is used by Android only — do not assume iOS renders it.
- **AGP 9 KMP plugin:** shared modules use `com.android.kotlin.multiplatform.library`, so Android config (namespace, compileSdk, minSdk) lives *inside* `kotlin { android { } }` in `sharedLogic/build.gradle.kts` and `sharedUI/build.gradle.kts`, not in a top-level `android {}` block.
- JVM target is 11 for all Android/Kotlin compilation.
- `local.properties` (Android SDK path) is gitignored and machine-specific — never commit it.
- Package base is `com.alwinsden.liptosagent`; iOS bundle id is `com.alwinsden.liptosagent.liptos-agent` (dash included, set in `iosApp/Configuration/Config.xcconfig`).
- README text about `jvmMain`/Desktop in `sharedUI` is leftover template prose — there is no desktop target.
