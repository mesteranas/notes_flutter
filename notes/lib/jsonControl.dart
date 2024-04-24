import 'package:path_provider/path_provider.dart' as path_bro;
import 'dart:convert';
import 'dart:io';

Future<List<Map<String, String>>> get() async {
  Directory systemDIR = await path_bro.getApplicationDocumentsDirectory();
  File file = File("${systemDIR.path}/notes.json");

  if (await file.exists()) {
    final data = await file.readAsString();
    List<dynamic> dartData = jsonDecode(data);

    List<Map<String, String>> result = [];

    for (var item in dartData) {
      if (item is Map) {
        Map<String, String> r = {};
        item.forEach((key, value) {
          r[key.toString()] = value.toString();
        });
        result.add(r);
      } else {
        // Handle invalid data format if needed
        result.add({});
      }
    }

    return result;
  } else {
    return [
      {"name": "no notes found!", "content": "", "date": ""}
    ];
  }
}

Future<void> save(List<Map<String, String>> object) async {
  Directory systemDIR = await path_bro.getApplicationDocumentsDirectory();
  File file = File("${systemDIR.path}/notes.json");
  String data = jsonEncode(object);
  await file.writeAsString(data);
}
