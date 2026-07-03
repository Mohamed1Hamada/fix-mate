import 'dart:developer';
import 'dart:io';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

Future<String?> uploadFileToSupabaseStorage({required File file, required String pucketName}) async {
  try {
    String fileName = "images/${Uuid().v4()}.jpg";
    await getIt<SupabaseClient>().storage.from(pucketName).upload(fileName, file);
    return getIt<SupabaseClient>()
        .storage
        .from(pucketName)
        .getPublicUrl(fileName);
  } on Exception catch (e) {
    log(e.toString());
  }
  return null;
}
