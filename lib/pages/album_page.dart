import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify_clone/json/songs_json.dart';
import 'package:spotify_clone/pages/music_detay.dart';

class AlbumPage extends StatefulWidget {
  final dynamic song;

  const AlbumPage({Key? key, this.song}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    List songAlbums = widget.song['songs'];
    return SingleChildScrollView(
        child: Stack(children: [
      Column(
        children: [
          Container(
            width: size.width,
            height: 220,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.song['img']), fit: BoxFit.cover)),
          ),
          
          const SizedBox(
            height: 30,
          ),
          
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.song['title'],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  // ignore: prefer_const_constructors
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 8, bottom: 8),
                    child: const Text(
                      'Subsribe',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: List.generate(songs.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        var color;
                        Navigator.push(
                            context,
                            PageTransition(
                                alignment: Alignment.bottomCenter,
                                child: MusicDetailPage(
                                  title: songs[index]['title'],
                                  color: songs[index]['color'],
                                  description: songs[index][color],
                                  img: songs[index]['img'],
                                  songUrl: songs[index]['song_url'],
                                ),
                                type: PageTransitionType.scale));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(songs[index]['img']),
                                    fit: BoxFit.cover),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 10),
                          Text(songs[index]['title'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Container(
                              width: size.width - 210,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(songs[index]['song_count'],
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500)),
                                  Text(songs[index]['date'],
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
              children: List.generate(songAlbums.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                            PageTransition(
                                alignment: Alignment.bottomCenter,
                                child: MusicDetailPage(
                                  title: songs[index]['title'],
                                  color: songs[index]['color'],
                                  description: songs[index]['description'],
                                  img: songs[index]['img'],
                                  songUrl: songs[index]['song_url'],
                                ),
                                type: PageTransitionType.scale)
                                );
                },
                child: Row(
                  children: [
                    Container(
                      width: (size.width - 60) * 0.77,
                      height: 50,
                      child: Text(
                        '${index+1}' + songAlbums[index]['title'],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: (size.width - 60) * 0.23,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          songAlbums[index]['duration'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration:BoxDecoration(shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.8),
                        ),
                        child: const Center(child:Icon(Icons.play_arrow,
                        color: Colors.white,
                        size: 16,),),
                      )
                      ],),
                    ),
                  ],
                ),
              ),
            );
          })),
          
        ],
      ),
      SafeArea(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    FeatherIcons.moreVertical,
                    color: Colors.white,
                  )),
            ],
          )),
    ]));
  }
}
