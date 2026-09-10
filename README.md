# Leptos Agent

This is a Kotlin Multiplatform monorepo containing multiple apps and shared modules.

## Structure

- [apps/leptos-agent](./apps/leptos-agent/) — the Leptos Agent app
  - [androidApp](./apps/leptos-agent/androidApp) — Android entry point (`com.alwinsden.leptosagent.MainActivity`)
  - [iosApp](./apps/leptos-agent/iosApp/iosApp) — iOS entry point (SwiftUI). This is where you add SwiftUI code for the app.
  - [shared/sharedLogic](./apps/leptos-agent/shared/sharedLogic/src) — non-UI logic shared between the app's targets.
  The most important subfolder is [commonMain](./apps/leptos-agent/shared/sharedLogic/src/commonMain/kotlin). If preferred, you
  can add code to the platform-specific folders here too.
  - [shared/sharedUI](./apps/leptos-agent/shared/sharedUI/src) — Compose Multiplatform UI shared across the app's targets.
  It contains several subfolders:
    - [commonMain](./apps/leptos-agent/shared/sharedUI/src/commonMain/kotlin) is for code that’s common for all targets.
    - Other folders are for Kotlin code that will be compiled for only the platform indicated in the folder name.
      For example, if you want to use Apple’s CoreCrypto for the iOS part of your Kotlin app,
      the [iosMain](./apps/leptos-agent/shared/sharedUI/src/iosMain/kotlin) folder would be the right place for such calls.

### Adding a new app

1. Create the app modules under `apps/<new-app>/` (e.g. `apps/<new-app>/androidApp` and `apps/<new-app>/shared/<module>`).
2. Add them to [settings.gradle.kts](./settings.gradle.kts) via `include(":apps:<new-app>:androidApp")`.
3. Depend on the shared modules with `project(":apps:<new-app>:shared:sharedLogic")` / `project(":apps:<new-app>:shared:sharedUI")`.
4. For iOS, copy `apps/leptos-agent/iosApp` as a starting point and make sure its Gradle script phase points at
   the repo root (`cd "$SRCROOT/../../.."`) and the correct `embedAndSignAppleFrameworkForXcode` task path.

### Running the apps

Use the run configurations provided by the run widget in your IDE's toolbar. You can also use these commands and
options:

- Android app: `./gradlew :apps:leptos-agent:androidApp:assembleDebug`
- iOS app: open the [apps/leptos-agent/iosApp](./apps/leptos-agent/iosApp) directory in Xcode and run it from there.

---

Learn more about [Kotlin Multiplatform](https://www.jetbrains.com/help/kotlin-multiplatform-dev/get-started.html)…
