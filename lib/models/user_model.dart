/*class UserModel {
  final String id;
  final String email;
  final String name;
  final int? department;
  final String employeeId;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      this.department,
      required this.employeeId});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        id: data['id'],
        email: data['email'],
        name: data['name'],
        department: data['department'],
        employeeId: data['employee_id']);
  }
}*/

class ProfileModel{
  final String id;
  final String createdat;
  final String name;
  final String? avatar;
  final String role;
  final String profession;
  final String users;

  ProfileModel({required this.id, required this.createdat, required this.name, required this.avatar, required this.role, required this.profession, required this.users});
  factory ProfileModel.fromJson(Map<String,dynamic>data){
    return ProfileModel(id: data["id"], createdat: data["created_at"], name: data["name"], avatar: data["avatar"], role: data["role"], profession: data["profession"], users: data["users"]);
  }
}
