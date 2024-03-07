// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/*class AttendanceModel {
  final String id;
  final String date;
  final String checkin;
  final String? checkout;
  final DateTime createdAt;
  final Map? checkInLocation;
  final Map? checkOutLocation;

  AttendanceModel(
      {required this.id,
      required this.date,
      required this.checkin,
      this.checkout,
      required this.createdAt,
      this.checkInLocation,
      this.checkOutLocation});

  factory AttendanceModel.fromJson(Map<String, dynamic> data) {
    return AttendanceModel(
      id: data['employee_id'],
      date: data['date'],
      checkin: data['check_in'],
      checkout: data['check_out'],
      createdAt: DateTime.parse(data["created_at"]),
      checkInLocation: data["check_in_location"],
      checkOutLocation: data["check_out_location"],
    );
  }
}*/
class Attendance {
  final String id;
  final String date;
  final DateTime createdat;
  final String users;

  Attendance({required this.id, required this.date, required this.createdat,required this.users});
  
factory Attendance.fromJson(Map<String, dynamic> data) {
    return Attendance(
      id: data['id'],
      date: data['date'],
      users:data['users'],
      createdat: DateTime.parse(data["created_at"]),


    );
  }
 
}
