import 'package:flutter/material.dart';
import 'src/question_list.dart';
import 'src/today_question_dialog.dart';
import 'src/weather/weather_api.dart';
import 'src/weather/weather_function.dart'; // FuncWeather 정의 파일
import 'widgets/lilac_character.dart'; //라일락 파일


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("라일락"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
      body: Stack(
        children: [
          /// -------------------------
          /// 1) 창문(날씨 자리)
          /// -------------------------
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              width: 200,
              height: 150,
              child: Center(
                child: FutureBuilder<String>(
                  future: fetchWeather(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(strokeWidth: 2);
                    }
                    if (snap.hasError) {
                      return Text("날씨 로드 실패");
                    }

                    final data = snap.data ?? '';
                    final parts = data.split('-');
                    final sky = parts.isNotEmpty ? parts[0] : '';
                    final pty = parts.length > 1 ? parts[1] : '0';

                    // FuncWeather 호출
                    final mapped = WeatherFunction.funcWeather(sky, pty);

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        mapped['icon'] as Widget,
                        SizedBox(height: 6),
                        Text("현재 날씨 - ${mapped['description']}",
                            style: TextStyle(fontSize: 14)),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          /// -------------------------
          /// 2) 캐릭터 자리
          /// -------------------------
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LilacCharacter(
                  answeredDaysCount: 7, // 또는 answeredDaysCount 변수,7(테스트용)
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          /// -------------------------
          /// 3) 달력 버튼
          /// -------------------------
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              icon: Icon(Icons.calendar_month),
              label: Text("달력"),
            ),
          ),

          /// -------------------------
          /// 4) 말풍선 버튼 (오늘의 질문)
          /// -------------------------
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                TodayQuestionDialog.show(
                  context,
                  QuestionRepository.getRandomQuestion(),
                );
              },
              child: Icon(Icons.chat_bubble),
            ),
          ),
        ],
      ),
    );
  }
}