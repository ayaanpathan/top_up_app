import 'dart:async';

import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/mock/mock_data.dart';

/// A mock HTTP service for simulating network operations such as login,
/// adding beneficiaries, and topping up beneficiaries' balances.
class MockHttpService {
  /// Simulates a login request.
  ///
  /// Returns a future that completes with a map containing the login status
  /// and user information if the credentials are correct. Otherwise, returns
  /// a map with a failure status and an error message.
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if ((username == 'user1' && password == '12345678') ||
        (username == 'user2' && password == '12345678')) {
      return {
        'status': 'success',
        'user': {
          'id': username == 'user1' ? '1' : '2',
          'name': username == 'user1' ? 'Verified User' : 'Unverified User',
          'isVerified': username == 'user1' ? true : false,
          'balance': 5000.0,
          'userName': username,
          'password': password,
        },
      };
    } else {
      return {'status': 'failure', 'message': 'Invalid credentials'};
    }
  }

  /// Simulates adding a beneficiary.
  ///
  /// Returns a future that completes with `true` if the beneficiary is added successfully.
  /// If the beneficiary already exists, returns `false`.
  Future<bool> addBeneficiary(Beneficiary beneficiary) async {
    /// Simulate network delay.
    await Future.delayed(const Duration(seconds: 2));

    /// Check if the beneficiary already exists
    final exists = MockData.beneficiaries
        .any((b) => b.phoneNumber == beneficiary.phoneNumber);

    if (exists) {
      return false;
    }

    MockData.beneficiaries.add(beneficiary);
    return true;
  }

  /// Simulates topping up a beneficiary's balance.
  ///
  /// Returns a future that completes successfully if the beneficiary ID is not empty.
  /// Throws an exception if the beneficiary ID is empty.
  Future<void> topUp(int amount, String beneficiaryId) async {
    /// Simulate network delay.
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success or failure based on the beneficiary ID
    if (beneficiaryId.isEmpty) {
      throw Exception('Failed to top up');
    }

    // Otherwise, simulate a successful top-up
    return;
  }
}
