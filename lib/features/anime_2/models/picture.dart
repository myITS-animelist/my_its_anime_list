import 'package:flutter/foundation.dart' show immutable;

@immutable
class Picture {
  final String large;
  final String medium;

  const Picture({
    required this.large,
    required this.medium,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'large': large,
      'medium': medium,
    };
  }
}
