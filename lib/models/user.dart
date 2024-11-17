class User {
  final String email;
  final String password;
  final String employeeId;

  User({
    required this.email,
    required this.password,
    required this.employeeId,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'employeeId': employeeId,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        employeeId: json['employeeId'],
      );
}