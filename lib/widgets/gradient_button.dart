import 'package:flutter/material.dart';
import '../core/themes.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 60,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: AppTheme.goldGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        // style: ElevatedButton.styleFrom(
        // //  backgroundColor: Colors.transparent,
        //   foregroundColor: AppTheme.darkPrimary,
        //  // shadowColor: Colors.transparent,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(borderRadius),
        //   ),
        // ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
              //User inter 16px semibold
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white
                )
              ),
      ),
    );
  }
} 