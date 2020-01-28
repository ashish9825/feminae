import 'package:flutter/material.dart';

const kEmailInputDecoration = InputDecoration(
  hintText: "Email",
  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
);

const kPasswordInputDecoration = InputDecoration(
  hintText: "Password",
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 12.0,
  ),
);

const kConfirmPasswordInoutDecoration = InputDecoration(
  hintText: "Confirm Password",
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 12.0,
  ),
);

const List<List<String>> salonFacilities = [
  ['images/waxing.svg', 'Waxing'],
  ['images/facial_cleanup.svg', 'Facial Cleanup'],
  ['images/bleach.svg', 'Bleach & Detan'],
  ['images/pedicure.svg', 'Pedicure'],
  ['images/manicure.svg', 'Manicure'],
  ['images/hair_care.svg', 'Hair Care'],
  ['images/threading.svg', 'Threading'],
];

const List<List<String>> cleaningServices = [
  ['images/washroom_cleaning.svg', 'Washroom Cleaning'],
  ['images/kitchen_cleaning.svg', 'Kitchen Cleaning'],
  ['images/sofa_cleaning.svg', 'Sofa Cleaning'],
  ['images/home_cleaning.svg', 'Home Cleaning'],
  ['images/carpet_cleaning.svg', 'Carpet Cleaning'],
  ['images/car_cleaning.svg', 'Car Cleaning'],
];

const List<List<String>> electronics = [
  ['images/electrician.svg', 'Electricians'],
  ['images/appliance_repair.svg', 'Appliance Repair'],
];
