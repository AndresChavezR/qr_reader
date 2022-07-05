import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import '../widgets/custom_navigator_bar.dart';
import '../widgets/scan_button.dart';
import 'mapas_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () {
                final scanProvider =
                    Provider.of<ScanListProvider>(context, listen: false);
                    scanProvider.borrarTodos(scanProvider.tipoSeleccionado);
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: _HomePageBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectMenuOpt;

    final scanProvider = Provider.of<ScanListProvider>(context, listen: false);
    switch (currentIndex) {
      case 0:
        scanProvider.cargarScansPorTipo('geo');
        return const MapasPage();
      case 1:
        scanProvider.cargarScansPorTipo('http');
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
