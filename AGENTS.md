# AGENTS.md

Kotlin Multiplatform **monorepo** (multiple apps + shared modules) built from the JetBrains KMP template. Gradle KTS + version catalog (`gradle/libs.versions.toml`); versions there are the source of truth (Kotlin 2.4.x, AGP 9.x, Compose Multiplatform 1.11.x, compileSdk 36 / minSdk 24).

## Commands

```sh
./gradlew :apps:leptos-agent:androidApp:assembleDebug   # build Leptos Agent Android app
./gradlew allTests                    # all module tests (kotlin-test/JUnit)
./gradlew :apps:leptos-agent:shared:sharedLogic:allTests # tests for one module
./gradlew :apps:leptos-agent:androidApp:installDebug    # install to connected device/emulator
```

- iOS: run from Xcode (`apps/leptos-agent/iosApp/iosApp.xcodeproj`) — no Gradle iOS app target.
- `org.gradle.configuration-cache=true` is set; if a task fails under config cache, retry with `--no-configuration-cache` before assuming a code error.

## Layout

```
apps/<app>/androidApp|iosApp       # each KMP app lives in its own folder
apps/<app>/shared/<module>         # per-app shared modules, owned by that app
shared/<module>                    # repo-level shared modules (currently :shared:payloads)
```

Each app's `shared/` modules live inside the app folder and are owned by that app. A repo-level `shared/` module only exists if it is genuinely cross-app (as `:shared:payloads` is).

### Adding a new app

1. Create `apps/<new-app>/androidApp` and `apps/<new-app>/shared/<module>` (copy from an existing app).
2. `include(":apps:<new-app>:androidApp")` (and the shared modules) in `settings.gradle.kts`.
3. Depend on shared modules with full paths: `project(":apps:<new-app>:shared:<module>")`.
4. For iOS, copy an existing `iosApp` folder and update its Xcode script phase: `cd "$SRCROOT/../../.."` to the repo root and the correct `:apps:<new-app>:shared:...:embedAndSignAppleFrameworkForXcode` task path.

## Module graph

`:apps:leptos-agent:androidApp` → `:apps:leptos-agent:shared:sharedUI` (Compose Multiplatform, `api(project(":apps:leptos-agent:shared:sharedLogic"))`) → `:apps:leptos-agent:shared:sharedLogic`.

- `apps/leptos-agent/shared/sharedLogic` — shared non-UI logic; also produces the static framework `SharedLogic` (iosArm64, iosSimulatorArm64) consumed by the iOS app.
- `apps/leptos-agent/shared/sharedUI` — shared Compose UI; Compose resources live in `apps/leptos-agent/shared/sharedUI/src/commonMain/composeResources` (accessed via generated `Res` class).
- `apps/leptos-agent/androidApp` — Android entry (`com.alwinsden.leptosagent.MainActivity`).
- `shared/payloads` — kotlinx-serialization payload/data types, shared repo-level. It is an `api` dependency of `sharedLogic` **and exported in the `SharedLogic` iOS framework** (`export(project(":shared:payloads"))`), so payload classes are visible from Swift.

## Gotchas

- **Only `sharedLogic` exports an iOS framework.** The iOS app is currently pure SwiftUI (`apps/leptos-agent/iosApp/`) and imports only `SharedLogic`. Shared Compose UI in `sharedUI` is used by Android only — do not assume iOS renders it.
- **Xcode script phase paths:** the iOS app's Gradle build phase does `cd "$SRCROOT/../../.."` (repo root) and runs `:apps:leptos-agent:shared:sharedLogic:embedAndSignAppleFrameworkForXcode`. New apps' iosApp folders sit at the same depth (`apps/<app>/iosApp`), so the same `../../..` applies.
- **Compose `Res` package is pinned** via `packageOfResClass` in `sharedUI/build.gradle.kts` (`leptos_agent.sharedui.generated.resources`) so it doesn't shift if the module path changes. New modules with Compose resources should pin theirs too.
- **AGP 9 KMP plugin:** shared modules use `com.android.kotlin.multiplatform.library`, so Android config (namespace, compileSdk, minSdk) lives *inside* `kotlin { android { } }` in `sharedLogic/build.gradle.kts` and `sharedUI/build.gradle.kts`, not in a top-level `android {}` block.
- JVM target is 11 for all Android/Kotlin compilation.
- `local.properties` (Android SDK path) is gitignored and machine-specific — never commit it.
- Package base is `com.alwinsden.leptosagent`; iOS bundle id is `com.alwinsden.leptosagent.leptos-agent` (dash included, set in `apps/leptos-agent/iosApp/Configuration/Config.xcconfig`).
- README text about `jvmMain`/Desktop in `sharedUI` is leftover template prose — there is no desktop target.
- The Ktor version catalog (`ktorLibs` in `settings.gradle.kts`) and the Ktor plugin in the root `build.gradle.kts` are declared but not yet applied by any module.
