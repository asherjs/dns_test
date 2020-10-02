import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:dns_test/models/models.dart';

class CandidateApiClient {
  static const baseUrl = 'https://vacancy.dns-shop.ru';
  final http.Client httpClient;

  CandidateApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<String> getToken(Candidate candidate) async {
    final candidateResponse = await this.httpClient.post(
        '$baseUrl/api/candidate/token',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "firstName": candidate.firstName,
          "lastName": candidate.lastName,
          "phone": candidate.phone,
          "email": candidate.email
        }),
        );

    print(candidateResponse);

    if (candidateResponse.statusCode != 200) {
      throw Exception('error getting token');
    }

    final responseBody = jsonDecode(candidateResponse.body);
    print('response body: $responseBody');
    return responseBody["data"];
  }

  Future<bool> register(Candidate candidate) async {
    final candidateResponse = await this.httpClient.post(
      '$baseUrl/api/candidate/test/summary',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${candidate.token}',
      },
      body: jsonEncode(<String, String>{
        "firstName": candidate.firstName,
        "lastName": candidate.lastName,
        "phone": candidate.phone,
        "email": candidate.email,
        "githubProfileUrl": candidate.github,
        "summary": candidate.summary,
      }),
    );

    print(candidateResponse);

    if (candidateResponse.statusCode != 200) {
      throw Exception('error getting token');
    } else {
      final responseBody = jsonDecode(candidateResponse.body);
      print(responseBody);
      return true;
    }
  }
}