// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:audio_app/config/endpoints.dart';
import 'package:audio_app/responses/user_creation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserProfileResponse?> createProfile(
    String userName,
  ) async {
    debugPrint('create profile called');
    String baseUrl = Endpoints.baseUrl;
    final url = Uri.parse('$baseUrl/user/create-profile');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final Map<String, dynamic> payload = {
      'userName': userName,
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint(response.body.toString());
        final jsonResponse = json.decode(response.body);
        return UserProfileResponse.fromJson(jsonResponse);
      } else {
        debugPrint('Error with fetching profiles');
        debugPrint('HTTP Error Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      debugPrint('Error: $error');
      return null;
    }
  }
}
