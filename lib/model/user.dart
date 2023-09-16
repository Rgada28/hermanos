class User {
  int id;
  String email;
  String username;
  String password;
  Name name;
  String phone;
  User(
      this.id, this.email, this.username, this.password, this.name, this.phone);
}

class Name {
  String firstName;
  String lastName;
  Name(this.firstName, this.lastName);
}
