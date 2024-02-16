import 'package:attendenceapp/models/attendance_model.dart';
import 'package:attendenceapp/services/attendanceservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    final attendanceService = Provider.of<AttendanceService>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "My Attendance"
                          .text
                          .size(25)
                          .bold
                          .color(Vx.gray400)
                          .make(),
                      attendanceService.attendanceHistoryMonth.text.semiBold
                          .size(18)
                          .make(),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate =
                          await SimpleMonthYearPicker.showMonthYearPickerDialog(
                        context: context,
                        disableFuture: true,
                      );
                      String pickedMonth =
                          DateFormat("MMMM yyyy").format(selectedDate);
                      attendanceService.attendanceHistoryMonth = pickedMonth;
                    },
                    child: "Pick a month".text.make(),
                  ),
                ],
              ).box.p16.make(),
              FutureBuilder(
                future: attendanceService.getAttendanceHistory(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        AttendanceModel attendanceData = snapshot.data[index];
                        return Row(
                          children: [
                            DateFormat("EE\n dd")
                                .format(attendanceData.createdAt)
                                .text
                                .size(24)
                                .white
                                .make()
                                .box
                                .padding(const EdgeInsets.all(20))
                                .rounded
                                .color(Colors.redAccent)
                                .make(),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      "check in".text.size(24).semiBold.make(),
                                      10.heightBox,
                                      attendanceData.checkin.text
                                          .size(20)
                                          .semiBold
                                          .color(Vx.gray600)
                                          .make()
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      "checkout".text.size(24).semiBold.make(),
                                      10.heightBox,
                                      (attendanceData.checkout ?? "__/__").text
                                          .size(20)
                                          .semiBold
                                          .color(Vx.gray600)
                                          .make()
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                            .box
                            .rounded
                            .padding(const EdgeInsets.all(10))
                            .color(Colors.white)
                            .border()
                            .margin(const EdgeInsets.only(
                                top: 10, bottom: 20, left: 20, right: 20))
                            .make();
                      },
                    );
                  } else {
                    return "No data available".text.make();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
