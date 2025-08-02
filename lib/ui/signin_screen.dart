import 'package:e_commerce/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text("Singin"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
              child: Image.asset(
                "assets/login.jpg",
                fit: BoxFit.cover,
              ),
            ),
            // email field
            Center(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Text("Email"),
                    TextFormFieldWidget(
                      isObseure: false, 
                      prefixIcon: Icon(Icons.email_outlined, size: 20,),
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Email is reuired";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15,),
                    Text("Email"),
                    // Password field
                    TextFormFieldWidget(
                      isObseure: false, 
                      prefixIcon: Icon(Icons.lock, size: 20,),
                      textInputAction: TextInputAction.next,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      }
                    ),
                    const SizedBox(height: 15,),
                    // Singin button
                    FilledButton(
                      onPressed: () {
                        
                      }, 
                      child: Text("Signin")
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}