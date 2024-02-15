class AttendanceModel {
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
}
