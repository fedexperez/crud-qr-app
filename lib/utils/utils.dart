import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:crudqr/models/scan_model.dart';

Future<void> launchUrlUtil(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    final url = Uri.parse(scan.valor);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
