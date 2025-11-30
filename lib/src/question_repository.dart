import 'package:shared_preferences/shared_preferences.dart';

class QuestionRepository {
  static const _keyLastAnswerTime = "last_answer_time";
  static const _keyQuestionIndex = "question_index";

  /// 마지막 답변 시간을 저장
  static Future<void> saveLastAnswerTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastAnswerTime, time.toIso8601String());
  }

  /// 마지막 답변 시간 가져오기
  static Future<DateTime?> getLastAnswerTime() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_keyLastAnswerTime);
    if (saved == null) return null;
    return DateTime.tryParse(saved);
  }

  /// 질문 번호 저장
  static Future<void> saveQuestionIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyQuestionIndex, index);
  }

  /// 질문 번호 가져오기
  ///
  /// ⭐ 핵심 기능:
  /// - 오늘 6시 이전이라면 ‘어제 질문’을 유지
  /// - 오늘 6시 이후라면 저장된 최신 index 사용
  static Future<int> getQuestionIndex() async {
    final prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt(_keyQuestionIndex) ?? 0;

    DateTime? lastAnswer = await getLastAnswerTime();

    if (lastAnswer == null) {
      return index;
    }

    // 오늘 아침 6시 시간 생성
    final now = DateTime.now();
    final today6AM = DateTime(now.year, now.month, now.day, 6, 0, 0);

    // 마지막 답변 날짜가 "오늘 before 6시"면 → 기존 질문 유지
    // 마지막 답변 날짜가 "어제"고 지금이 아직 6시 전이면 → 기존 질문 유지
    // 즉, 지금 시간이 오늘 6시 지나기 전이면 새로운 질문 나오면 안 된다
    if (now.isBefore(today6AM)) {
      return index - 1 < 0 ? 0 : index - 1;
    }

    return index;
  }
}
