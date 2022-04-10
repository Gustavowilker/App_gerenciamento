class User {
  final String id;
  final String name;
  final String email;
  final String cpf;
  final String funcao;
  final String password;
  final String avatarUrl;

  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.cpf,
      required this.funcao,
      required this.password,
      required this.avatarUrl});
}
