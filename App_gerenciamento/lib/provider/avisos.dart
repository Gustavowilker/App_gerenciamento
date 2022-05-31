import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/message_model.dart';

class Avisoss with ChangeNotifier {
  Uri url =
      Uri.https('gerenciapp2-default-rtdb.firebaseio.com', '/Avisos.json');
  Map<String, dynamic> listStrings = {};
  Map<String, dynamic> map = {};

  Future<void> _getInformationFromBack() {
    return http.get(url).then((response) {
      Map<String, dynamic> map = json.decode(response.body);
      listStrings = {};
      map.forEach((key, value) {
        setState(key, value);
            notifyListeners();

      });
    });
  }

  List<Menssage> get all {
    return [...listStrings.values];
  }

  void setState(String key, String value) {
    listStrings.addAll(map[key]['word']);
  }

  int get count {
    _getInformationFromBack();
    return listStrings.length;
  }

  Menssage byIndex(int i) {
    _getInformationFromBack();
    return listStrings.values.elementAt(i);
  }
}
