import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? mobile;
  final String? uid;
  final String? password;

  const UserEntity(
      {this.email, this.mobile, this.name, this.uid, this.password});

  @override
  List<Object?> get props => [name, email, mobile, uid, password];
}
