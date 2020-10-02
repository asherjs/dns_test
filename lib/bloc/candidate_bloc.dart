import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dns_test/models/models.dart';
import 'package:dns_test/repositories/candidate_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'candidate_event.dart';
part 'candidate_state.dart';

class CandidateBloc extends Bloc<CandidateEvent, CandidateState> {
  final CandidateRepository candidateRepository;

  CandidateBloc({@required this.candidateRepository})
      : assert(candidateRepository != null),
        super(CandidateInitial());

  @override
  Stream<CandidateState> mapEventToState(CandidateEvent event) async* {
    if (event is CandidateTokenRequested) {
      yield* _mapCandidateTokenRequestedToState(event);
    } else if (event is CandidateDataSent) {
      yield* _mapCandidateDataSentToState(event);
    }
  }

  Stream<CandidateState> _mapCandidateTokenRequestedToState(CandidateTokenRequested event) async* {
    try {
      final String token = await candidateRepository.getToken(event.candidate);
      candidateRepository.candidate.token = token;
      yield CandidateTokenRecieved(candidate: candidateRepository.candidate);
    } catch (_) {
      yield CandidateTokenRecieveFailure();
    }
  }

  Stream<CandidateState> _mapCandidateDataSentToState(CandidateDataSent event) async* {
    yield CandidateRegistering();
    try {
      final bool isRegistered = await candidateRepository.register(event.candidate);
      yield CandidateRegistered(candidate: event.candidate);
    } catch (_) {
      yield CandidateTokenRecieveFailure();
    }
  }
}
