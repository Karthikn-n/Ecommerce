import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/bloc/auth/auth_event.dart';
import 'package:e_commerce/bloc/auth/auth_state.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/widgets/auth/form_layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? lastError;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isSingupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registered successfully")),
            );
            Navigator.pushReplacementNamed(context, AppRouter.nav);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: size.width > 600
                        ? size.width * 0.3
                        : size.height * 0.4,
                    child: Image.asset("assets/login.png", fit: BoxFit.contain),
                  ),
                  // email field
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Full name field
                           FormLayoutWidget(
                              title: "Full name",
                              isObscure: false,
                              borderRadius: 24.0,
                              hintText: "Enter your fullname",
                              prefixIcon: Icon(Icons.person_outline, size: 20),
                              textInputAction: TextInputAction.next,
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Full name is required";
                                }
                                return null;
                              },
                            ),
                            // Email field
                            const SizedBox(height: 15),
                            FormLayoutWidget(
                              title: "Email",
                              isObscure: false,
                              borderRadius: 24.0,
                              hintText: "Enter your email",
                              prefixIcon: Icon(Icons.email_outlined, size: 20),
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                return null;
                              },
                            ),
                            // Password field
                            const SizedBox(height: 15),
                            // Password field
                            FormLayoutWidget(
                              title: "Password",
                              labelText: "Password",
                              hintText: "Enter your password",
                              isObscure: !state.isSignupPasswordVisible,
                              prefixIcon: Icon(Icons.lock, size: 20),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(ClearSignupError());
                                  context.read<AuthBloc>().add(SignupTogglePasswordVisibility(),);
                                },
                                icon: Icon(
                                  state.isSignupPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
                            ),
                            // Confirm Password field
                            const SizedBox(height: 15),
                            FormLayoutWidget(
                              title: "Confirm password",
                              isObscure: !state.isSignupConfirmPasswordVisible,
                              hintText: "Confirm your password",
                              prefixIcon: Icon(Icons.lock, size: 20),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(ClearSignupError());
                                  context.read<AuthBloc>().add(SignupToggleConfirmPasswordVisibility(),);
                                },
                                icon: Icon(
                                  state.isSignupConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirm password is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            // Singin button
                            FilledButton(
                              style: FilledButton.styleFrom(
                                minimumSize: Size(double.infinity, 40),
                              ),
                              onPressed: state.isSignupLoading 
                              ? null
                              : () async {
                                if(_confirmPasswordController.text != _passwordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Password and Confirm password must match")),
                                  );
                                  return;
                                } else if(_passwordController.text.length < 6){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Password must atleaset 6 letter")),
                                  );
                                  return;
                                } else {
                                  context.read<AuthBloc>().add(SignUpRequested(
                                      _emailController.text, 
                                      _passwordController.text, 
                                      _confirmPasswordController.text, 
                                      _nameController.text,
                                    )
                                  );
                                  if (state.singupError != null ) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.singupError!)),
                                    );
                                  }
                                }
                              },
                              child: state.isSignupLoading
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Center(
                                    child: CircularProgressIndicator(color: Colors.white,),
                                  ),
                                )
                              : Text("Signup"),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an acount ? "),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, AppRouter.login),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
