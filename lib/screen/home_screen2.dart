import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final textStyle = TextStyle(
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<int>( // FutureBuilder도 제네릭 가능, StreamBuilder도 마지막값이 캐싱, stream 사용다하고 알아서 닫아줌
          stream: stremNumbers(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'StreamBuilder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Constate : ${snapshot.connectionState}',
                  style: textStyle,
                ),
                Text(
                  'Data : ${snapshot.data}',
                  style: textStyle,
                ),
                Text(
                  'Error : ${snapshot.error}',
                  style: textStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('setState'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
  Stream<int> stremNumbers() async* {
    for(int i = 0; i <10; i++) {
      print('첫번째 $i');
      if (i == 5) {
        throw Exception('i==5'); // yield i; 안했기 때문에 화면엔 Data:5 안 찍힌 상태에서 에러발생
      }
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }
}
