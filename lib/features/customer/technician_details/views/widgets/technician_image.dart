import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class TechnicianImage extends StatelessWidget {
  const TechnicianImage({
    super.key,
    required this.technicianImage,
  });

  final String technicianImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: SizeConfig.width * 0.2,
      backgroundImage: NetworkImage(technicianImage),
    );
  }
}
