import 'package:top_up_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUser();
}
