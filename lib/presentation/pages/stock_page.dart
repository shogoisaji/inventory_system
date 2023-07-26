import 'package:flutter/material.dart';

import '../wedget/line_inner.dart';

class StockPage extends StatelessWidget {
  StockPage({Key? key}) : super(key: key);

  final ScrollController _homeController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('一覧'),
      ),
      body: ListView.separated(
          controller: _homeController,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              child: ListInner(indexNumber: (index + 1)),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
                thickness: 0,
              ),
          itemCount: 50),
    );
  }
}
