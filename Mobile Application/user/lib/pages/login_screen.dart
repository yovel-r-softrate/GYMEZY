import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../main.dart'; // Import to navigate to MyHomePage
import '../widgets/scaffoldmessage.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (email == 'sam@gmail.com' && password == '123456') {
        // Navigate to MyHomePage (Dashboard) on successful login validation
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'GYMEZY'),
          ),
        );
      } else {
        CustomScaffoldMessage.show(
          context,
          message: 'Invalid credentials! Try: sam@gmail.com / 123456',
          isError: true,
        );
      }
    }
  }

  Widget _buildCollageHeader(BuildContext context, Color backgroundColor) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. Collage Images Row
        SizedBox(
          height: 260,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=300&auto=format&fit=crop",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 3),
              Expanded(
                child: Image.network(
                  "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=300&auto=format&fit=crop",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 3),
              Expanded(
                child: Image.network(
                  "https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=300&auto=format&fit=crop",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),

        // 2. Linear Gradient Overlay to fade the collage into active theme background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.45),
                  Colors.transparent,
                  backgroundColor.withOpacity(0.85),
                  backgroundColor,
                ],
                stops: const [0.0, 0.45, 0.85, 1.0],
              ),
            ),
          ),
        ),

        // 3. Floating Brand Logo (Adaptive: Frameless in Dark, Circular in Light)
        Positioned(
          bottom: 10,
          child: Theme.of(context).brightness == Brightness.dark
              ? Image.asset(
                  'assets/logo/gymezy.png',
                  color: Colors.white,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                )
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .shimmer(delay: 1000.ms, duration: 2000.ms, color: Colors.white30)
              : Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/logo/gymezy.png',
                    width: 85,
                    height: 85,
                    fit: BoxFit.contain,
                  ),
                ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.05, end: 0, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppTheme.getBackgroundColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white70 : AppTheme.primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Full-bleed Collage Header Stack
            _buildCollageHeader(context, backgroundColor),

            // Form inputs and details wrapped in standard margins
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Welcome Back",
                      style: AppTheme.getTitleStyle(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Log in to book your next session",
                      style: AppTheme.getSubtitleStyle(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 35),

                    // Email Input (Premium Filled Layout)
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: AppTheme.getTextColor(context)),
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                          color: AppTheme.getSubtitleColor(context).withOpacity(0.8),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.email_outlined, color: iconColor),
                        filled: true,
                        fillColor: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFF5F6F9),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.transparent
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.red, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password Input (Premium Filled Layout)
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: TextStyle(color: AppTheme.getTextColor(context)),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: AppTheme.getSubtitleColor(context).withOpacity(0.8),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.lock_outline, color: iconColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: isDark ? Colors.white54 : AppTheme.getSubtitleColor(context),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFF5F6F9),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.transparent
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.red, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Forgot Password Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: AppTheme.getTextColor(context).withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Login Button (Premium Gradient Button with soft glow shadow)
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.secondaryColor, Color(0xFF00D972)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.secondaryColor.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: _handleLogin,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.center,
                            child: Text(
                              "Log In",
                              style: AppTheme.buttonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Footer navigation options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppTheme.getSubtitleColor(context)),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ].animate(interval: 50.ms).fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
