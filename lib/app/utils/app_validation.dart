// ignore_for_file: non_constant_identifier_names, file_names

bool EmailValidate(String value) {
  return true;
}

bool PasswordValidation(String value) {
  String pattern =
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool ValidateEmailAddress(String value) {
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regExp = RegExp(pattern);

  return !regExp.hasMatch(value);
}

bool ValidateMobileNumber(String value) {
  String pattern = r'^(?:[+0][1-9])?[0-9]{9,14}$';
  RegExp regExp = RegExp(pattern);

  return regExp.hasMatch(value);
}
