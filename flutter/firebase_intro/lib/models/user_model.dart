import 'dart:convert';

class UserModel {
  final String? uid;
  final String? email;
  final String? photoUrl;
  final String? firstName;
  final String? lastName;
  UserModel({
    this.uid,
    this.email,
    this.photoUrl,
    this.firstName,
    this.lastName,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? photoUrl,
    String? firstName,
    String? lastName,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'photoUrl': photoUrl,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, photoUrl: $photoUrl, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        firstName.hashCode ^
        lastName.hashCode;
  }
}
