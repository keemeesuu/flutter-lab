import 'dart:async';

import 'package:flutter/material.dart';

/*
동작 설명

서버 통신이 아닌 전역변수의 변경이 일어나면 StreamBuilder를 실행시킬수 있는가?
전역변수를 구독 가능한가?
*/

class StreamBuilderTest extends StatefulWidget {
  const StreamBuilderTest({super.key});

  @override
  State<StreamBuilderTest> createState() => _StreamBuilderTestState();
}

class _StreamBuilderTestState extends State<StreamBuilderTest> {
  StreamController<List> streamController = StreamController<List>();

  int _count = 0;
  List _list = [];

  @override
  void initState() {
    super.initState();
  }

  void _onListAdd(int count) {
    _list.add(count);
    streamController.add(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StreamBuilder"),
      ),
      body: StreamBuilder(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("no data"),
            );
          } else {
            List newList = snapshot.data!.toList();
            return ListView(
              children: [
                for (var item in newList)
                  ListTile(
                    title: Text(item.toString()),
                  )
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          _count++;
          _onListAdd(_count);
        },
      ),
    );
  }
}
