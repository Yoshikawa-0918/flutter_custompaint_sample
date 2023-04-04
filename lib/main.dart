import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter CustomPaint Sample'),
        ),
        body: _body(),
      ),
    );
  }
}

//①Canvas(図形を描画する場所)を用意する
class _body extends StatelessWidget {
  const _body();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /*
    sizeプロパティでCanvasのサイズを定義する
    painterプロパティでPainterとなるクラスを定義する
    */
    return CustomPaint(
      size: Size(size.width, size.height),
      painter: _Painter(),
    );
  }
}

//②Painter(描画する処理)を用意する
class _Painter extends CustomPainter {
  //paintメソッドに付けを描画する処理を書く
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color
      ..style
      ..strokeWidth;
    //三角形のパス
    final path = Path()
      ..moveTo(
        20,
        size.height / 3 * 2 - 20,
      )
      ..lineTo(
        size.width / 2 - 20,
        size.height / 3 * 2 - 20,
      )
      ..lineTo(
        size.width / 4,
        size.height / 3 + 20,
      )
      ..lineTo(
        20,
        size.height / 3 * 2 - 20,
      );
    paint.color = Colors.black;
    //横線の描画
    for (int i = 0; i < 2; i++) {
      canvas.drawLine(Offset(0, size.height / 3 * (i + 1)),
          Offset(size.width, size.height / 3 * (i + 1)), paint);
    }
    //縦線の描画
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);

    paint.color = Colors.blue;
    //四角形の描画
    canvas.drawRect(
        Rect.fromLTRB(20, 20, size.width / 2 - 20, size.height / 3 - 20),
        paint);

    paint.color = Colors.red;
    //円の描画
    canvas.drawCircle(Offset(size.width / 4 * 3, size.height / 6),
        size.width / 4 - 20, paint);

    paint.color = Colors.yellow;
    //三角形の描画(パスを用いて図形を描画)
    canvas.drawPath(path, paint);

    paint.color = Colors.brown;
    //塗りつぶしなし
    paint.style = PaintingStyle.stroke;
    //枠線の太さを指定
    paint.strokeWidth = 12;
    canvas.drawCircle(Offset(size.width / 4 * 3, size.height / 2),
        size.width / 4 - 20, paint);
  }

  //shouldRepaintメソッドはCustomPainterが再結成された時に呼び出す(前のペイント結果を再利用する時に使う)
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
