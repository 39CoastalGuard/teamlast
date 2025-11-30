import 'package:flutter/material.dart';
import 'question_repository.dart';
import 'question_list.dart';

class TodayQuestionDialog {
  static void show(BuildContext context) async {
    // 현재 질문 index 불러오기 (6시 전이면 이전 질문 유지)
    int index = await QuestionRepository.getQuestionIndex();

    // 질문 불러오기
    final question = questionList[index];

    TextEditingController answerController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxHeight: 350),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "오늘의 질문",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),

                const SizedBox(height: 20),

                // 질문 표시
                Text(
                  question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 30),

                // 답변 입력창
                TextField(
                  controller: answerController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "답변을 입력하세요...",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    // (1) 답변 저장
                    // 실제 서버나 DB가 없으므로 당장은 생략
                    // 단, 필요하면 여기서 파일/서버 저장도 가능

                    // (2) 마지막 답변 시간 저장
                    await QuestionRepository.saveLastAnswerTime(DateTime.now());

                    // (3) 다음 질문 index 저장
                    await QuestionRepository.saveQuestionIndex(index + 1);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3E5F5),
                  ),
                  child: const Text("답변 제출"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
