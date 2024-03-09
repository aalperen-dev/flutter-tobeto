class LessonModel {
  final int lessonId;
  final int courseId;
  final String lessonTitle;
  final String lessonDescription;
  final String videoUrl;
  final DateTime startDate;
  final DateTime endDate;

  LessonModel({
    required this.lessonId,
    required this.courseId,
    required this.lessonTitle,
    required this.lessonDescription,
    required this.videoUrl,
    required this.startDate,
    required this.endDate,
  });
}
