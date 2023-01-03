import 'package:task/feature/domain/model/user_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

class SignUpUseCase {
  final FirebaseRepository repository;
  SignUpUseCase({required this.repository});

  Future<void> execute(UserEntity user) async {
    return repository.signUp(user);
  }
}
