// lib/src/balloon/question_popup.dart
import 'package:flutter/material.dart';
import 'question_repository.dart';
import '../question_list.dart';

class QuestionPopup {
  static Future<void> show(BuildContext context) async {
    // 현재 질문 번호 가져오기
    int index = await QuestionRepository.getQuestionIndex();

    // 질문 리스트에서 해당 질문 꺼내기
    final question = questionList[index];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "오늘의 질문",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  question,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () async {
                    // 1) 마지막 답변 시간 저장
                    await QuestionRepository.saveLastAnswerTime(DateTime.now());

                    // 2) 질문 index +1 (다음 질문)
                    await QuestionRepository.saveQuestionIndex(index + 1);

                    Navigator.pop(context);
                  },
                  child: const Text("확인"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
