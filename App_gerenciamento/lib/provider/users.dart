import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/dummy_users.dart';
import 'package:flutter_application_1/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _itens = {...DUMMY_USERS};

  List<User> get all {
    return [..._itens.values];
  }

  int get count {
    return _itens.length;
  }

  User byIndex(int i) {
    return _itens.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _itens.containsKey(user.id)) {
      _itens.update(user.id, (_) => user);
      notifyListeners();
    } else {
      _itens.putIfAbsent(
          '100',
          () => User(
              id: user.id,
              name: user.name,
              email: user.email,
              cpf: user.cpf,
              funcao: user.funcao,
              password: user.password,
              avatarUrl: user.avatarUrl));

      //adicionar
      //alterar

      notifyListeners();
    }
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _itens.remove(user.id);
      notifyListeners();
    }
  }
}
