import 'package:feminae/model/facilities.dart';

class FacilityResponse {
  final List<Facility> facilities;
  final String error;

  FacilityResponse(this.facilities, this.error);

  FacilityResponse.fromJson(List data)
      : facilities = data.map((f) => Facility.fromJson(f)).toList(),
        error = "";

  FacilityResponse.withError(String errorValue)
      : facilities = List(),
        error = errorValue;
}
