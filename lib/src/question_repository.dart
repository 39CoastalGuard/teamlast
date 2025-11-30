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
  static Future<int> getQuestionIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyQuestionIndex) ?? 0;
  }
}
