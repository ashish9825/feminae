import 'package:feminae/model/facility_service_response.dart';
import 'package:feminae/network/repositories/facility_repository.dart';
import 'package:rxdart/rxdart.dart';

class FacilityServiceBloc {
  final FacilityRepository _repository = FacilityRepository();
  final BehaviorSubject<FacilityServiceResponse> _subject =
      BehaviorSubject<FacilityServiceResponse>();

  getFacilityServices(int id) async {
    FacilityServiceResponse response =
        await _repository.getFacilityServices(id);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<FacilityServiceResponse> get subject => _subject;
}

final servicesBloc = FacilityServiceBloc();
