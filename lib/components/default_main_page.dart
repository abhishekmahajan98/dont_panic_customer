import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dont_panic_customer/models/misc.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';

class DefaultMainPage extends StatefulWidget {
  @override
  _DefaultMainPageState createState() => _DefaultMainPageState();
}

class _DefaultMainPageState extends State<DefaultMainPage> {
  AudioPlayer advancedPlayer;
  bool playAlarm = false;
  var top = 0.0;
  TabController _controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.7,
          floating: false,
          pinned: true,
          backgroundColor: Colors.indigoAccent,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              top = constraints.biggest.height;
              return FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    FlareActor(
                      "assets/flares/ResizingHouse.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      animation: "Demo Mode",
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FloatingActionButton(
                                backgroundColor: Colors.indigoAccent,
                                onPressed: () {},
                                child: Icon(
                                  Icons.call,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                title: top > 80 ? Container() : Text('DON\'T PANIC'),
                centerTitle: true,
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    playAlarm = !playAlarm;
                  });
                  if (!playAlarm) {
                    advancedPlayer.stop();
                    AudioCache().clearCache();
                  } else {
                    advancedPlayer =
                        await AudioCache().loop('audio/loud_alarm.mp3');
                  }
                },
                child: Icon(
                  playAlarm == true
                      ? FontAwesomeIcons.solidBellSlash
                      : FontAwesomeIcons.solidBell,
                ),
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 10,
                child: Marquee(
                  text: 'This is the default page',
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 20.0,
                  velocity: 75.0,
                  startPadding: 20.0,
                ),
              ),
            ],
          ),
        ),
        DefaultTabController(
          length: 2,
          child: SliverStickyHeader(
            header: Container(
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
              ),
              child: TabBar(
                indicatorColor: Colors.white,
                controller: _controller,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.format_list_bulleted),
                    text: 'RANDOM TO-DO',
                  ),
                  Tab(
                    icon: const Icon(Icons.update),
                    text: 'Updates',
                  ),
                ],
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: todo.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(
                              FontAwesomeIcons.solidCircle,
                              size: MediaQuery.of(context).size.height / 70,
                            ),
                            title: Text(todo[index].toString()),
                          );
                        },
                      ),
                      Container(),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )
      ],
    );
  }
}
