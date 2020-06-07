class Facility {
  final int facilityId;
  final String facility;
  final String facilityImage;

  Facility(this.facilityId, this.facility, this.facilityImage);

  Facility.fromJson(Map<String, dynamic> json)
      : facilityId = json['id'],
        facility = json["facility"],
        facilityImage = json["facilityImageUrl"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> facilities = Map<String, dynamic>();
    facilities['id'] = this.facilityId;
    facilities['facility'] = this.facility;
    facilities['facilityImageUrl'] = this.facilityImage;
    return facilities;
  }
}
