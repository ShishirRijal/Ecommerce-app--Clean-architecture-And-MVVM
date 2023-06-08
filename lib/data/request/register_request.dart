class RegisterRequest {
  String countryMobileCode;
  String username;
  String email;
  String password;
  String profilePicture;
  String mobileNumber;

  RegisterRequest({
    required this.countryMobileCode,
    required this.username,
    required this.email,
    required this.password,
    required this.profilePicture,
    required this.mobileNumber,
  });
}
