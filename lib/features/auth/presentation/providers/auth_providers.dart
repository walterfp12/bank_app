import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/infrastructure_providers.dart';
import '../../application/services/auth_service.dart';
import '../../application/services/session_service.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_session_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

// ─── Data Layer ───────────────────────────────────────────────────────────────

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.read(httpClientProvider));
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(ref.read(sharedPreferencesProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remote: ref.read(authRemoteDataSourceProvider),
    local:  ref.read(authLocalDataSourceProvider),
  );
});

// ─── Domain – Use Cases ───────────────────────────────────────────────────────

final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCase(ref.read(authRepositoryProvider)),
);

final logoutUseCaseProvider = Provider<LogoutUseCase>(
  (ref) => LogoutUseCase(ref.read(authRepositoryProvider)),
);

final getCurrentSessionUseCaseProvider = Provider<GetCurrentSessionUseCase>(
  (ref) => GetCurrentSessionUseCase(ref.read(authRepositoryProvider)),
);

// ─── Application Layer ────────────────────────────────────────────────────────

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    loginUseCase:  ref.read(loginUseCaseProvider),
    logoutUseCase: ref.read(logoutUseCaseProvider),
  );
});

final sessionServiceProvider = Provider<SessionService>((ref) {
  return SessionService(
    getCurrentSession: ref.read(getCurrentSessionUseCaseProvider),
  );
});
