import 'package:task/feature/domain/repositries/firebase_repo.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;
  GetCurrentUidUseCase({required this.repository});

  Future<String> execute() async {
    return repository.getCurrentUid();
  }
}
