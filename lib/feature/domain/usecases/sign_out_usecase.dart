import 'package:task/feature/domain/repositries/firebase_repo.dart';

class SignOutUseCase {
  final FirebaseRepository repository;
  SignOutUseCase({required this.repository});

  Future<void> execute() async {
    return repository.signOut();
  }
}
