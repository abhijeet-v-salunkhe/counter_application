import 'package:couter_application/authentication/domain/user_registration.dart';
import 'package:couter_application/authentication/view/login.dart';
import 'package:couter_application/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isCheckingProcess = false;
  var userRegistration = UserRegistration();

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
            margin: EdgeInsets.all(30),
            height: 600,
            width: 600,
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
                    spacing: 10,
                    children: <Widget>[
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]'),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "First name",
                        ),
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the name";
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]'),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Last name",
                        ),
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the Last name";
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@.]'),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Enter email abc12@gmail.com",
                        ),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the Email";
                          } else if (!RegExp(
                            r'[a-zA-Z0-9_.+-/*!#%&]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9]{2,}$',
                          ).hasMatch(value)) {
                            return "Please enter valid Email";
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Set Password",
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

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Confirm Password",
                        ),
                        maxLength: 16,
                        controller: _confirmpasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Confirm password doesn't match";
                          }
                          return null;
                        },
                      ),

                      ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                             print("Email Adress : ${_emailController.text} ############################################");
                             
                             setState(() {
                               _isCheckingProcess = true;
                             });

                              var _registrationProcessStatus = await userRegistration.signUp(
                              emailAddress: _emailController.text,
                              password: _passwordController.text,
                            );

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => CounterScreen(),
                              ),
                            );
                          }
                        },
                        child: _isCheckingProcess ? CircularProgressIndicator() : Text("Register"),
                      ),

                      Expanded(
                        child: Row(
                          spacing: 1,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have an account?"),
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
