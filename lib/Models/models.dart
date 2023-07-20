class Userlogin {
  String? username;
  String? password;

  Userlogin({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }

  factory Userlogin.fromMap(Map<String, dynamic> map) {
    return Userlogin(
      username: map['username'],
      password: map['password'],
    );
  }
}
