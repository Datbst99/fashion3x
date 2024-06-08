

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Configs/constant.dart';
import '../../Configs/router.dart';
import '../Components/button_component.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  bool isLoading = false;
  String showMessageError = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future<void> _login(BuildContext context) async {
    showMessageError = "";
    if (_formKey.currentState?.validate() ?? false) {
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        Navigator.pushReplacementNamed(context, '/home');

      } on FirebaseAuthException catch (e){
        setState(() {
          showMessageError = e.message ?? 'Login failed';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColorDeep,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: whiteColor.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: zoomMilliseconds),
                      child: const Text(
                        "Đăng ký",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: textColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if(showMessageError.isNotEmpty)
                      Text(
                        showMessageError,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 10),
                    ZoomIn(
                      duration: const Duration(milliseconds: zoomMilliseconds),
                      child: TextFormField(
                        controller: _emailController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          contentPadding:
                          const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vui lòng nhập Email";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ZoomIn(
                      duration: const Duration(milliseconds: zoomMilliseconds),
                      child: TextFormField(
                        controller: _passwordController,
                        autofocus: false,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          labelText: 'Mật khẩu',
                          contentPadding:
                          const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: obscureText
                                  ? 'show password'
                                  : 'hide password',
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vui lòng nhập mật khẩu";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      duration: const Duration(milliseconds: zoomMilliseconds),
                      child: ButtonComponent(
                        width: MediaQuery.of(context).size.width / 2,
                        onPressed: isLoading ? null : ()  {
                          setState(() {});
                          _login(context);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: isLoading
                            ? const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2.0,
                          ),
                        )
                            : const Text(
                          'Đăng ký',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    TextButton(onPressed: (){
                      Navigator.popAndPushNamed(context, RouteApp.login);
                    }, child: const Text('Đăng nhập'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
