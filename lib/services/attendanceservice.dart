import 'dart:async';

import 'package:attendenceapp/constants/constants.dart';
import 'package:attendenceapp/models/attendance_model.dart';
import 'package:attendenceapp/models/checkmodel.dart';
import 'package:attendenceapp/services/locationservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:supabase_flutter/supabase_flutter.dart';


class AttendanceService extends ChangeNotifier {
  Attendance? _attendance;
  ChecksModel? _checkModel;
  Attendance? get attendance => _attendance;
  ChecksModel? get checkModel=>_checkModel;
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _todayDate = DateFormat("dd MMMM yyyy").format(DateTime.now());

    void updateData(Attendance data) {
    _attendance = data;
    notifyListeners(); // Notify listeners about the change
  }

  Future checktoadyattendance(BuildContext context) async {
    Attendance? atten;
    var s = await _supabase
        .from(Constants.attendance)
        .select('*')
        .eq('users', _supabase.auth.currentUser!.id)
        .eq('date', _todayDate)
        .maybeSingle();
    if (s != null) {atten = Attendance.fromJson(s);updateData(atten);}
    if (atten == null) {
      await _supabase
          .from(Constants.attendance)
          .insert({'users': _supabase.auth.currentUser!.id, 'date': _todayDate})
          .select('*')
          .single();
        s=await _supabase
        .from(Constants.attendance)
        .select('*')
        .eq('users', _supabase.auth.currentUser!.id)
        .eq('date', _todayDate)
        .maybeSingle();
        atten= Attendance.fromJson(s!);
        updateData(atten);
    }
   
    
  }

     void updateCheckData(ChecksModel data) {
    _checkModel = data;
    notifyListeners(); // Notify listeners about the change
  }

Future markdatafetch()async{
  ChecksModel? ch;
    var data = await _supabase
        .from(Constants.check)
        .select('*')
        .eq('attendance', attendance!.id)
        .isFilter('check_out', null)
        .maybeSingle();
    if (data != null) {
      ch = ChecksModel.fromjson(data);
      updateCheckData(ch);
    }
}


  Future markAttendance(BuildContext context) async {
    Map? getlocation =
        await LocationService().initializeandGetLocation(context);
    markdatafetch();

    if (getlocation != null) {
      if (checkModel == null || checkModel!.createat == null || checkModel!.checkout != null) {
        await _supabase.from(Constants.check).insert({
          'check_in': DateFormat('HH:mm').format(DateTime.now()),
          'check_in_location': getlocation,
          'attendance': attendance!.id,
        });
        markdatafetch();
        notifyListeners();
      } else if (checkModel?.checkout == null &&
          checkModel?.createdin != null) {
        await _supabase
            .from(Constants.check)
            .update({
              'check_out': DateFormat('HH:mm').format(DateTime.now()),
              "check_out_location": getlocation
            })
            .eq('attendance', attendance!.id)
            .select();
           _checkModel=null;
        notifyListeners();
      }
    }
  }
}
