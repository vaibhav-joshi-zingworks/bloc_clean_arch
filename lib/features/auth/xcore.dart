/// Authentication feature public surface.
///
/// Layout:
/// ```text
/// auth/
/// ├── data/
/// │   ├── datasources/   # Remote login + local session storage
/// │   ├── dto/           # Request/response payloads
/// │   ├── mappers/       # DTO -> domain entity mapping
/// │   ├── models/        # JSON models for API payloads
/// │   └── repositories/  # [AuthRepository] implementation
/// ├── domain/
/// │   ├── entities/      # [UserEntity], [AuthSessionEntity]
/// │   ├── repositories/  # [AuthRepository] contract
/// │   └── usecases/      # Login, logout, session status
/// └── presentation/
///     ├── bloc/          # [AuthBloc], events, states
///     ├── screens/       # Route-level screens
///     └── widgets/       # Reusable auth UI pieces
/// ```
///
/// Import this barrel from outside the feature; keep feature internals on folder paths.
export 'data/datasources/auth_local_data_source.dart';
export 'data/datasources/auth_remote_data_source.dart';
export 'data/datasources/auth_remote_data_source_impl.dart';
export 'data/repositories/auth_repository_impl.dart';
export 'domain/entities/auth_session_entity.dart';
export 'domain/entities/user_entity.dart';
export 'domain/repositories/auth_repository.dart';
export 'domain/usecases/get_auth_status_use_case.dart';
export 'domain/usecases/login_use_case.dart';
export 'domain/usecases/logout_use_case.dart';
export 'presentation/bloc/auth_bloc.dart';
export 'presentation/bloc/auth_event.dart';
export 'presentation/bloc/auth_state.dart';
export 'presentation/screens/login_screen.dart';
