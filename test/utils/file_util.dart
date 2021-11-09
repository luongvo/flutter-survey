import 'dart:convert';
import 'dart:io';

class FileUtil {
  FileUtil._();

  static Future<Map<String, dynamic>> loadFile(String filePath) async {
    final file = File(filePath);
    return jsonDecode(await file.readAsString());
  }
}
