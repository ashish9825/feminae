import 'package:feminae/model/facility_response.dart';
import 'package:feminae/network/repositories/facility_repository.dart';
import 'package:feminae/screens/salon/salon_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FacilityBloc {
  final FacilityRepository _repository = FacilityRepository();
  final BehaviorSubject<FacilityResponse> _subject =
      BehaviorSubject<FacilityResponse>();

  getFacilities() async {
    FacilityResponse response = await _repository.getFacilities();
    _subject.sink.add(response);
  }

  movetoTab(int id, BuildContext context) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => SalonDetail(
          tabIndex: id,
        ),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: Duration(milliseconds: 100),
      ),
    );
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<FacilityResponse> get subject => _subject;
}

final bloc = FacilityBloc();
