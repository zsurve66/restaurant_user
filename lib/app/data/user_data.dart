import 'dart:convert';

import 'package:restaurant_user/app/constants/app_enums.dart';

class UserData {
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;
  final String uid;
  final UserType userType;

  const UserData({
    required this.name,
    required this.email,
    this.photoUrl,
    this.phoneNumber,
    required this.uid,
    required this.userType,
  });

  UserData copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? phoneNumber,
    String? uid,
    UserType? userType,
  }) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    if (photoUrl != null) {
      result.addAll({'photoUrl': photoUrl});
    }
    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    result.addAll({'uid': uid});
    result.addAll({'userType': userType.name});

    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    UserType userType = UserType.user;
    switch (map['userType'].toString().toLowerCase()) {
      case 'admin':
        userType = UserType.admin;
        break;
      case 'user':
        userType = UserType.user;
        break;
      case 'waiter':
        userType = UserType.waiter;
        break;
      default:
        userType = UserType.user;
    }
    return UserData(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      phoneNumber: map['phoneNumber'],
      uid: map['uid'] ?? '',
      userType: userType,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(name: $name, email: $email, photoUrl: $photoUrl, phoneNumber: $phoneNumber, uid: $uid, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.phoneNumber == phoneNumber &&
        other.uid == uid &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        phoneNumber.hashCode ^
        uid.hashCode ^
        userType.hashCode;
  }
}
