/*class DepartmentModel {
  final int id;
  final String title;

  DepartmentModel({required this.id, required this.title});

  factory DepartmentModel.fromJson(Map<String, dynamic> data) {
    return DepartmentModel(id: data['id'], title: data['title']);
  }
}*/

class ChecksModel {
  final String ?id;
  final String? createat;
  final String? createdin;
  final String? checkout;
  final String? attendance;
  final Map<String,dynamic>? checkinlocation;
  final Map<String,dynamic>? checkoutlocation;

  ChecksModel(
      {required this.id,
      required this.createat,
      required this.createdin,
      required this.checkout,
      required this.attendance,
      required this.checkinlocation,
      required this.checkoutlocation});
  factory ChecksModel.fromjson(Map<String, dynamic> data) {
    return ChecksModel(
        id: data["id"],
        createat: data["created_at"],
        createdin: data["check_in"],
        checkout: data["check_out"],
        attendance: data["attendance"],
        checkinlocation: data["check_in_location"],
        checkoutlocation: data["check_out_location"]);
  }
}
