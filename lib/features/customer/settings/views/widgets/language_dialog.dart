// import 'package:compound/app/cubit/localization_cubit.dart';
// import 'package:compound/core/utilies/colors/app_colors.dart';
// import 'package:compound/core/utilies/extensions/app_extensions.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LanguageDialog extends StatefulWidget {
//   const LanguageDialog({super.key});

//   @override
//   State<LanguageDialog> createState() => _LanguageDialogState();
// }

// class _LanguageDialogState extends State<LanguageDialog> {
//   String? _selectedLang;

//   @override
//   void initState() {
//     super.initState();
//     _loadSelectedLanguage();
//   }

//   /// 🧠 تحميل اللغة الحالية (إما من SharedPreferences أو من EasyLocalization)
//   Future<void> _loadSelectedLanguage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedLang = prefs.getString('selected_language');

//     // لو مفيش لغة محفوظة نستخدم اللغة الحالية من EasyLocalization
//     final currentLang =
//         savedLang ?? context.locale.languageCode; // مثال: "ar" أو "en"

//     setState(() {
//       _selectedLang = currentLang;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final kPrimaryColor = AppColors.kPrimaryColor;

//     return Center(
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.85,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E1E1E),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.6),
//                 blurRadius: 15,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Choose Language',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               Divider(color: Colors.white.withOpacity(0.3)),
//               const SizedBox(height: 10),
//               _buildLanguageOption('English', 'en', kPrimaryColor),
//               const SizedBox(height: 8),
//               _buildLanguageOption('العربية', 'ar', kPrimaryColor),
//               const SizedBox(height: 25),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: () => context.popScreen(),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: kPrimaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 25,
//                         vertical: 10,
//                       ),
//                     ),
//                     onPressed: _selectedLang == null
//                         ? null
//                         : () async {
//                             await context
//                                 .read<TranslationCubit>()
//                                 .changeLanguage(context, _selectedLang!);
//                             context.popScreen();
//                           },
//                     child: const Text(
//                       'Confirm',
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLanguageOption(
//       String label, String langCode, Color primaryColor) {
//     final bool isSelected = _selectedLang == langCode;

//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: () => setState(() => _selectedLang = langCode),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//         decoration: BoxDecoration(
//           color:
//               isSelected ? primaryColor.withOpacity(0.15) : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? primaryColor : Colors.white24,
//             width: 1.2,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//               ),
//             ),
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               height: 20,
//               width: 20,
//               decoration: BoxDecoration(
//                 color: isSelected ? primaryColor : Colors.transparent,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isSelected ? primaryColor : Colors.white38,
//                   width: 2,
//                 ),
//               ),
//               child: isSelected
//                   ? const Icon(Icons.check, size: 14, color: Colors.black)
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
