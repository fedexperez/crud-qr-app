import 'package:crudqr/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:crudqr/providers/scan_list_provider.dart';

import 'package:crudqr/models/scan_model.dart';
import 'package:crudqr/themes/themes.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles(
      {Key? key,
      required this.scanListProvider,
      required this.scanList,
      required this.index,
      this.listType})
      : super(key: key);

  final ScanListProvider scanListProvider;
  final List<ScanModel> scanList;
  final int index;
  final String? listType;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                'Delete',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.delete_rounded, color: Colors.white),
              SizedBox(width: 10),
            ],
          )),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        scanListProvider.deleteScanById(scanList[index].id!);
      },
      child: ListTile(
        leading: Icon(
          listType == 'http' ? Icons.house : Icons.map,
          color: AppTheme.primary,
        ),
        title: Text(scanList[index].valor),
        subtitle: Text('ID: ${scanList[index].id}'),
        trailing: const Icon(
          Icons.arrow_right,
          color: Colors.grey,
        ),
        onTap: () {
          launchUrlUtil(context, scanList[index]);
        },
      ),
    );
  }
}
