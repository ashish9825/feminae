import 'dart:async';
import 'package:feminae/bloc/auth_bloc.dart';
import 'package:feminae/dashboard.dart';
import 'package:feminae/network/repositories/facility_repository.dart';
import 'package:feminae/network/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginBLoc with Validators {
  FacilityRepository _repository = FacilityRepository();
  ScaffoldState scaffold;

  StreamController<ScaffoldState> _scaffoldController =
      StreamController<ScaffoldState>();

  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();

  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (email, password) => true);

  StreamSink<ScaffoldState> get setScaffold => _scaffoldController.sink;

  bool _progressStatus = false;

  LoginBLoc() {
    _scaffoldController.stream.listen((event) {
      scaffold = event;
    });
  }

  submit(BuildContext context) async {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);

    await login(validEmail, validPassword, context);
  }

  login(String email, String password, BuildContext context) async {
    String token = await _repository.getLoginStatus(email, password);

    print('TOKEN : $token');

    if (token != null && token.length > 7) {
      _loadingData.sink.add(false);
      authBloc.openSession(token);
      _progressStatus = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(token),
        ),
      );
    } else if (token == "404") {
      _progressStatus = true;
      scaffold.showSnackBar(SnackBar(
        content: Text(
          'Enter Valid Credentials !',
          style: TextStyle(fontFamily: 'Poppins-Medium'),
        ),
      ));
    } else {
      _progressStatus = true;
      scaffold.showSnackBar(SnackBar(
        content: Text(
          'Error Occured !',
          style: TextStyle(fontFamily: 'Poppins-Medium'),
        ),
      ));
    }
  }

  bool get getStatusProgress => _progressStatus;

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
    _scaffoldController.close();
  }
}
