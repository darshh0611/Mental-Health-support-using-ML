import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipd/colors.dart';

class StyleCard extends StatelessWidget {
  final String title;
  final String img;
  final void Function() onTap;
  final Color? bgColor;
  final Color? textColor;
  final String? description;
  final bool? isOrg;

  const StyleCard({
    Key? key,
    required this.title,
    required this.img,
    required this.onTap,
    this.bgColor,
    this.textColor,
    this.description,
    this.isOrg,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: RadialGradient(
                radius: 0.8,
                center: isOrg == true
                    ? Alignment.centerRight
                    : Alignment.bottomRight,
                colors: [AppColors.primaryLight, bgColor ?? AppColors.secondary],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isOrg == true
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor
                        ),
                      ),
                      SizedBox(height: 8),
                      if (description != null)
                        Text(
                          description!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: textColor,
                          ),
                          softWrap: true,
                        ),
                    ],
                  ),
                  Align(
                    alignment: isOrg == true
                        ? Alignment.centerRight
                        : Alignment.bottomRight,
                    child: SvgPicture.asset(
                      img,
                      width: 80, // Adjust the width as needed
                      height: 100, // Adjust the height as needed
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
