// Copyright 2023 BenderBlog Rodriguez and contributors.
// SPDX-License-Identifier: MPL-2.0 OR Apache-2.0

import 'package:flutter/material.dart';
import 'package:watermeter/page/classtable/classtable_state.dart';
import 'package:watermeter/page/classtable/class_page/classtable_page.dart';

/// Intro of the classtable.

class ClassTableWindow extends StatelessWidget {
  final int currentWeek;
  const ClassTableWindow({
    super.key,
    required this.currentWeek,
  });

  @override
  Widget build(BuildContext context) {
    return ClassTableState(
      parentContext: context,
      controllers: ClassTableWidgetState(currentWeek: currentWeek),
      child: Navigator(
        onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
          builder: (context) => const ClassTablePage(),
        ),
      ),
    );
  }
}
