import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import '../../services/http_client.dart';

/// SharedPreferences – se sobreescribe en ProviderScope (main.dart)
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('SharedPreferences no inicializado'),
);

/// Cliente HTTP Dio configurado con la base URL de DummyJSON
final httpClientProvider = Provider<AppHttpClient>(
  (_) => AppHttpClient(baseUrl: ApiConstants.baseUrl),
);
