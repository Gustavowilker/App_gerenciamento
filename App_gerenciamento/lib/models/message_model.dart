import 'package:flutter_application_1/models/user.dart';

class Menssage {
  final User sender;
  final String time;
  final String text;
  final bool unread;

  Menssage(
    this.sender,
    this.time,
    this.text,
    this.unread,
  );
}
