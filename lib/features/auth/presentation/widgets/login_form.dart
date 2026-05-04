import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/utils/validators.dart';

/// Formulario de login – capa Presentation
/// Usa username (DummyJSON requiere username, no email).
class LoginForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState>  formKey;
  final VoidCallback          onSubmit;

  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
    required this.onSubmit,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // ─── Usuario ───────────────────────────────────────────────
          TextFormField(
            controller: widget.usernameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: Validators.username,
            decoration: const InputDecoration(
              labelText: 'Usuario',
              hintText: 'ej: emilys',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: AppDimens.paddingMD),
          // ─── Contraseña ───────────────────────────────────────────
          TextFormField(
            controller: widget.passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            validator: Validators.password,
            onFieldSubmitted: (_) => widget.onSubmit(),
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
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
