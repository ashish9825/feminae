class FacilityServices {
  final String facilityId;
  final String facilityName;
  final String facilityImageUrl;
  final int facilityPrice;

  FacilityServices(this.facilityId, this.facilityName, this.facilityImageUrl,
      this.facilityPrice);

  FacilityServices.fromJson(Map<String, dynamic> json)
      : facilityId = json["facilityId"],
        facilityName = json["facilityname"],
        facilityImageUrl = json["facilityimageurl"],
        facilityPrice = json["facilityprice"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> facilityServices = Map<String, dynamic>();
    facilityServices['facilityid'] = this.facilityId;
    facilityServices['facilityname'] = this.facilityName;
    facilityServices['facilityimageurl'] = this.facilityImageUrl;
    facilityServices['facilityprice'] = this.facilityPrice;
    return facilityServices;
  }
}
