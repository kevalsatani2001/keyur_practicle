class LoginResponse {
  final int status;
  final String message;
  final UserData? data;

  LoginResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String countryCode;
  final String mobile;
  final String email;
  final String profileImage;
  final String token;
  final String notification;
  final String isLike;
  final String isComment;
  final String isDownload;
  final String isUpload;
  final bool isPendingUpdate;
  final List<Album> albums;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.mobile,
    required this.email,
    required this.profileImage,
    required this.token,
    required this.notification,
    required this.isLike,
    required this.isComment,
    required this.isDownload,
    required this.isUpload,
    required this.isPendingUpdate,
    required this.albums,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      countryCode: json['country_code'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_image'] ?? '',
      token: json['token'] ?? '',
      notification: json['notification'] ?? '',
      isLike: json['is_like'] ?? '',
      isComment: json['is_comment'] ?? '',
      isDownload: json['is_download'] ?? '',
      isUpload: json['is_upload'] ?? '',
      isPendingUpdate: json['is_pending_update'] ?? false,
      albums: (json['albums'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'country_code': countryCode,
      'mobile': mobile,
      'email': email,
      'profile_image': profileImage,
      'token': token,
      'notification': notification,
      'is_like': isLike,
      'is_comment': isComment,
      'is_download': isDownload,
      'is_upload': isUpload,
      'is_pending_update': isPendingUpdate,
      'albums': albums.map((e) => e.toJson()).toList(),
    };
  }
}

class Album {
  final int id;
  final String name;
  final String profileImage;
  final String userRole;
  final bool isHighlight;
  final bool isAlbumHavePhoto;
  final List<Child> children;
  final List<Member> members;

  Album({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.userRole,
    required this.isHighlight,
    required this.isAlbumHavePhoto,
    required this.children,
    required this.members,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      userRole: json['user_role'] ?? '',
      isHighlight: json['is_highlight'] == "1" || json['is_highlight'] == true,
      isAlbumHavePhoto: json['is_album_have_photo'] ?? false,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Child.fromJson(e))
          .toList() ??
          [],
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_image': profileImage,
      'user_role': userRole,
      'is_highlight': isHighlight ? "1" : "0",
      'is_album_have_photo': isAlbumHavePhoto,
      'children': children.map((e) => e.toJson()).toList(),
      'members': members.map((e) => e.toJson()).toList(),
    };
  }
}

class Child {
  final int id;
  final String name;
  final String gender;
  final String birthDate;

  Child({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      birthDate: json['birth_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'birth_date': birthDate,
    };
  }
}

class Member {
  final int id;
  final String name;
  final String? email;
  final String relation;
  final String role;
  final String profileImage;
  final String isLike;
  final String isComment;
  final String isDownload;
  final String isUpload;

  Member({
    required this.id,
    required this.name,
    this.email,
    required this.relation,
    required this.role,
    required this.profileImage,
    required this.isLike,
    required this.isComment,
    required this.isDownload,
    required this.isUpload,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      relation: json['relation'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profile_image'] ?? '',
      isLike: json['is_like'] ?? '',
      isComment: json['is_comment'] ?? '',
      isDownload: json['is_download'] ?? '',
      isUpload: json['is_upload'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'relation': relation,
      'role': role,
      'profile_image': profileImage,
      'is_like': isLike,
      'is_comment': isComment,
      'is_download': isDownload,
      'is_upload': isUpload,
    };
  }
}
