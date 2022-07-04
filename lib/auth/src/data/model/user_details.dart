import 'package:objectbox/objectbox.dart';

@Entity()
class UserDetails {
  int id;
  final String? nickName;
  final String userName;
  final String? encryptedPassword;
  UserDetails({
    this.id=0,
    this.nickName,
    required this.userName,
    this.encryptedPassword,
  });

  UserDetails copyWith({
    int? id,
    String? nickName,
    String? userName,
    String? encryptedPassword,
  }) {
    return UserDetails(
      id: id ?? this.id,
      nickName: nickName ?? this.nickName,
      userName: userName ?? this.userName,
      encryptedPassword: encryptedPassword ?? this.encryptedPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickName': nickName,
      'userName': userName,
      'encryptedPassword': encryptedPassword,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id']?.toInt(),
      nickName: map['nickName'],
      userName: map['userName'] ?? '',
      encryptedPassword: map['encryptedPassword'],
    );
  }

  @override
  String toString() {
    return 'UserDetails(id: $id, nickName: $nickName, userName: $userName, encryptedPassword: $encryptedPassword)';
  }
}
