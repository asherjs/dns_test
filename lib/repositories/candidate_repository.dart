import 'dart:async';

import 'package:meta/meta.dart';

import 'package:dns_test/repositories/candidate_api_client.dart';
import 'package:dns_test/models/models.dart';

class CandidateRepository {
  Candidate candidate;
  final CandidateApiClient candidateApiClient;

  CandidateRepository({@required this.candidate, @required this.candidateApiClient})
      : assert(candidateApiClient != null);

  Future<String> getToken(Candidate candidate) async {
    return candidateApiClient.getToken(candidate);
  }

  Future<bool> register(Candidate candidate) async {
    return candidateApiClient.register(candidate);
  }
}