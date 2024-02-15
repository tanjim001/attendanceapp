import 'package:attendenceapp/constants/constants.dart';
import 'package:attendenceapp/models/attendance_model.dart';
import 'package:attendenceapp/services/locationservice.dart';
import 'package:attendenceapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  AttendanceModel? attendanceModel;
  String _todayDate = DateFormat("dd MMMM yyyy").format(DateTime.now());
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _attendanceHistoryMonth =
      DateFormat("MMMM yyyy").format(DateTime.now());
  String get attendanceHistoryMonth => _attendanceHistoryMonth;

  set attendanceHistoryMonth(String value) {
    _attendanceHistoryMonth = value;
    notifyListeners();
  }

  Future<void> getTodayAttendance() async {
    final List result = await _supabase
        .from(Constants.attendance)
        .select()
        .eq("employee_id", _supabase.auth.currentUser!.id)
        .eq('date', _todayDate);
    if (result.isNotEmpty) {
      attendanceModel = AttendanceModel.fromJson(result.first);
    }
    notifyListeners();
  }

  Future<List<AttendanceModel>> getAttendanceHistory() async {
    final List data = await _supabase
        .from(Constants.attendance)
        .select()
        .eq('employee_id', _supabase.auth.currentUser!.id)
        .textSearch('date', "'$attendanceHistoryMonth'", config: 'english')
        .order('created_at', ascending: false);
    return data
        .map((attendance) => AttendanceModel.fromJson(attendance))
        .toList();
  }

  Future<void> markAttendance(BuildContext context) async {
    Map? getloction = await LocationService().initializeandGetLocation(context);
    if (getloction != null) {
      if (attendanceModel?.checkin == null) {
        await _supabase.from(Constants.attendance).insert({
          'employee_id': _supabase.auth.currentUser!.id,
          'date': _todayDate,
          'check_in': DateFormat('HH:mm').format(DateTime.now()),
          "check_in_location": getloction
        });
      } else if (attendanceModel?.checkout == null) {
        await _supabase
            .from(Constants.attendance)
            .update({
              'check_out': DateFormat('HH:mm').format(DateTime.now()),
              "check_out_location": getloction
            })
            .eq('employee_id', _supabase.auth.currentUser!.id)
            .eq('date', _todayDate);
      } else {
        Utils.showSnackBar("You have already checked out today!", context);
      }
      await getTodayAttendance();
    } else {
      Utils.showSnackBar("unable to get loction!", context);
      await getTodayAttendance();
    }
  }
}
