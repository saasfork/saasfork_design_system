class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}
