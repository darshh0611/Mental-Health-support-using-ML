import 'package:flutter/material.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoThumbnailContainer extends StatelessWidget {
  final String videoUrl;
  final double width;
  final double height;

  VideoThumbnailContainer({
    required this.videoUrl,
    this.width = 100.0,
    this.height = 100.0,
  });

  Future<void> _launchVideo() async {
    if (await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      throw 'Could not launch $videoUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchVideo,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue, // Change to your desired border color
          ),
        ),
        child: VTImageView(
          videoUrl: videoUrl,
          width: width,
          height: height,
          errorBuilder: (context, error, stack) {
            return Container(
              color: Colors.blue,
              child: Center(
                child: Text("Image Loading Error"),
              ),
            );
          },
          assetPlaceHolder: '',
        ),
      ),
    );
  }
}
