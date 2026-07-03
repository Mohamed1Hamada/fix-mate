import 'dart:developer';

import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/error/supabase_exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Map<String, dynamic>>> getDataWithSpacificId({
  required String tableName,
  required String id,
  String? primaryKey,
  String? orderBy,
}) async {
  final supabase = getIt<SupabaseClient>();

  try {
    final response =
        await supabase.from(tableName).select().eq(primaryKey ?? 'id', id)
        // .order(orderBy ?? 'created_at')
        ;

    if (response.isNotEmpty) {
      return response;
    } else {
      return [];
    }
  } catch (e) {
    log(e.toString());
    throw SupabaseExceptions(errorMessage: '❌ Error while fetching data: $e');
  }
}
