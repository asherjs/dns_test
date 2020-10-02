import 'package:dns_test/bloc/candidate_bloc.dart';
import 'package:dns_test/models/candidate.dart';
import 'package:dns_test/repositories/candidate_api_client.dart';
import 'package:dns_test/repositories/candidate_repository.dart';
import 'package:dns_test/view/getting_token.dart';
import 'package:dns_test/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  final CandidateRepository candidateRepository = CandidateRepository(
    candidate: Candidate(),
    candidateApiClient: CandidateApiClient(
      httpClient: http.Client(),
    )
  );
  runApp(App(
    candidateRepository: candidateRepository,
  ));
}

class App extends StatelessWidget {
  final CandidateRepository candidateRepository;

  const App({Key key, @required this.candidateRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: candidateRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CandidateBloc(
              candidateRepository: candidateRepository,
            ),
            child: PersonalDataInput(),
          ),
          BlocProvider(
            create: (_) => CandidateBloc(
              candidateRepository: candidateRepository,
            ),
            child: DataSending(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.orange,
            ),
            textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
              headline6: TextStyle(color: Colors.white),
            ),
          ),
          home: PersonalDataInput(),
        ),
      ),
    );
  }
}



