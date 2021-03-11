enum UserType {PARTICULAR, PROFISSIONAL}

class User{

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.type = UserType.PARTICULAR,
    this.createAt,
  });

  String id;
  String name;
  String email;
  String phone;
  String password;
  UserType type;
  DateTime createAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, password: $password, type: $type, createAt: $createAt}';
  }
}
