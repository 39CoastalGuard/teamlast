//login_page.dart
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  LoginPage({super.key});

  void _tryLogin(BuildContext context) {
    if (idController.text == "admin" && pwController.text == "1234") {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ID 또는 PW가 틀렸습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("라일락", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),

              TextField(
                controller: idController,
                decoration: InputDecoration(labelText: "ID"),
              ),
              TextField(
                controller: pwController,
                decoration: InputDecoration(labelText: "PW"),
                obscureText: true,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => _tryLogin(context),
                child: Text("로그인"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//더미데이터, 2025.11.21 기준 사용안하는 모듈