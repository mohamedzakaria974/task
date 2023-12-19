import 'package:flutter/material.dart';

import 'app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final String? label;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, this.child, this.label, this.onPressed})
      : assert((child != null && label == null) ||
            (label != null && child == null));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label ?? '',
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
