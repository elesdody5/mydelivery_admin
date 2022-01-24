class ResetPasswordModel {
  String? token;
  String? password;
  String? confirmPassword;

  ResetPasswordModel({this.token, this.password, this.confirmPassword});

  Map<String, dynamic> toJson() =>
      {"password": password, "passwordConfirm": confirmPassword};
}
