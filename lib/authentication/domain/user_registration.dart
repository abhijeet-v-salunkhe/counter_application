import 'package:firebase_auth/firebase_auth.dart';

class UserRegistration {
  Future<String> signUp({var emailAddress, var password}) async {
    try {
      print("In try block.........");
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
          print("Complete ................");
          return "Registered";
          
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak..................');
        return "The password provided is too weak, Please enter the strong password";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email..............');
        return "The account already exists for that Email";
      }
    } catch (e) {
      print("ERROR : $e ......................");
      return "Something went wrong, Please after some time";
    }
    return "Something going wrong";
  }
}