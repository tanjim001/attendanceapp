import 'dart:math';
import 'package:attendenceapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  ProfileModel? _userModel;
  ProfileModel? get userModel => _userModel;
  int? employeeDepartment;

  String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "faangFAANG0123456789";
    final randomString =
        List.generate(8, (index) => allChars[random.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  void updateData(ProfileModel userModel) {
    _userModel = userModel;
    notifyListeners(); // Notify listeners about the change
  }

  Future<ProfileModel?> getprofiledata() async {
    ProfileModel? usermodel;
    try {
      final userdata = await _supabase.from("profile").select('*').single();
      usermodel = ProfileModel.fromJson(userdata);
      updateData(usermodel);
      
    } catch (error) {
      print('Error fetching profile data: $error');
      return null;
    }
    return null;
  }
}
