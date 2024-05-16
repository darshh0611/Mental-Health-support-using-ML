import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';
import '../colors.dart';
import '../general/music_tile.dart';
import '../home.dart';

class MeditateScreen extends StatefulWidget {
  const MeditateScreen({Key? key}) : super(key: key);

  @override
  _MeditateScreenState createState() => _MeditateScreenState();
}

class _MeditateScreenState extends State<MeditateScreen> {
  late CountDownController _controller;
  int _selectedDurationIndex = 0; // Index of the selected duration
  final List<int> _timerDurations = [600, 900, 1800, 2700]; // Timer durations in seconds
  AudioPlayer audioPlayer = AudioPlayer(); // Initialize AudioPlayer instance

  @override
  void initState() {
    super.initState();
    _controller = CountDownController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: AppColors.secondaryblue,
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MEDITATE',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CircularCountDownTimer(
                key: UniqueKey(), // Ensure widget rebuilds when timer duration changes
                duration: _timerDurations[_selectedDurationIndex],
                initialDuration: 0,
                controller: _controller,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                ringColor: Colors.white,
                fillColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                strokeWidth: 3.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textFormat: CountdownTextFormat.MM_SS,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: false,
                onComplete: () {
                  print('Countdown Completed');
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      _controller.pause();
                    },
                    icon: Icon(Icons.pause),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.start();
                      //_playAudio(); // Play audio when meditation starts
                    },
                    icon: Icon(Icons.play_arrow),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.restart(duration: _timerDurations[_selectedDurationIndex]);
                    },
                    icon: Icon(Icons.replay),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ],
              ),
              SizedBox(height: 60),
              MusicTile(
                title: 'Rainfall',
                length: '30:00',
                isLocked: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userId: '',)));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 25,
            width: 25,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      title: const Text(
        'Reflect!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            _showTimerOptions(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/dots.svg',
            height: 5,
            width: 5,
          ),
        ),
      ],
    );
  }

  void _showTimerOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Timer Duration'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _timerDurations.map((duration) {
              int minutes = duration ~/ 60;
              return ListTile(
                title: Text('$minutes mins'),
                onTap: () {
                  setState(() {
                    _selectedDurationIndex = _timerDurations.indexOf(duration);
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Function to play audio
  // void _playAudio() {
  //   audioPlayer.play(Uri.file('assets/audio/rainfall.mp3').toString(), isLocal: true);
  // }

}
