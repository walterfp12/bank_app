import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_dimens.dart';
import '../controllers/auth_controller.dart';
import '../states/auth_state.dart';
import '../widgets/login_button.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

/// Pantalla de Login – capa Presentation
/// HU 2.2: Validaciones de usuario/contraseña, estados loading/error/éxito.
/// Usa ConsumerStatefulWidget para acceder a Riverpod.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey            = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authControllerProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    // Escucha cambios de estado para reaccionar a auth/error
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        authenticated: (_) {
          if (context.mounted) context.go('/dashboard');
        },
        error: (message) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
      );
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AuthStateLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.paddingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimens.paddingXXL),
              const LoginHeader(),
              const SizedBox(height: AppDimens.paddingXXL),
              LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
                formKey:   _formKey,
                onSubmit:  isLoading ? () {} : _handleLogin,
              ),
              const SizedBox(height: AppDimens.paddingMD),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: isLoading ? null : () {
                    // TODO HU 4.x – recuperar contraseña
                  },
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ),
              const SizedBox(height: AppDimens.paddingLG),
              LoginButton(
                onPressed: isLoading ? null : _handleLogin,
                isLoading: isLoading,
              ),
              const SizedBox(height: AppDimens.paddingXL),
              _RegisterLink(isLoading: isLoading),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterLink extends StatelessWidget {
  final bool isLoading;
  const _RegisterLink({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('¿No tienes cuenta? '),
        TextButton(
          onPressed: isLoading ? null : () {
            // TODO HU 4.x – navegación a registro
          },
          child: const Text('Regístrate'),
        ),
      ],
    );
  }
}
