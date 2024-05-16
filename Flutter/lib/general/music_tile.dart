import 'package:flutter/material.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    Key? key,
    required this.title,
    required this.length,
    this.isLocked = true,
  }) : super(key: key);

  final String title;
  final bool isLocked;
  final String length;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(
            isLocked ? Icons.lock : Icons.play_arrow,
            color: Colors.grey,
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white, // Changed to white text color
              fontFamily: 'Poppins', // Set font family to Poppins
              fontWeight: isLocked ? FontWeight.w600 : FontWeight.w700,
            ),
          ),
          Spacer(),
          Text(
            length,
            style: TextStyle(
              color: Colors.white, // Changed to white text color
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'Poppins', // Set font family to Poppins
            ),
          ),
        ],
      ),
    );
  }
}
