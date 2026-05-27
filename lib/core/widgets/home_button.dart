import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SharedHomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  /// Use it with **home buttons** like
  /// `ORDER` , `Apply`
  const SharedHomeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primaryButton,
        fixedSize: const Size(268, 65),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}