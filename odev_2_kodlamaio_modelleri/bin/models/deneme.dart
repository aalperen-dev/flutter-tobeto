import 'dart:convert';

import 'package:collection/collection.dart';

class Deneme {
  final int abc;
  final List<String> cde;
  Deneme({
    required this.abc,
    required this.cde,
  });

  Deneme copyWith({
    int? abc,
    List<String>? cde,
  }) {
    return Deneme(
      abc: abc ?? this.abc,
      cde: cde ?? this.cde,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'abc': abc,
      'cde': cde,
    };
  }

  factory Deneme.fromMap(Map<String, dynamic> map) {
    return Deneme(
      abc: map['abc']?.toInt() ?? 0,
      cde: List<String>.from(map['cde']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Deneme.fromJson(String source) => Deneme.fromMap(json.decode(source));

  @override
  String toString() => 'Deneme(abc: $abc, cde: $cde)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Deneme && other.abc == abc && listEquals(other.cde, cde);
  }

  @override
  int get hashCode => abc.hashCode ^ cde.hashCode;
}
