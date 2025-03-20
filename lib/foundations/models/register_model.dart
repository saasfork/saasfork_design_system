class RegisterModel {
  final String email;
  final String password;
  // Ajoutez d'autres champs si nécessaire
  
  RegisterModel({required this.email, required this.password});
  
  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}