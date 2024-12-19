import 'package:flutter/material.dart';
import 'tree_page.dart'; // home_page.dart 파일 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Growing Tree', // 앱 제목
      home: TreePage(), // HomePage를 시작 화면으로 설정
      debugShowCheckedModeBanner: false, // 디버그 배너 숨김
    );
  }
}
