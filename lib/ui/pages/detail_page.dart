import 'package:batikku/model/batik_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.result});
  final int result;

  final List<BatikDetailModel> mappingDesc = [
    BatikDetailModel(0, "Asimetris", "penjelasan Asimetris", []),
    BatikDetailModel(1, "Asmat", "penjelasan Asmat", []),
    BatikDetailModel(2, "Burung", "penjelasan Burung", []),
    BatikDetailModel(3, "Kamoro", "penjelasan Kamoro", []),
    BatikDetailModel(4, "Prada", "penjelasan Prada", []),
    BatikDetailModel(5, "Sentani", "penjelasan Sentani", []),
    BatikDetailModel(6, "Tifa Honai", "penjelasan Tifa Honai", []),
  ];

  @override
  Widget build(BuildContext context) {
    final selected = mappingDesc.firstWhere((element) => element.id == result);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text(selected.name),
            Text(selected.desc),
          ],
        ),
      ),
    );
  }
}
