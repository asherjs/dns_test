import 'package:equatable/equatable.dart';

class Candidate extends Equatable {
  String firstName;
  String lastName;
  String phone;
  String email;
  String github;
  String summary;
  String token;

  Candidate({this.firstName, this.lastName, this.phone, this.email, this.github, this.summary, this.token});

  @override
  List<Object> get props => [token];
}