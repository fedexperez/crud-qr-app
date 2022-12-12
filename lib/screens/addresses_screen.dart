import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crudqr/widgets/widgets.dart';
import 'package:crudqr/providers/scan_list_provider.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scanList = scanListProvider.scans;

    return ListView.builder(
      itemCount: scanList.length,
      itemBuilder: (_, i) {
        return ScanTiles(
          scanListProvider: scanListProvider,
          scanList: scanList,
          index: i,
          listType: 'http',
        );
      },
    );
  }
}
