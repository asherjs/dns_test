part of 'candidate_bloc.dart';

abstract class CandidateEvent extends Equatable {
  const CandidateEvent();
}

class CandidateTokenRequested extends CandidateEvent {
  final Candidate candidate;

  const CandidateTokenRequested({
    @required this.candidate}) :
        assert(candidate != null);

  @override
  List<Object> get props => [candidate];
}

class CandidateDataSent extends CandidateEvent {
  final Candidate candidate;

  const CandidateDataSent({
    @required this.candidate}) :
        assert(candidate != null);

  @override
  List<Object> get props => [candidate];
}


