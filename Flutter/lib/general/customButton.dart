import 'package:flutter/material.dart';
import 'package:ipd/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;

  CustomButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 75,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.primary,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
