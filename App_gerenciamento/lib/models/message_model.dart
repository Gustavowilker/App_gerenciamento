class Menssage {
  late String text;

  Menssage(
    this.text,
  );

  Menssage.fromJson(Map<String, dynamic> json) {
    text = json['word'];
  }
}
