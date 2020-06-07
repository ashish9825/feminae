import 'dart:async';
import 'package:feminae/bloc/auth_bloc.dart';
import 'package:feminae/network/repositories/facility_repository.dart';
import 'package:feminae/network/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBLoc with Validators {
  FacilityRepository _repository = FacilityRepository();

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

  bool _progressStatus = false;

  submit() async {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);

    await login(validEmail, validPassword);
  }

  login(String email, String password) async {
    String token = await _repository.getLoginStatus(email, password);

    print('User Token: $token');

    if (token != null) {
      _loadingData.sink.add(false);
      authBloc.openSession(token);
      _progressStatus = true;
    } else {
      _progressStatus = true;
      print('Enter Valid Credentials');
    }
  }

  bool get getStatusProgress => _progressStatus;

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}
