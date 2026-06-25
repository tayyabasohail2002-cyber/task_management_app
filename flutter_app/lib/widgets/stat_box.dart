import 'package:flutter/material.dart';
import 'glass_card.dart';
import '../theme/app_text_styles.dart';

class StatBox extends StatelessWidget {
  final String title;
  final String value;

  const StatBox({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassCard(
        child: Column(
          children: [
            Text(value, style: AppTextStyles.statNumber),
            const SizedBox(height: 4),
            Text(title, style: AppTextStyles.subText),
          ],
        ),
      ),
    );
  }
}