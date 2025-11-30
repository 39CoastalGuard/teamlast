import 'package:shared_preferences/shared_preferences.dart';

class QuestionManager {
  static List<String> questions = [
    "1. 오늘 가장 기분 좋았던 순간은 뭐였어?",
    "2. 오늘 조금 힘들었던 일은 있었어?",
    "3. 요즘 네가 가장 편안함을 느끼는 때는 언제야?",
    "4. 오늘 누군가에게 도움을 받았거나, 누군가를 도와준 적 있어?",
    "5. 오늘 웃음 나게 만든 일이 뭐였어?",
    "6. 너를 요즘 가장 설레게 하는 게 뭐야?",
    "7. 오늘 네가 스스로 잘했다고 생각한 일은 뭐야?",
    "8. 오늘 고마웠던 사람이나 순간 있어?",
    "9. 오늘 새롭게 배운 것이 있다면 뭐야?",
    "10. 지금 기분을 색깔로 표현한다면 무슨 색일까?",
    "11. 친구에게 바라는 점 한 가지가 있다면 뭐야?",
    "12. 누군가가 너를 어떻게 기억해줬으면 좋겠어?",
    "13. 요즘 더 잘하고 싶다고 느끼는 게 있어?",
    "14. 네가 중요하게 생각하는 가치는 뭐라고 느껴?",
    "15. 최근에 ‘아, 이렇게 생각할 수도 있구나’ 하고 느낀 일이 있어?",
    "16. 하루 동안 초능력이 생긴다면 어떤 능력을 갖고 싶어?",
    "17. 시간 여행을 할 수 있다면 어디로 가보고 싶어?",
    "18. 동물이랑 대화를 할 수 있다면 무슨 동물에게 무엇을 물어볼까?",
    "19. 새로운 과목을 만든다면 어떤 수업을 만들고 싶어?",
    "20. 너만의 작은 나라를 만든다면 어떤 규칙을 만들고 싶어?",
    "21. 앞으로 해보고 싶은 일 한 가지가 있다면 뭐야?",
    "22. 1년 뒤에 네가 어떤 모습이면 좋겠어?",
    "23. 너에게 ‘성공’은 어떤 느낌일까?",
    "24. 앞으로 꼭 이루고 싶은 작은 목표가 있어?",
    "25. 어른이 되면 해보고 싶은 게 뭐야?",
    "26. 우리 가족이 함께 더 자주 했으면 하는 활동이 있어?",
    "27. 가족에게 하고 싶지만 잘 못 했던 말이 있어?",
    "28. 우리 가족이 가진 좋은 점은 뭐라고 생각해?",
    "29. 오늘 나에게 혹은 우리가 서로에게 해주고 싶은 말이 있다면?",
    "30. 지금까지 먹어봤던 음식 중에 가장 좋아하는 음식은 뭐야?",
  ];

  /// 현재 질문 번호 가져오기
  static Future<int> getCurrentQuestionIndex() async {
    final prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt("currentQuestionIndex") ?? 0;

    DateTime? lastAnswer = _getLastAnswerTime(prefs);

    if (lastAnswer == null) {
      return index;
    }

    // 내일 6시
    DateTime nextAvailable = DateTime(
      lastAnswer.year,
      lastAnswer.month,
      lastAnswer.day + 1,
      6,
      0,
      0,
    );

    DateTime now = DateTime.now();

    if (now.isBefore(nextAvailable)) {
      return index;
    } else {
      int nextIndex = (index + 1).clamp(0, questions.length - 1);
      prefs.setInt("currentQuestionIndex", nextIndex);
      return nextIndex;
    }
  }

  /// 답변 완료 시 호출
  static Future<void> markAnswered() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    prefs.setString("lastAnswerTime", now.toIso8601String());
  }

  static DateTime? _getLastAnswerTime(SharedPreferences prefs) {
    String? saved = prefs.getString("lastAnswerTime");
    if (saved == null) return null;
    return DateTime.tryParse(saved);
  }
}
