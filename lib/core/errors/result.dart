/// HU 1.3 – Clase Result para manejo funcional de éxito/error
/// Patrón Either simplificado para Dart
sealed class Result<T> {
  const Result();

  /// Crear resultado exitoso
  factory Result.success(T data) = Success<T>;

  /// Crear resultado con error
  factory Result.failure(Exception error) = Failure<T>;

  /// Verificar si es éxito
  bool get isSuccess => this is Success<T>;

  /// Verificar si es error
  bool get isFailure => this is Failure<T>;

  /// Obtener datos (null si es error)
  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Failure<T>() => null,
      };

  /// Obtener error (null si es éxito)
  Exception? get errorOrNull => switch (this) {
        Success<T>() => null,
        Failure<T>(:final error) => error,
      };

  /// Transformar el resultado
  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success<T>(:final data) => Result.success(transform(data)),
      Failure<T>(:final error) => Result.failure(error),
    };
  }

  /// Ejecutar callback según resultado
  void when({
    required void Function(T data) success,
    required void Function(Exception error) failure,
  }) {
    switch (this) {
      case Success<T>(:final data):
        success(data);
      case Failure<T>(:final error):
        failure(error);
    }
  }
}

/// Resultado exitoso
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Resultado con error
class Failure<T> extends Result<T> {
  final Exception error;
  const Failure(this.error);
}
