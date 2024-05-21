import 'gender.dart';

class Users {
  final String id;
  final String? role;
  final String? image;
  final String? about;
  final String? email;
  final String? status;
  final bool verified;
  final String? address;
  final String? contact;
  final Gender? gender;
  final Metrics metrics;
  final String? username;
  final String? fullName;
  final String? coverPhoto;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final List<String> interest;
  final List<String> followers;
  final List<String> following;

  const Users({
    required this.id,
    required this.role,
    required this.image,
    required this.email,
    required this.about,
    required this.gender,
    required this.status,
    required this.metrics,
    required this.address,
    required this.contact,
    required this.verified,
    required this.username,
    required this.interest,
    required this.fullName,
    required this.followers,
    required this.following,
    required this.coverPhoto,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String,
      role: json['role'] as String,
      image: json['image'] as String?,
      email: json['email'] as String?,
      about: json['about'] as String?,
      gender: json['gender'] as Gender?,
      status: json['status'] as String?,
      metrics: Metrics.fromJson(json['metrics']),
      address: json['address'] as String?,
      contact: json['contact'] as String?,
      verified: json['verified'] as bool,
      username: json['username'] as String?,
      interest: json['interest'] as List<String>,
      fullName: json['fullName'] as String?,
      followers: json['followers'] as List<String>,
      following: json['following'] as List<String>,
      coverPhoto: json['coverPhoto'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as DateTime?,
    );
  }
}

class Metrics {
  final int totalLikes;
  final int totalPosts;
  final int totalFollowing;
  final int totalFollowers;

  const Metrics({
    required this.totalPosts,
    required this.totalLikes,
    required this.totalFollowers,
    required this.totalFollowing,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) {
    return Metrics(
      totalPosts: json['totalPosts'] as int,
      totalLikes: json['totalLikes'] as int,
      totalFollowers: json['totalFollowers'] as int,
      totalFollowing: json['totalFollowing'] as int,
    );
  }
}
