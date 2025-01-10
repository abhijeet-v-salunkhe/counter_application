import 'package:firebase_auth/firebase_auth.dart';

Future<String> logIn({var emailAddress, var password}) async {

  try {

    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    print("Logined");
    return "Logined";

  } on FirebaseAuthException catch (e) {
    print ("On FirebaseAuthException : ${e.code} *******************************************");

      print("No user found for that Email");
      return "Invalid credentials, please check Email and password";

  
  } catch (e) {

    print("Error : $e");
    return "Something went wrong, please try again or try after some time";

  }

}
