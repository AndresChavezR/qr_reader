import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(ScanModel scan, BuildContext context) async {
  final url = scan.valor;
  if (scan.tipo == 'http') {
    if (!await launchUrl(Uri.parse(url)))
      throw 'Could not launch ${scan.valor}';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
