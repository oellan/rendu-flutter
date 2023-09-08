class User {
  int? userId;
  String username;
  String password;
  int loginCount;

  User({
    this.userId,
    required this.username,
    required this.password,
    this.loginCount = 0,
  });
}
