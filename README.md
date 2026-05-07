# Bloc Clean Architecture (BCA) - Deep Documentation

A high-performance, modular Flutter boilerplate built for production-grade applications. This architecture focuses on **Scalability**, **Testability**, and **Developer Productivity**.

---

## 🏗 Architecture Deep Dive

The project follows **Clean Architecture** principles, enforcing a strict unidirectional dependency flow: `Presentation → Domain ← Data`.

### 1. The Domain Layer (Independent)
The core business logic center. It has **zero dependencies** on Flutter or external libraries.
- **Entities**: Pure Dart classes representing business objects.
- **Use Cases**: Single-purpose classes (e.g., `LoginUseCase`) that orchestrate the flow of data.
- **Repositories (Interfaces)**: Contract definitions that the Data layer must satisfy.
- **Result Pattern**: Uses `dartz` `Either<AppException, Type>` to handle errors functionally, ensuring the UI always knows if a request succeeded or failed without using `try-catch` in Blocs.

### 2. The Data Layer (Implementation)
Responsible for fetching and transforming data.
- **Data Sources**: Atomic units for API (Remote) or Cache (Local) access.
- **Models**: DTOs (Data Transfer Objects) with `freezed` for `json_serializable` support.
- **Mappers**: Pure functions that convert Models (Data layer) to Entities (Domain layer).
- **Network Service**: A robust `Dio` implementation with a centralized `Failure` handler that maps `DioException` to domain-specific `AppException`.

### 3. The Presentation Layer (UI)
Handles user interaction and state.
- **State Management**: `flutter_bloc` for predictable state transitions.
- **Atomic Widgets**: UI is broken down into small, reusable components.
- **Type-Safe Routing**: `go_router` for deep-linking and declarative navigation.

---

## 🛠 Advanced Features

### 🔌 Automated Dependency Injection
We use `get_it` and `injectable`. Dependencies are registered via annotations:
- `@injectable`: Factory instance.
- `@lazySingleton`: Single instance created on first use.
- `@preResolve`: For dependencies that need async initialization (e.g., `SharedPreferences`).
- **DI Modules**: Centralized configuration in `core/di/injection.dart`.

### 🌐 Reactive Networking & Interceptors
The `NetworkApiService` is wrapped with multiple interceptors:
- **Connectivity**: Blocks requests immediately if there's no internet.
- **Auth**: Automatically attaches Bearer tokens and handles 401 Session Expiry.
- **Encryption**: Uses `AES` to encrypt/decrypt request payloads transparently.
- **Logging**: `talker_dio_logger` for beautiful, searchable console logs.

### 💾 Strategy-Based Storage
A flexible storage system using the **Strategy Pattern**:
- `StorageStrategy`: Interface for storage operations.
- `SharedPrefsStrategy`: For non-sensitive settings.
- `SecureStorageStrategy`: For tokens and sensitive user data.
- `StorageFacade`: A unified entry point to swap strategies at runtime.

### 🔒 Enterprise Security
- **SSL Pinning**: Prevents Man-in-the-Middle attacks.
- **Payload Encryption**: End-to-end encryption for API communication.
- **Device Security**: Integrated checks for Root/Jailbreak and Emulator detection.
- **Privacy**: `screen_protector` to disable screenshots on sensitive screens.

---

## 🚀 Lifecycle & Bootstrap

The app follows a controlled initialization sequence in `main.dart`:
1. `WidgetsFlutterBinding.ensureInitialized()`
2. `Firebase.initializeApp()`
3. `initDependencies()`: Scans and registers all `@injectable` classes.
4. `AppInitializerCubit`: Handles global startup logic (Auth check, Remote Config, Theme loading).

---

## 📝 Developer Productivity (Makefile)

Standardize your workflow with these optimized commands:

| Command | Action |
|---------|--------|
| `make setup` | Fresh install of all dependencies |
| `make build` | Generate files (`.freezed.dart`, `.g.dart`, `.config.dart`) |
| `make watch` | Hot-reload for code generation |
| `make prepare` | Auto-format, fix lints, and analyze code |
| `make test` | Run all unit tests with coverage |
| `make apk` | Build optimized, obfuscated release APK |

---

## 📂 Project Structure & Module Graph

