/// Constantes de texto de la aplicación
class AppStrings {
  AppStrings._();

  // General
  static const String appName = 'BankApp';
  static const String appTagline = 'Tu banco digital, siempre contigo';

  // Auth
  static const String welcome = 'Bienvenido';
  static const String welcomeBack = 'Bienvenido de nuevo';
  static const String login = 'Iniciar Sesión';
  static const String register = 'Registrarse';
  static const String logout = 'Cerrar Sesión';
  static const String email = 'Correo electrónico';
  static const String password = 'Contraseña';
  static const String confirmPassword = 'Confirmar contraseña';
  static const String forgotPassword = '¿Olvidaste tu contraseña?';
  static const String noAccount = '¿No tienes cuenta?';
  static const String hasAccount = '¿Ya tienes cuenta?';
  static const String fullName = 'Nombre completo';

  // Home
  static const String home = 'Inicio';
  static const String totalBalance = 'Saldo Total';
  static const String myAccounts = 'Mis Cuentas';
  static const String recentTransactions = 'Transacciones Recientes';
  static const String viewAll = 'Ver todo';
  static const String quickActions = 'Acciones Rápidas';

  // Accounts
  static const String accounts = 'Cuentas';
  static const String savingsAccount = 'Cuenta de Ahorro';
  static const String checkingAccount = 'Cuenta Corriente';
  static const String creditCard = 'Tarjeta de Crédito';
  static const String accountNumber = 'Número de cuenta';
  static const String availableBalance = 'Saldo disponible';

  // Transactions
  static const String transactions = 'Transacciones';
  static const String transfer = 'Transferir';
  static const String deposit = 'Depositar';
  static const String withdraw = 'Retirar';
  static const String payment = 'Pagar';
  static const String amount = 'Monto';
  static const String recipient = 'Destinatario';
  static const String description = 'Descripción';
  static const String date = 'Fecha';
  static const String status = 'Estado';

  // Cards
  static const String cards = 'Tarjetas';
  static const String myCards = 'Mis Tarjetas';
  static const String cardNumber = 'Número de tarjeta';
  static const String expiryDate = 'Fecha de vencimiento';
  static const String cardHolder = 'Titular';
  static const String blockCard = 'Bloquear tarjeta';

  // Profile
  static const String profile = 'Perfil';
  static const String personalInfo = 'Información Personal';
  static const String security = 'Seguridad';
  static const String notifications = 'Notificaciones';
  static const String helpSupport = 'Ayuda y Soporte';
  static const String settings = 'Configuración';
  static const String about = 'Acerca de';

  // Status
  static const String completed = 'Completada';
  static const String pending = 'Pendiente';
  static const String failed = 'Fallida';
  static const String cancelled = 'Cancelada';

  // Errors
  static const String errorGeneral = 'Ha ocurrido un error. Intenta de nuevo.';
  static const String errorConnection = 'Error de conexión. Verifica tu internet.';
  static const String errorInvalidEmail = 'Correo electrónico inválido';
  static const String errorInvalidPassword = 'La contraseña debe tener al menos 8 caracteres';
  static const String errorPasswordMismatch = 'Las contraseñas no coinciden';
  static const String errorEmptyField = 'Este campo es requerido';
  static const String errorInsufficientFunds = 'Fondos insuficientes';
}
