import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dashboard_data_model.dart';

/// DataSource local del dashboard — capa Data (caché en SharedPreferences).
///
/// Guarda el último dashboard obtenido para poder mostrarlo sin conexión
/// (HU 3.2 – cache local). Serializa el modelo Freezed a JSON.
abstract interface class DashboardLocalDataSource {
  Future<void> cacheDashboard(DashboardDataModel data);
  DashboardDataModel? readCachedDashboard();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final SharedPreferences _prefs;
  static const _cacheKey = 'dashboard_cache_v1';

  const DashboardLocalDataSourceImpl(this._prefs);

  @override
  Future<void> cacheDashboard(DashboardDataModel data) async {
    await _prefs.setString(_cacheKey, jsonEncode(data.toJson()));
  }

  @override
  DashboardDataModel? readCachedDashboard() {
    final raw = _prefs.getString(_cacheKey);
    if (raw == null) return null;
    try {
      return DashboardDataModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      // Caché corrupta: se ignora y se tratará como si no existiera.
      return null;
    }
  }
}
