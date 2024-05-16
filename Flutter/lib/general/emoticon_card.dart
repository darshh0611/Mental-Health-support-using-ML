import 'package:flutter/material.dart';
import 'package:ipd/colors.dart';


class EmoticonCard extends StatelessWidget {
  const EmoticonCard({super.key, required this.emoticonFace, required this.mood});

  final String emoticonFace;
  final String mood;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 14,
              right: 14,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              color: AppColors.white
            ),
            child: Text(
              emoticonFace,
              style: const TextStyle(
                fontSize: 50.0,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            mood,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
