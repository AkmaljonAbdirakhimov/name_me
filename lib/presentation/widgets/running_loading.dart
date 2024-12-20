import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RunningLoading extends StatefulWidget {
  const RunningLoading({super.key});

  @override
  State<RunningLoading> createState() => _RunningLoadingState();
}

class _RunningLoadingState extends State<RunningLoading> {
  String _loadingText = "...";
  int _dotCount = 0;
  final int _maxDots = 3;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % (_maxDots + 1);
        _loadingText = '.' * _dotCount;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${tr('loading', context: context)}$_loadingText",
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}
