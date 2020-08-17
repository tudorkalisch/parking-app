class User {
  String id;
  String username;
  bool isPremium;

  User(this.id, this.username, this.isPremium);

  User.empty();

  static fromJson(e) {
    User u = User.empty();
    u.id = e['id'];
    u.username = e['username'];
    u.isPremium = e['premium'];
    return u;
  }
}
