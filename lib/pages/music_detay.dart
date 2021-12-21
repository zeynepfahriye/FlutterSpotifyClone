import 'dart:io';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MusicDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final String img;
  final String songUrl;

  const MusicDetailPage(
      {Key? key,
      required this.title,
      required this.description,
      required this.color,
      required this.img,
      required this.songUrl})
      : super(key: key);

  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  double _currentSliderValue = 20;
  late AudioPlayer advancedPlayer;
  late AudioCache audioCache;
  bool isPlaying = true;
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    playSound(widget.songUrl);
  }

  playSound(localPath) async {
    await audioCache.play(localPath);
  }

  stopSound(localPath) async {
    Uri audioFile = await audioCache.load(localPath);
    await advancedPlayer.setUrl(audioFile.path);
    advancedPlayer.stop();
  }

  seekSound() async {
    Uri audioFile = await audioCache.load(widget.songUrl);
    await advancedPlayer.setUrl(audioFile.path);
    advancedPlayer.seek(const Duration(milliseconds: 2000));
  }

  @override
  void dispose() {
    super.dispose();
    stopSound(widget.songUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), child: getAppBar),
      body: getBody(),
    );
  }

  Widget get getAppBar {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FeatherIcons.moreVertical,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 100,
                  height: size.width - 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: widget.color,
                          blurRadius: 50,
                          spreadRadius: 5,
                          offset: Offset(-10, 40))
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 60,
                  height: size.width - 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.img), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: size.width - 80,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    AntIcons.folderOpenOutlined,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          widget.description,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      )
                    ],
                  ),
                  const Icon(
                    FeatherIcons.moreVertical,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Slider(
              activeColor: Colors.green,
              value: _currentSliderValue,
              min: 0,
              max: 200,
              onChanged: (value) {
                setState(() {
                  _currentSliderValue = value;
                });
                seekSound();
              }),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              children: [
                Text('1:50',
                    style: TextStyle(color: Colors.white.withOpacity(0.5))),
                Text('4:68',
                    style: TextStyle(color: Colors.white.withOpacity(0.5))),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FeatherIcons.shuffle,
                      color: Colors.white.withOpacity(0.8),
                      size: 25,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FeatherIcons.skipBack,
                      color: Colors.white.withOpacity(0.8),
                      size: 25,
                    )),
                IconButton(
                  iconSize: 50,
                  icon: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                    child: Center(
                        child: Icon(
                         isPlaying ? Icons.stop: Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    )),
                  ),
                  onPressed: () {
                    if (isPlaying) {
                      stopSound(widget.songUrl);
                      setState(() {
                        isPlaying = false;
                      });
                    }else{
                      playSound(widget.songUrl);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FeatherIcons.skipForward,
                      color: Colors.white.withOpacity(0.8),
                      size: 25,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      AntIcons.retweetOutlined,
                      color: Colors.white.withOpacity(0.8),
                      size: 25,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                FeatherIcons.tv,
                color: Colors.green,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  'Chromecast is ready',
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
