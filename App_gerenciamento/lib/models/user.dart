class User {
  String? name;
  String? cpf;
  String? id;
  String? email;
  String? password;
  String? funcao;
  String? avatarUrl;
  bool? keepOn;

  User(
      {this.name,
      this.cpf,
      this.id,
      this.email,
      this.password,
      this.funcao,
      this.avatarUrl,
      this.keepOn});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cpf = json['cpf'];
    id = json['matricula'];
    email = json['email'];
    password = json['password'];
    funcao = json['funcao'];
    avatarUrl = json['avatarUrl'];
    keepOn = json['keepOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cpf'] = this.cpf;
    data['matricula'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['funcao'] = this.funcao;
    data['avatarUrl'] = this.avatarUrl;
    data['keepOn'] = this.keepOn;
    return data;
  }
}
