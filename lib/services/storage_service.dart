import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
class Storage{
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(
      String filePath,
      String fileName,
      ) async{
    File file = File(filePath);
    try{
      await storage.ref('trees/$fileName').putFile(file);
    }on FirebaseException catch(e){
      print(e);
    }
  }

  Future<ListResult> listFiles() async{
    ListResult results = await storage.ref('trees').listAll();
    results.items.forEach((Reference ref) { 
      // print('found file: $ref');
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async{
    String downloadURL = await storage.ref('trees').getDownloadURL();
    return downloadURL;
  }
}