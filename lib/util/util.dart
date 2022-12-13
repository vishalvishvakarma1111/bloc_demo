import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
class Util{


  static Future<void> deleteTempDirectory() async {
    try {
      Directory tempFolder = await getTemporaryDirectory();
      Directory myDir = Directory('${tempFolder.path}/"test_test"');
      if (await myDir.exists()) {
        myDir.delete(recursive: true);
      }
    } catch (e) {
      if (kDebugMode) {
        print("------ catch delete directory ${e.toString()}");
      }
    }
  }



  static Future<File> downloadFile(String url) async {
    String dir = (await getTemporaryDirectory()).path;
    await Util.deleteTempDirectory();
    Directory myDirectory = await Directory('$dir/"test_test"').create();
    File newFile = File('${myDirectory.path}/${p.basename(url)}');
    File file = File(url);
    print("--print ----------as1---${file.path}.................");
//    File res = await file.create();
    Uint8List bytes = await file.readAsBytes();
    print("--print ----------as2---${file.path}...........${bytes.lengthInBytes}......");
    File resFile = await newFile.writeAsBytes(bytes);
    print("--print ----------as3---${resFile.path}.................");
    return resFile;
  }


}