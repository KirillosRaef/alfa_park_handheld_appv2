import 'package:alfa_park_handheld_appv2/core/common/validation_field.dart';
import 'package:alfa_park_handheld_appv2/core/common/gradient_button.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/core/utils/show_snack_bar.dart';
import 'package:alfa_park_handheld_appv2/features/authentication/application/auth_service.dart';
import 'package:alfa_park_handheld_appv2/features/authentication/domain/user.dart';
import 'package:alfa_park_handheld_appv2/features/configuration/application/configuration_service.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            icon: const Icon(Icons.back_hand),
            onPressed: () async {
              await ref.read(configurationServiceProvider).removeConfigInSharedPerefs();
              Navigator.pushNamed(context, AppRoute.configurationScreen.name);
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In.",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ValidationField(
                hintText: 'Email',
                controller: _emailController,
              ),
              const SizedBox(height: 15),
              ValidationField(
                hintText: 'Password',
                controller: _passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 20),
              GradientButton(
                colors: const [
                  AppColors.gradient1,
                  AppColors.gradient2,
                  //AppPallete.gradient3,
                ],
                buttonText: "Sign In",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = User(
                      username: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    final isUser =
                        await ref.read(authServiceProvider).login(user: user);
                    if (isUser) {
                      Navigator.pushNamed(context, AppRoute.homeScreen.name);
                    } else {
                      showSnackBar(
                          context, "Incorrect email address or password");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
