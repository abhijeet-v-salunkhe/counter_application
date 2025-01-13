import 'package:couter_application/authentication/domain/authentication_service.dart';
import 'package:couter_application/authentication/view/login.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _useremailController = TextEditingController();
  final authenticationService = AuthenticationService();
  var isResetPasswordOn = false;
  var resetPasswordStatus = "";

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
          //borderRadius: BorderRadius.circular(40),
          color: Colors.transparent,
          child: Container(
            height: 250,
            width: 350,
            decoration: BoxDecoration(
              color: const Color.fromARGB(193, 255, 255, 255),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "User Email",
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
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isResetPasswordOn = true;
                            });

                            var status = await authenticationService
                                .resetPassword(
                                  email: _useremailController.text,
                                );

                            setState(() {
                              resetPasswordStatus = status;
                            });

                            // if (status == "Logined") {
                            //   Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //       builder: (context) => CounterScreen(),
                            //     ),
                            //   );
                            // } else {
                            //   setState(() {
                            //     isLogInProceessOn = false;
                            //   });
                            // }
                          }
                        },
                        child:
                            isResetPasswordOn
                                ? null
                                : Text("Forgot Password"),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Return to login page"),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
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
                          resetPasswordStatus,
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
