
import 'package:flutter/material.dart';
import 'package:zoncan/core/common/common.dart' show LanguageChanger;



class ZoncanAppBars {
  final AppBar? appBar;
  final SliverAppBar? sliverAppBar;

  ZoncanAppBars.main()
      : appBar = AppBar(
          toolbarHeight: 30,
          title: Row(
            children: [
              LanguageChanger(),
              const Icon(Icons.more_vert),
              Expanded(child: Container()),
              IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.deepPurpleAccent,
                  ),
                  onPressed: () {}),
              Stack(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.deepPurpleAccent.withOpacity(.7),
                      ),
                      onPressed: () {}),
                  Positioned(
                    top: 7,
                    right: 7,
                    child: Container(
                      width: 12,
                      height: 12,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.lightBlueAccent, width: 2)),
                    ),
                  )
                ],
              ),
              Container(
                width: 1,
                height: 22,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                width: 24,
              ),
              const Text(
                "Hadi Rafiei",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(2),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.deepPurpleAccent.withOpacity(.7),
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.deepPurpleAccent.withOpacity(.7),
                ),
                onPressed: () {}),
          ],
          iconTheme: const IconThemeData(color: Colors.blueGrey),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        sliverAppBar = null;
}
