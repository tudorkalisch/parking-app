class User {
  String id;
  String username;

  User(this.id, this.username);

  User.empty();

  static fromJson(e) {
    User u = User.empty();
    u.id = e['id'];
    u.username = e['username'];
    return u;
  }
}
