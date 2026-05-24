import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class SharedAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  /// Use it with **auth buttons** like
  /// `Login` , `Next` , `Go to home`
  const SharedAuthButton({
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
          fontFamily: 'Segoe-UI',
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}