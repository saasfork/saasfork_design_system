class ForgotPasswordModel {
  final String email;

  ForgotPasswordModel({required this.email});

  factory ForgotPasswordModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordModel(email: map['email'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'email': email};
  }
}
