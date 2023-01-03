import 'package:task/feature/domain/model/user_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

class SignInUseCase {
  final FirebaseRepository repository;
  SignInUseCase({required this.repository});

  Future<void> execute(UserEntity user) async {
    return repository.signIn(user);
  }
}
