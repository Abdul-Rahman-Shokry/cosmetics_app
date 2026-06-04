import 'package:cosmetics_app/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_app/core/constants/app_colors.dart';
import 'package:cosmetics_app/core/widgets/auth_button.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppImage("success_dialog_checkmark.svg", width: 100, height: 100,),

              const SizedBox(height: 25),

              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 15),

              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

              SharedAuthButton(
                text: buttonText,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );
  }
}