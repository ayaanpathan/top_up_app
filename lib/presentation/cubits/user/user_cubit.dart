import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/user.dart';
import 'package:top_up_app/data/services/mock_http_service.dart';

part 'user_state.dart';

/// Cubit for managing user-related state and operations.
class UserCubit extends Cubit<UserState> {
  /// Constructor for `UserCubit`.
  UserCubit() : super(UserInitial());

  /// Instance of the currently logged-in user.
  late User user;

  /// Initiates the login process with the provided username and password.
  Future<void> login(String username, String password) async {
    emit(UserLoading());

    final response = await MockHttpService.login(username, password);

    if (response['status'] == 'success') {
      final userData = response['user'];
      user = User(
        id: userData['id'],
        name: userData['name'],
        isVerified: userData['isVerified'],
        balance: userData['balance'],
        userName: userData['userName'],
        password: userData['password'],
      );
      emit(UserLoaded(user));
      emit(UserBalanceUpdate(user));
    } else {
      emit(UserError(response['message'] ?? 'Login failed'));
    }
  }

  /// Sets the user data to the provided user object.
  void setUserData(User userData) {
    user = userData;
    emit(UserBalanceUpdate(user));
  }
}

