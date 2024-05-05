
class UserModel {
  String? id;
  String firstName;
  String surname;
  String email;
  String phone;
  String password;

  UserModel({
    this.id,
    required this.firstName,
    required this.surname,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      surname: json['surname'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }

  toJson() {
    return{
      'firstname':firstName,
      'surname':surname,
      'email':email,
      'password':password,
      'phone':phone
    };
  }
}
