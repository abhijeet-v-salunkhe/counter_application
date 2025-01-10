import 'package:couter_application/authentication/domain/user_login.dart';
import 'package:couter_application/authentication/view/register.dart';
import 'package:couter_application/counter_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final TextEditingController _useremailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _useremailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  var isLogInProceessOn = false;
  var logInfirebaseResponse = "";

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/auth_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(40),
          color: Colors.transparent,
          child: Container(
            height: 450,
            width: 350,
            decoration: BoxDecoration(
              color: const Color.fromARGB(193, 255, 255, 255),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 30,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "User Name or Email",
                        ),
                        keyboardType: TextInputType.text,
                        controller: _useremailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the Username";
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Enter Password",
                        ),
                        maxLength: 16,
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return "Password is always greater than 7";
                          }
                          return null;
                        },
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {

                            setState(() {
                              isLogInProceessOn = true;
                            });

                            var loginStatus = await logIn(
                              emailAddress: _useremailController.text,
                              password: _passwordController.text,
                            );

                            setState(() {
                              logInfirebaseResponse = loginStatus;
                            });

                            if (loginStatus == "Logined") {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => CounterScreen(),
                                ),
                              );
                            } else {
                              setState(() {
                                isLogInProceessOn = false;
                              });
                            }

                          }
                        },
                        child:
                            isLogInProceessOn
                                ? CircularProgressIndicator()
                                : Text("Login"),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ),
                                );
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    113,
                                    65,
                                    145,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          logInfirebaseResponse,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
