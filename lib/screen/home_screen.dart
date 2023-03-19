import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textStyle = TextStyle(
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder( // *** 캐싱이 강점 중 하나다 ***
          future: getNumber(),
          builder: (context, snapshot) {
            // 이전값이 캐싱되기 때문에 아예 초기 실행할때만 로딩바 노출
            // if (!snapshot.hasData) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            if(snapshot.hasData) {
              // 데이터가 있을때 위잿 렌더링 로직
            }

            if (snapshot.hasError) {
              // 에러가 났을때 위젯 렌더링 로직
            }

            // 로딩중일때 위젯 렌더링 로직


            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'FutureBuilder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                /**
                 *  - ConnectionState.none : FutureBuilder에 builder만 넣어준 경우 (=> future 없는 경우)
                 *  - ConnectionState 상태가 바뀔때 마다 builder가 새로 불림 (setState안해도!)
                 */
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
                    setState(() {}); // snapshot.data의 기존 데이터가 소실되지 않음
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

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));
    final random = Random();
    // throw Exception('에러가 발생했습니다'); // 에러가 나와도 ConnectionState.done으로 나옴
    return random.nextInt(100);
  }
}
