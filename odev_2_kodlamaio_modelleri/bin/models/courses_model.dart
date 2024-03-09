import '../contants/enums.dart';
import 'lessons_model.dart';

class CoursesModel {
  final int courseId;
  final int instructorId;
  final String courseTitle;
  final String courseDescription;
  final CourseCategories courseType;
  final List<int> enrolledUserIds = [];
  final int courseRating = 0;
  final List<LessonModel> lesson;
  final DateTime startDate;
  final DateTime endDate;

  CoursesModel({
    required this.courseId,
    required this.instructorId,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseType,
    required this.lesson,
    required this.startDate,
    required this.endDate,
  });

  int enrolledUserAmount(params) {
    return this.enrolledUserIds.length;
  }
}
