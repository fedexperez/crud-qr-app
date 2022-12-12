import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:crudqr/providers/scan_list_provider.dart';
import 'package:crudqr/providers/ui_provider.dart';

import 'package:crudqr/screens/screens.dart';
import 'package:crudqr/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
              onPressed: () {
                scanListProvider.deleteAllScans();
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: const _HomePage(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    //Read database temporaly
    // final tempScan = ScanModel(valor: 'http://google.com');
    // DBProvider.db.newScan(tempScan);
    // DBProvider.db.getScansByTipo('http ').then((scan) => print(scan));

    //Use scanList
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapsScreen();

      case 1:
        scanListProvider.loadScansByType('http');
        return const AddressesScreen();

      default:
        return const MapsScreen();
    }
  }
}
