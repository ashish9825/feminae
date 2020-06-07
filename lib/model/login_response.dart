class Login {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String token;

  Login(this.id, this.email, this.firstName, this.lastName, this.token);

  Login.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        token = json['token'];
}

class LoginResponse {
  final String status;
  final Login login;
  final String error;

  LoginResponse(this.status, this.login, this.error);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        login = Login.fromJson(json['data']),
        error = "";

  LoginResponse.withError(String errorValue)
      : status = '',
        login = Login.fromJson(Map()),
        error = errorValue;
}
