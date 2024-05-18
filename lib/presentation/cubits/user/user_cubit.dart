import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_up_app/domain/entities/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  late User user;

  void setUserData(User userData) {
    user = userData;
    emit(UserLoaded(user));
  }
}
