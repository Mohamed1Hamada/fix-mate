

import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/error/supabase_exceptions.dart';
import 'package:fixmate/core/network/supabase/auth/handel_auth_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> forgetPassword(String email) async {
  try {
    await getIt<SupabaseClient>().auth.resetPasswordForEmail(email);
  } on AuthException catch (e) {
    throw SupabaseExceptions(errorMessage: handleAuthError(e));
  } catch (e) {
    throw SupabaseExceptions(errorMessage: e.toString());
  }
}
