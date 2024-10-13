// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:audio_app/config/endpoints.dart';
import 'package:audio_app/responses/room_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoomService {
  Future<RoomResponse?> getRoom() async {
    debugPrint('get rooms called');
    String baseUrl = Endpoints.baseUrl;
    final url = Uri.parse('$baseUrl/room/get-rooms');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint(response.body.toString());
        final jsonResponse = json.decode(response.body);
        return RoomResponse.fromJson(jsonResponse);
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
