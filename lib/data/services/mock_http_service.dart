import 'dart:async';

import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/mock/mock_data.dart';

class MockHttpService {
  ///Login Service
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

  ///Add Beneficiary
  Future<bool> addBeneficiary(Beneficiary beneficiary) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // Check if the beneficiary already exists
    final exists = MockData.beneficiaries.any(
      (b) => b.phoneNumber == beneficiary.phoneNumber,
    );

    if (exists) {
      return false;
    }

    MockData.beneficiaries.add(beneficiary);
    return true;
  }
}
