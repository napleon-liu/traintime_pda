// Copyright 2023 BenderBlog Rodriguez.
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';
import 'package:flutter/widgets.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (Platform.isIOS || Platform.isMacOS)
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(29),
            ),
            child: Image.asset(
              "assets/Icon-App-iTunes.png",
              width: 120,
              height: 120,
            ),
          )
        else
          Image.asset(
            "assets/icon.png",
            width: 120,
            height: 120,
          ),
        const SizedBox(height: 16.0),
        Text(
            '请登录 ${Platform.isIOS || Platform.isMacOS ? "XDYou" : "Traintime PDA"}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            )),
      ],
    );
  }
}