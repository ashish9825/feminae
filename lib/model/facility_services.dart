class FacilityServices {
  final int facilityId;
  final String facilityName;
  final String facilityImageUrl;
  final double facilityPrice;

  FacilityServices(this.facilityId, this.facilityName, this.facilityImageUrl,
      this.facilityPrice);

  FacilityServices.fromJson(Map<String, dynamic> json)
      : facilityId = json["facilityId"],
        facilityName = json["facilityName"],
        facilityImageUrl = json["facilityImageUrl"],
        facilityPrice = json["facilityPrice"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> facilityServices = Map<String, dynamic>();
    facilityServices['facilityId'] = this.facilityId;
    facilityServices['facilityName'] = this.facilityName;
    facilityServices['facilityImageUrl'] = this.facilityImageUrl;
    facilityServices['facilityPrice'] = this.facilityPrice;
    return facilityServices;
  }
}
