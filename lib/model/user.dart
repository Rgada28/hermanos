class User {
  String id;
  String email;
  String username;
  String password;
  Name name;
  String phone;
  User(
      this.id, this.email, this.username, this.password, this.name, this.phone);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'].toString(),
      map['email'],
      map['username'],
      map['password'],
      Name.fromMap(map['name']),
      map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'name': name.toMap(),
      'phone': phone,
    };
  }
}

class Name {
  String firstName;
  String lastName;
  Name(this.firstName, this.lastName);
  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      map['firstname'],
      map['lastname'],
    );
  }

  // Convert the Name to a map
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
