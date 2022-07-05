import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';
import '../utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo; 
  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanListProvider>(context);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: scanProvider.scans.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(color: Colors.red,child: const Icon(Icons.delete),),
            key: Key(scanProvider.scans[index].id.toString()),
            onDismissed: (direction) {
              scanProvider.borrarById(scanProvider.scans[index].id!);
            },
            child: ListTile(
              title: Text(scanProvider.scans[index].valor),
              leading: Icon(
                 (tipo=='geo')? Icons.map: Icons.border_horizontal_outlined,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => launchURL(scanProvider.scans[index], context),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            
          );
        });
  }
}
