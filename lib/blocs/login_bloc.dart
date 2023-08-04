import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginBloc with ChangeNotifier {
  String userID = '';
  String userPhoneNumber = '';
  String userEmail = '';
  String userPassword = '';

  String get passwordValidationMessage {
    if (userPassword == '123456') {
      return 'Password is too easy.';
    } else if (userPassword.length < 6) {
      return 'Password is too short.';
    } else {
      return 'Password is strong.';
    }
  }

  String emailValidationMessage(String value) {
    if (!emailValidator(value)) {
      return 'Invalid email format.';
    }
    return "";
  }

  bool emailValidator(String email) {
    final emailValidator = EmailValidator(errorText: "");
    return emailValidator.isValid(email);
  }

  bool get isLoginButtonEnabled {
    return userID.length == 8 &&
        userPhoneNumber.length >= 9 &&
        userPhoneNumber.length <= 11 &&
        userPhoneNumber.length != 10 &&
        emailValidator(userEmail) &&
        userPassword.length >= 6 &&
        userPassword != '123456';
  }

  void setUserID(String id) {
    userID = id;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    userPhoneNumber = phoneNumber;
    notifyListeners();
  }

  void setEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  void setPassword(String password) {
    userPassword = password;
    notifyListeners();
  }

  void login(BuildContext context) {
    if (isLoginButtonEnabled) {
      _showSuccessDialog(context);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    Fluttertoast.showToast(
      msg: 'Login Success!',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
    );
  }
}
