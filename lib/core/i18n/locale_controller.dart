import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/infrastructure_providers.dart';

/// Controla el idioma activo de la app (HU 3.3) y lo persiste.
///
/// Es un `Notifier<Locale>` sencillo: el idioma es un único valor, no necesita
/// una clase de estado con variantes (a diferencia del dashboard, que sí las
/// necesita para loading/error). Elegir la herramienta adecuada para cada caso
/// también es una decisión de arquitectura.
class LocaleController extends Notifier<Locale> {
  static const _key = 'app_locale';
  static const supported = [Locale('es'), Locale('en')];

  @override
  Locale build() {
    final saved = ref.read(sharedPreferencesProvider).getString(_key);
    return saved != null ? Locale(saved) : const Locale('es');
  }

  Future<void> setLocale(Locale locale) async {
    if (!supported.any((l) => l.languageCode == locale.languageCode)) return;
    state = locale;
    await ref.read(sharedPreferencesProvider).setString(_key, locale.languageCode);
  }

  void toggle() {
    setLocale(state.languageCode == 'es' ? const Locale('en') : const Locale('es'));
  }
}

final localeControllerProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);
