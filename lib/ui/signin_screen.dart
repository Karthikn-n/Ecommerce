import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/bloc/auth/auth_event.dart';
import 'package:e_commerce/bloc/auth/auth_state.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/widgets/auth/form_layout_widget.dart';
import 'package:e_commerce/widgets/common/text_form_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Singin"),
      // ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("LoggedIns successfully")),
            );
            Navigator.pushReplacementNamed(context, AppRouter.home);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: size.width > 600
                        ? size.width * 0.3
                        : size.height * 0.4,
                    child: Image.asset(
                      "assets/signup.png",
                      fit: BoxFit.contain,
                    ),
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
                            const SizedBox(height: 15),
                            FormLayoutWidget(
                              title: "Password",
                              isObscure: !state.isPasswordVisible,
                              maxLine: 1,
                              borderRadius: 24.0,
                              hintText: "Enter your password",
                              prefixIcon: Icon(Icons.lock, size: 20),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(ClearSigninError());
                                  context.read<AuthBloc>().add(TogglePasswordVisibility());
                                },
                                icon: Icon(state.isPasswordVisible 
                                  ? Icons.visibility 
                                  : Icons.visibility_off
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
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
                              onPressed: state.isLoading
                              ? () {}
                              :  () {
                                if(_passwordController.text.length < 6){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Password must atleaset 6 letter")),
                                  );
                                  return;
                                } else {
                                  context.read<AuthBloc>().add(SignInRequested(_emailController.text, _passwordController.text));
                                  if (state.errorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.errorMessage!)),
                                    );
                                  }
                                }
                              },
                              child: state.isLoading
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Center(
                                    child: CircularProgressIndicator(color: Colors.white,),
                                  ),
                                )
                              : Text("Signin"),
                            ),
                            const SizedBox(height: 30,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an acount ? "),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, AppRouter.signup),
                        child: Text("Register", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
