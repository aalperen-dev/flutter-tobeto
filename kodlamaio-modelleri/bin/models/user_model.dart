import '../contants/enums.dart';

class UserModel {
  final int userId;
  final String userName;
  final String name;
  final String surname;
  final String email;
  final String password;
  final UserRoles role = UserRoles.Student;
  final DateTime registeredAt = DateTime.now();
  final List<int> enrolledCoursesIds = [];

  UserModel({
    required this.userId,
    required this.userName,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  int enrolledCourseAmount(params) {
    return enrolledCoursesIds.length;
  }
}
