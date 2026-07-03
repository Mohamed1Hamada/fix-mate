import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> urlLauncher({required String url}) async {
  final Uri uri = Uri.parse(url);

  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('⚠️ Could not launch $url (Maybe running on Simulator)');
    }
  } catch (e) {
    debugPrint('❌ Error launching $url: $e');
  }
}
