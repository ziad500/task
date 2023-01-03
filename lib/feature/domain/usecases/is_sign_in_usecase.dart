import 'package:task/feature/domain/repositries/firebase_repo.dart';

class IsSignInUseCase {
  final FirebaseRepository repository;
  IsSignInUseCase({required this.repository});

  Future<bool> execute() async {
    return repository.isSignIn();
  }
}