```text
.
├── android/                # Android native project files
├── assets/                 # Static assets (images, fonts, animations)
├── config/                 # Environment-specific JSON configs (dev.json, prod.json)
├── ios/                    # iOS native project files
├── lib/                    # Main source code
│   ├── app/                # Global Application Layer
│   │   ├── bootstrap/      # App initialization & startup Cubits
│   │   ├── providers/      # App-wide BLoCs (Theme, Locale, Notifications)
│   │   ├── router/         # GoRouter definitions & navigation logic
│   │   └── view/           # Root App widget & global listeners
│   ├── core/               # Shared Infrastructure Layer (The Engine)
│   │   ├── di/             # Injection modules (GetIt + Injectable)
│   │   ├── failure/        # Domain-specific Exceptions & Error Mapping
│   │   ├── models/         # Base models (Result, PaginatedResult)
│   │   ├── network/        # Dio client, Interceptors & UseCase base
│   │   ├── services/       # External service wrappers (Analytics, Security, etc.)
│   │   └── design/         # Responsive UI utilities & breakpoints
│   ├── features/           # Feature-based Modules (Business Logic)
│   │   └── <feature>/      # Individual feature (e.g., auth, settings)
│   │       ├── data/       # Data Sources & Repository Implementations
│   │       ├── domain/     # Entities, Use Cases & Repository Interfaces
│   │       └── presentation/ # BLoCs, Pages & Feature-specific Widgets
│   ├── gen/                # Auto-generated code (Assets, Env, L10n)
│   ├── l10n/               # Localization source files (ARB)
│   ├── resources/          # UI Foundation (Themes, Colors, Constants)
│   ├── utilities/          # Global helper functions & extensions
│   └── main.dart           # Application Entry Point
├── test/                   # Comprehensive Test Suite
├── Makefile                # Developer workflow automation
└── pubspec.yaml            # Project dependencies & configuration
```

---

## 🧩 Module Breakdown

### 📱 `lib/app/`
The orchestrator of the application. It doesn't contain business logic but defines how the app starts and navigates.
- **Bootstrap**: Handles the "splash to home" transition logic and pre-app-run checks.
- **Router**: Centralized navigation. Uses `GoRouter` for deep-linking and type-safe routing.
- **Providers**: Home for Cubits that must live for the entire app lifecycle (e.g., managing the current theme mode or user locale).

### ⚙️ `lib/core/`
The "Engine" of the project. It provides the building blocks for all features.
- **DI (Dependency Injection)**: Uses `Injectable` to automatically generate the dependency graph, reducing boilerplate and manual instantiation.
- **Network**: A highly resilient `Dio` wrapper. Includes interceptors for:
  - `NetworkInterceptor`: Checks internet connectivity before sending requests.
  - `AuthInterceptor`: Injects Bearer tokens and handles `401 Unauthorized` (Session Expiry).
  - `PayloadInterceptor`: Handles transparent AES encryption/decryption of API data.
- **Services**: Abstracted interfaces for platform features. If you want to change from `Firebase Analytics` to `Mixpanel`, you only change the implementation here.

### 🚀 `lib/features/`
Where the actual business value lives. Each folder is a self-contained "mini-app" following Clean Architecture:
- **Domain Layer**: The "What". Defines business rules (Use Cases) and data shapes (Entities). It has no knowledge of APIs or DBs.
- **Data Layer**: The "How". Implements the Domain's repository interfaces. It talks to `RemoteDataSource` (REST API) or `LocalDataSource` (Storage).
- **Presentation Layer**: The "UI". Blocs convert user events into states, and Pages/Widgets render that state.

### 🎨 `lib/resources/` & `lib/gen/`
- **Resources**: Central truth for the design system. Contains `AppTheme`, `AppColors`, and shared UI constants.
- **Gen**: You should rarely touch this. It contains code generated by `flutter_gen` (for type-safe assets) and `dart_define` (for environment variables).

### 🧪 `test/`
Mirroring the `lib` structure, it contains:
- **Unit Tests**: For Use Cases and Repository implementations.
- **Bloc Tests**: For state transition validation.
- **Mocks**: Using `mocktail` to simulate dependencies.

### 📂 Root Level Folders
- **`config/`**: Holds environment-specific configuration. The `dev.json` or `prod.json` values are injected into the app at compile-time via `dart_define`.
- **`assets/`**: Centralized storage for images, fonts, and other static files.
- **`test/`**: Contains unit, widget, and integration tests. It follows the same directory structure as `lib/` for easy navigation.
- **`Makefile`**: The project's command center. It automates complex commands into simple ones like `make setup` or `make build`.

---

## ✨ Feature Implementation Flow

To add a feature (e.g., `Profile`):
1. **Domain**: Create `UserEntity`, `IProfileRepository`, and `GetProfileUseCase`.
2. **Data**: Create `UserModel` (with json), `ProfileRemoteDataSource`, and `ProfileRepositoryImpl`.
3. **Presentation**: Create `ProfileBloc`, `ProfilePage`, and `ProfileWidget`.
4. **DI**: Add `@injectable` to the repository implementation and data source.
5. **Route**: Register the new page in `app_router.dart`.
6. **Generate**: Run `make build`.
