part of 'candidate_bloc.dart';

@immutable
abstract class CandidateState extends Equatable {
  const CandidateState();

  @override
  List<Object> get props => [];
}

class CandidateInitial extends CandidateState {}

class CandidateTokenRecieved extends CandidateState {
  final Candidate candidate;

  CandidateTokenRecieved({@required this.candidate}) : assert(candidate != null);

  @override
  List<Object> get props => [candidate];
}

class CandidateTokenRecieveFailure extends CandidateState {}

class CandidateRegistering extends CandidateState {}

class CandidateRegistered extends CandidateState {
  final Candidate candidate;

  CandidateRegistered({@required this.candidate}) : assert(candidate != null);

  @override
  List<Object> get props => [candidate];
}
