class User {
  String username;
  String email;
  String password;
  String birth;
  String adress;

  User({
    required this.username,
    required this.email,
    required this.password,
    this.birth = '',
    this.adress = '',
  });
}
