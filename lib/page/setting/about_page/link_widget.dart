// Copyright 2024 BenderBlog Rodriguez and contributors.
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link {
  final String name;
  final IconData icon;
  final String url;

  Link({
    required this.name,
    required this.icon,
    required this.url,
  });
}

class LinkWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final String url;
  const LinkWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(name),
      onTap: () => launchUrl(
        Uri.parse("https://legacy.superbart.xyz/xdyou.html"),
        mode: LaunchMode.externalApplication,
      ),
    );
  }
}
