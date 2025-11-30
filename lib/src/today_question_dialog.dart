// lib/src/today_question_dialog.dart
import 'package:flutter/material.dart';
import 'question_list.dart';  // 질문 + SharedPreferences 로직 사용

class TodayQuestionDialog {
  static void show(BuildContext context) async {
    // 1) 현재 질문 번호 불러오기
    int index = await QuestionManager.getCurrentQuestionIndex();
    String question = QuestionManager.questions[index];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        TextEditingController answerController = TextEditingController();

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            constraints: BoxConstraints(maxHeight: 360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 제목
                Text(
                  "오늘의 질문",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),

                SizedBox(height: 12),

                // 질문 번호 + 질문 내용
                Text(
                  question,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),

                SizedBox(height: 20),

                // 답변 입력
                TextField(
                  controller: answerController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "답변을 입력하세요...",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                // 제출 버튼
                ElevatedButton(
                  onPressed: () async {
                    // 답변 저장 로직 (여기서는 답변 자체는 안 저장해도 됨)
                    await QuestionManager.markAnswered(); // ✔ 답변한 시간을 저장

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "답변이 저장되었습니다.\n다음 질문은 내일 아침 6시에 열립니다!",
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3E5F5),
                  ),
                  child: Text("답변 제출"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
