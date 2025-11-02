// lib/data/network/network_api_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quicknsol_assignment/data/network/base_api_servces.dart';

class NetworkApiService implements BaseApiServices {
  final _client = http.Client();

  // -----------------------------------------------------------------
  // Public helper – used by UsersController
  // -----------------------------------------------------------------
  Future<bool> isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // -----------------------------------------------------------------
  // GET
  // -----------------------------------------------------------------
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    final response = await _client.get(Uri.parse(url));
    return _handleResponse(response);
  }

  // -----------------------------------------------------------------
  // POST (you already have the method in the abstract class)
  // -----------------------------------------------------------------
  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    final response = await _client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  // -----------------------------------------------------------------
  // PUT (update)
  // -----------------------------------------------------------------
  @override
  Future<dynamic> getUpdateApiResponse(String url, dynamic data) async {
    final response = await _client.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  // -----------------------------------------------------------------
  // DELETE
  // -----------------------------------------------------------------
  @override
  Future<dynamic> getDeleteApiResponse(String url, dynamic data) async {
    final response = await _client.delete(Uri.parse(url));
    return _handleResponse(response);
  }

  // -----------------------------------------------------------------
  // Centralised response handling
  // -----------------------------------------------------------------
  dynamic _handleResponse(http.Response resp) {
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      // DELETE returns true, empty body → return true
      // GET/POST/PUT return JSON
      return resp.body.isEmpty ? true : jsonDecode(resp.body);
    } else {
      throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
    }
  }
}
