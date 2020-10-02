import 'package:dns_test/bloc/candidate_bloc.dart';
import 'package:dns_test/models/candidate.dart';
import 'package:dns_test/repositories/candidate_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataSending extends StatefulWidget {
  @override
  State<DataSending> createState() => _DataSendingState();
}

class _DataSendingState extends State<DataSending> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Отправка данных', style: Theme.of(context).textTheme.headline6,),
      ),
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        children: [
          TextFormField(
            controller: _githubController,
            validator: (value) {
              bool isValid = RegExp(r"[http(s)?)(:(\/\/)?)(github\.com\/.+]").hasMatch(value);
              if (!isValid) {
                return 'Пожалуйста введите корректный адрес';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'ссылка на github',
            ),
          ),
          TextFormField(
            controller: _summaryController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Пожалуйста, введите ссылку на ваше резюме';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'ссылка на резюме',
            ),
          ),
          Container( margin: const EdgeInsets.only(top: 15.0),
            child: RaisedButton(
              child: Text('ЗАРЕГИСТРИРОВАТЬСЯ', style: Theme.of(context).textTheme.button,),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Candidate candidate = RepositoryProvider.of<CandidateRepository>(context).candidate;
                  candidate.github = _githubController.text;
                  candidate.summary = _summaryController.text;
                  BlocProvider.of<CandidateBloc>(context).add(CandidateDataSent(
                    candidate: candidate,
                  ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
