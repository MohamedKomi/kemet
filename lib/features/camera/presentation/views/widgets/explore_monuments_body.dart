import 'dart:async';

import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/shared_data.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../data/info_monument_model/info_monument_model.dart';

class ExploreMonumentsBody extends StatelessWidget {
  const ExploreMonumentsBody({
    super.key,
    required this.sentData,
  });

  final Map<String, dynamic> sentData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Video(
          voice: sentData['voiceData'],
          images: sentData['images'],
        ),
        InfoTextMonument(
          size: size,
          name: sentData['name'],
          desc: sentData['desc'],
        ),
      ],
    );
  }
}

class InfoTextMonument extends StatelessWidget {
  const InfoTextMonument({
    super.key,
    required this.size,
    required this.name,
    required this.desc,
  });

  final Size size;
  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(size.width * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: Style.textThemeW700
                        .copyWith(color: mainColor, fontSize: size.width * .05),
                  ),
                ],
              ),
              Text(
                desc,
                style: Style.textThemeW400.copyWith(fontSize: size.width * .04),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Video extends StatefulWidget {
  final String voice;
  final List<MonumentImage> images;

  const Video({super.key, required this.voice, required this.images});

  @override
  State<Video> createState() => _VideoState();

}

enum TtsState { playing, stopped, paused, continued }

class _VideoState extends State<Video> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pause();
    } else if (state == AppLifecycleState.resumed) {
     _speak();
    }
  }
  FlutterTts flutterTts = FlutterTts();

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  get isPaused => ttsState == TtsState.paused;

  get isContinued => ttsState == TtsState.continued;

  int currentIndex = 0;


  bool play = false;
  bool stop = false;

  void _startAutoPlay() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        play ? currentIndex = (currentIndex + 1) % 10 : timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .3,
          width: size.width*0.7,
          child: Stack(
            children: List.generate(widget.images.length, (index) {
              final imageUrl = widget.images[index].secureUrl;
              final opacity = index == currentIndex ? 1.0 : 0.0;
              final offset = (index - currentIndex) * 200.0;

              return AnimatedPositioned(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                top: 0.0,
                left: offset,
                right: offset,
                bottom: 0.0,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: opacity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Colors.green, Colors.greenAccent,
                Icons.play_arrow, 'PLAY', _speak),
            _buildButtonColumn(
                Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
            _buildButtonColumn(
                Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
          ],
        ),
      ],
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function() func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
    play = false;
    currentIndex = 0;
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    print(result);
    if (result == 1) setState(() => ttsState = TtsState.paused);
    play = false;
  }

  Future _speak() async {
    await flutterTts.setLanguage(SharedData.getUserLan()!);
    await flutterTts.setPitch(1);

    if (widget.voice.isNotEmpty&&play==false) {
      await flutterTts.speak(widget.voice);
    }
    if(play==false) {
      _startAutoPlay();
    }
    play = true;
    flutterTts.setCompletionHandler(() {
      setState(() {
        play = false;
        currentIndex = 0;
      });
    });
  }
}
