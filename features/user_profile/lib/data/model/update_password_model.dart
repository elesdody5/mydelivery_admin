class UpdatePasswordModel {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  UpdatePasswordModel(
      {this.oldPassword, this.newPassword, this.confirmPassword});

  Map<String, dynamic> toJson() => {
        "passwordCurrent": oldPassword,
        "password": newPassword,
        "passwordConfirm": confirmPassword
      };
}
