import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/auth_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        _showError('Debes aceptar los términos y condiciones');
        return;
      }

      setState(() => _isLoading = true);

      try {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/register'), //  endpoint FastAPI
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": _nameController.text,
            "email": _emailController.text,
            "password": _passwordController.text,
          }),
        );

        final data = json.decode(response.body);

        if (response.statusCode == 200) {
          if (mounted) {
            Navigator.pop(context); // vuelve al login
          }
        } else {
          _showError(data['detail'] ?? 'Error al registrarse');
        }
      } catch (e) {
        _showError('No se pudo conectar al servidor');
      }

      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Fondo decorativo ──────────────────────────────────────────
          Positioned(
            top: -60,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryBlue.withOpacity(0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.lightBlue.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── Contenido ─────────────────────────────────────────────────
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  children: [
                    // App bar personalizado
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          _BackButton(onTap: () => Navigator.pop(context)),
                          const Spacer(),
                          const AppLogo(size: 38),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 28),
                              const AuthHeader(
                                title: 'Crea tu\ncuenta ',
                                subtitle: 'Completa tus datos para comenzar',
                              ),
                              const SizedBox(height: 36),

                              // Nombre completo
                              AuthTextField(
                                label: 'Nombre completo',
                                hint: 'Juan García',
                                prefixIcon: Icons.person_outline_rounded,
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                validator: (v) {
                                  if (v == null || v.isEmpty)
                                    return 'Ingresa tu nombre';
                                  if (v.length < 3) return 'Nombre muy corto';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Email
                              AuthTextField(
                                label: 'Correo electrónico',
                                hint: 'tu@correo.com',
                                prefixIcon: Icons.email_outlined,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) {
                                  if (v == null || v.isEmpty)
                                    return 'Ingresa tu correo';
                                  if (!v.contains('@'))
                                    return 'Correo inválido';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Contraseña
                              AuthTextField(
                                label: 'Contraseña',
                                hint: '••••••••',
                                prefixIcon: Icons.lock_outline_rounded,
                                isPassword: true,
                                controller: _passwordController,
                                validator: (v) {
                                  if (v == null || v.isEmpty)
                                    return 'Ingresa una contraseña';
                                  if (v.length < 6)
                                    return 'Mínimo 6 caracteres';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Confirmar contraseña
                              AuthTextField(
                                label: 'Confirmar contraseña',
                                hint: '••••••••',
                                prefixIcon: Icons.lock_outline_rounded,
                                isPassword: true,
                                controller: _confirmPassController,
                                validator: (v) {
                                  if (v == null || v.isEmpty)
                                    return 'Confirma tu contraseña';
                                  if (v != _passwordController.text) {
                                    return 'Las contraseñas no coinciden';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // Términos y condiciones
                              _TermsCheckbox(
                                value: _acceptTerms,
                                onChanged: (v) =>
                                    setState(() => _acceptTerms = v ?? false),
                              ),
                              const SizedBox(height: 28),

                              // Botón registrar
                              PrimaryButton(
                                text: 'Crear cuenta',
                                onPressed: _handleRegister,
                                isLoading: _isLoading,
                              ),
                              const SizedBox(height: 28),

                              // Ya tienes cuenta
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '¿Ya tienes cuenta? ',
                                      style: TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 14,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: const Text(
                                        'Iniciar sesión',
                                        style: TextStyle(
                                          color: AppColors.primaryBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Checkbox de términos ─────────────────────────────────────────────────────
class _TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _TermsCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            side: const BorderSide(color: AppColors.steelBlue, width: 1.5),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: const TextSpan(
              text: 'Acepto los ',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'Términos y condiciones',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: ' y la '),
                TextSpan(
                  text: 'Política de privacidad',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Botón de regreso ─────────────────────────────────────────────────────────
class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.inputBorder, width: 1.5),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
