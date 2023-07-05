import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:v2ray/v2ray.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _v2rayPlugin = V2ray();

  var vmessTest =
      "vmess://eyJ2IjogIjIiLCAicHMiOiAidm1lc3MgLSAyMzA1MDgyMjAyIiwgImFkZCI6ICI0NS43Ny4xNDMuMTk5IiwgInBvcnQiOiA1MDI3LCAiaWQiOiAiZjU4ZjM5ODEtNmFkYy00NWQ3LWNhMTItOTRhMWQzZGNiZWM2IiwgImFpZCI6IDAsICJuZXQiOiAidGNwIiwgInR5cGUiOiAiaHR0cCIsICJob3N0IjogInNuYXBwLmlyIiwgInBhdGgiOiAiLyIsICJ0bHMiOiAibm9uZSJ9";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _v2rayPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                onPressed: () {

              },
              child: const Text("connect me"))
            ],
          )),
    );
  }
}
