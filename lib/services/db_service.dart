import 'dart:math';

import 'package:attendenceapp/constants/constants.dart';
import 'package:attendenceapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;
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

  Future<UserModel> getuserdata() async {
    final userdata = await _supabase
        .from(Constants.employees)
        .select()
        .eq('id', _supabase.auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(userdata);
    return userModel!;
  }
}
