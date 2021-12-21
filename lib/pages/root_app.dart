import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'home_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }
  Widget getBody(){
    return IndexedStack(
      index: activeTab,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        HomePage(),
        const Center(
          child:Text("Library",style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),
        ),
        const Center(
          child:Text("Search",style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),
        ),
        const Center(
          child:Text("Setting",style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),
        ),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      FeatherIcons.home,
      FeatherIcons.book,
      FeatherIcons.search,
      FeatherIcons.settings,
    ];

    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              var colors = Colors;
              return IconButton(
                  icon: Icon(
                    items[index],
                   color: activeTab == index ? Colors.green : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      activeTab = index;
                    });
                  },);
            })),
      ),
    );
  }
}
