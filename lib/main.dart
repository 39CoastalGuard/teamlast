// main.dart
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'src/setting_menu.dart/setting_function.dart'; // SettingsPage 임포트

void main() => runApp(const LilacApp());

class LilacApp extends StatelessWidget {
  const LilacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '라일락',
      initialRoute: '/home', // 로그인 팀원이 처리하므로 바로 홈으로 시작
      routes: {
        '/home': (ctx) => const HomePage(),
        '/calendar': (ctx) => const PlaceholderPage(title: '달력'),
        '/settings': (ctx) => const SettingsPage(), // 실제 설정 페이지 연결
        '/compose': (ctx) => const PlaceholderPage(title: '질문 작성'),
      },
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title 화면 - 구현 예정')),
    );
  }
}