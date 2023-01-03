import 'package:task/feature/domain/model/user_model.dart';
import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;
  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> execute(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}
