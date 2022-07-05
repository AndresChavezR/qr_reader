import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () async {
          final scanProvider =
              Provider.of<ScanListProvider>(context, listen: false);
          // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          //     '#3D8BEF', 'Cancelar', false, ScanMode.QR);
          String barcodeScanRes = '5.491793,  -73.485403';
          // print('Valor de la respuesa $barcodeScanRes');
          if (barcodeScanRes == '-1') return;
          launchURL(await scanProvider.nuevoScan(barcodeScanRes), context);
          // scanProvider.nuevoScan('geo:15.33,15.66');
        },
        elevation: 0,
        child: Icon(Icons.filter_center_focus));
  }
}
