import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  
  static Future<String> loadPDF() async {
     final url = Uri.parse("http://www.pdf995.com/samples/pdf.pdf");
     final response = await http.get(url);

    var dir = await getApplicationDocumentsDirectory();
    
     File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
