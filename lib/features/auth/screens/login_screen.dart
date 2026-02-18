import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/utils/validators.dart';
import '../../../routes/app_router.dart';

/// HU 1.2 / HU 2.2 – Pantalla de Login
/// Pantalla de inicio de sesión con validaciones
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simular llamada al servidor
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // TODO: Reemplazar con autenticación real (HU 4.1 - Firebase Auth)
    // Por ahora marcamos como autenticado y navegamos
    AppRouter.setAuthenticated(true);
    if (context.mounted) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.paddingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimens.paddingXXL),
              // Logo / Branding
              _buildHeader(),
              const SizedBox(height: AppDimens.paddingXXL),
              // Formulario
              _buildForm(),
              const SizedBox(height: AppDimens.paddingMD),
              // Olvidé contraseña
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Navegar a recuperación de contraseña
                  },
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ),
              const SizedBox(height: AppDimens.paddingLG),
              // Botón Login
              _buildLoginButton(),
              const SizedBox(height: AppDimens.paddingXL),
              // Registro
              _buildRegisterLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Ícono del banco
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppDimens.radiusXL),
            boxShadow: AppColors.buttonShadow,
          ),
          child: const Icon(
            Icons.account_balance,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: AppDimens.paddingLG),
        Text(
          'BAM Wallet',
          style: GoogleFonts.inter(
            fontSize: AppDimens.fontDisplay,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppDimens.paddingXS),
        Text(
          'Bienvenido de nuevo',
          style: GoogleFonts.inter(
            fontSize: AppDimens.fontLG,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.email,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              hintText: 'ejemplo@correo.com',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: AppDimens.paddingMD),
          // Password
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            validator: Validators.password,
            onFieldSubmitted: (_) => _handleLogin(),
            decoration: InputDecoration(
              labelText: 'Contraseña',
              hintText: '••••••••',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleLogin,
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text('Iniciar Sesión'),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '¿No tienes cuenta? ',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        TextButton(
          onPressed: () {
            // TODO: Navegar a registro
          },
          child: const Text('Regístrate'),
        ),
      ],
    );
  }
}
