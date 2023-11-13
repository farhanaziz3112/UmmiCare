import 'package:flutter/material.dart';
import 'package:ummicare/screens/auth/forgotPassword.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/shared/constant.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool loading = false;

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color(0xff71cbca),
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0.0,
            //   title: Text('Sign In To Your Account'),
            //   actions: <Widget>[
            //     TextButton.icon(
            //       icon: Icon(
            //         Icons.person,
            //         color: Colors.black,
            //       ),
            //       label: Text(
            //         'Register',
            //         style: TextStyle(color: Colors.black),
            //       ),
            //       onPressed: () => widget.toggleView(),
            //     )
            //   ],
            // ),
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 200.0,
                      child: Center(
                        child: Text(
                          'UmmiCare',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 50.0,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an email' : null,
                      onChanged: (value) => {setState(() => email = value)},
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (value) => value!.length < 8
                          ? 'Enter a password with more than 8 characters'
                          : null,
                      onChanged: (value) => {setState(() => password = value)},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const forgotPassword()));
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff29180),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          )),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              errorMessage =
                                  'Account details entered is not available';
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () => widget.toggleView(),
                          child: const Text(
                            'Register here',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
