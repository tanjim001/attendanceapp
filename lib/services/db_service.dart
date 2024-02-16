import 'dart:math';

import 'package:attendenceapp/constants/constants.dart';
import 'package:attendenceapp/models/dbmodel.dart';
import 'package:attendenceapp/models/user_model.dart';
import 'package:attendenceapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;
  List<DepartmentModel> allDepartment = [];
  int? employeeDepartment;

  String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "faangFAANG0123456789";
    final randomString =
        List.generate(8, (index) => allChars[random.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constants.employees).insert({
      'id': id,
      'name': '',
      'email': email,
      'employee_id': generateRandomEmployeeId(),
      'department': null,
    });
  }

  Future<void> getAllDepartment() async {
    final List result = await _supabase.from(Constants.departments).select();
    allDepartment = result
        .map((department) => DepartmentModel.fromJson(department))
        .toList();
    notifyListeners();
  }

  Future<UserModel> getuserdata() async {
    final userdata = await _supabase
        .from(Constants.employees)
        .select()
        .eq('id', _supabase.auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(userdata);
    employeeDepartment == null
        ? employeeDepartment = userModel?.department
        : null;
    return userModel!;
  }

  Future updateProfile(String name, BuildContext context) async {
    await _supabase
        .from(Constants.employees)
        .update({'name': name, 'department': employeeDepartment}).eq(
            'id', _supabase.auth.currentUser!.id);
    Utils.showSnackBar("profile update succesful", context);
    notifyListeners();
  }
}
