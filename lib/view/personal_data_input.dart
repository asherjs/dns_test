import 'package:dns_test/bloc/candidate_bloc.dart';
import 'package:dns_test/models/candidate.dart';
import 'package:dns_test/repositories/candidate_repository.dart';
import 'package:dns_test/view/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDataInput extends StatefulWidget {
  @override
  State<PersonalDataInput> createState() => _PersonalDataInputState();
}

class _PersonalDataInputState extends State<PersonalDataInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ввод данных', style: Theme.of(context).textTheme.headline6,),
      ),
      body: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: [
            TextFormField(
              controller: _firstNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Пожалуйста, введите Ваше имя';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Имя',
              ),
            ),
            TextFormField(
              controller: _lastNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Пожалуйста, введите Вашу фамилию';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Фамилия',
              ),
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                bool isValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                if (!isValid) {
                  return 'Пожалуйста введите корректный e-mail';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'e-mail',
              ),
            ),
            TextFormField(
              controller: _phoneController,
              validator: (value) {
                bool isValid = RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)").hasMatch(value);
                if (!isValid) {
                  return 'Пожалуйста введите корректный номер телефона';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Телефон',
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: RaisedButton(
                child: Text(
                  'ПОЛУЧИТЬ КЛЮЧ',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    RepositoryProvider
                        .of<CandidateRepository>(context)
                        .candidate = Candidate(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                    );
                    Candidate candidate = RepositoryProvider
                        .of<CandidateRepository>(context)
                        .candidate;
                    BlocProvider.of<CandidateBloc>(context).add(
                        CandidateTokenRequested(
                          candidate: candidate,
                        ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataSending(),
                      ),
                    );
                  }},
              ),
            )
          ],
      ),
    );
  }
}

