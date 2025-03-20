class ProfileModel {
  final String email;
  final String username;

  ProfileModel({required this.email, required this.username});

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'username': username};
  }
}
