import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/feature/domain/model/user_model.dart';

class UserModel extends UserEntity {
  const UserModel(
      {final String? name,
      final String? email,
      final String? mobile,
      final String? uid,
      final String? password})
      : super(
            uid: uid,
            name: name,
            email: email,
            mobile: mobile,
            password: password);
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      name: documentSnapshot.get('name'),
      uid: documentSnapshot.get('uid'),
      email: documentSnapshot.get('email'),
      mobile: documentSnapshot.get('mobile'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {"name": name, "uid": uid, "email": email, "mobile": mobile};
  }
}
