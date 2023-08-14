import 'package:flutter/material.dart';
import 'package:tech_application/constant/my_colors.dart';

class DividerTech extends StatelessWidget {
  const DividerTech({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: size.width / 6,
      endIndent: size.width / 6,
      color: SolidColors.dividerColor,
      thickness: 0.8,
    );
  }
}
