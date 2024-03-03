import 'package:attendenceapp/models/user_model.dart';
import 'package:attendenceapp/services/attendanceservice.dart';
import 'package:attendenceapp/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey<SlideActionState> key = GlobalKey<SlideActionState>();
  @override
  void initState() {
    Provider.of<AttendanceService>(context, listen: false).getTodayAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final attendanceservice = Provider.of<AttendanceService>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Welcome".text.gray300.bold.size(30).make(),
                5.heightBox,
                Consumer<DbService>(
                  builder: (context, dbservice, child) {
                    return FutureBuilder(
                      future: dbservice.getuserdata(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          UserModel user = snapshot.data as UserModel;
                          return (user.name == ""
                                  ? "#${user.employeeId}"
                                  : user.name)
                              .text
                              .capitalize
                              .semiBold
                              .size(18)
                              .black
                              .make();
                        } else {
                          return const LinearProgressIndicator()
                              .box
                              .width(60)
                              .make()
                              .box
                              .padding(const EdgeInsets.only(left: 3))
                              .make();
                        }
                      },
                    );
                  },
                ),
                30.heightBox,
                DateFormat("dd MMMM yyyy")
                    .format(DateTime.now())
                    .text
                    .size(25)
                    .bold
                    .make(),
                StreamBuilder(
                  stream: Stream.periodic(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return DateFormat("hh:mm:ss a")
                        .format(DateTime.now())
                        .text
                        .size(15)
                        .semiBold
                        .color(Colors.black38)
                        .make()
                        .box
                        .padding(const EdgeInsets.only(left: 2))
                        .make();
                  },
                ),
                40.heightBox,
                Builder(builder: (context) {
                  return SlideAction(
                    text: attendanceservice.attendanceModel?.checkin == null
                        ? "Slide to check in"
                        : "slide to check out",
                    textStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                    outerColor: Colors.white,
                    innerColor: Colors.redAccent,
                    key: key,
                    onSubmit: () async {
                      await attendanceservice.markAttendance(context,"");
                      key.currentState!.reset();
                    },
                  );
                }),
                40.heightBox,
                "Today's Status".text.size(18).semiBold.make(),
                10.heightBox,
                Container(
                  padding: const EdgeInsets.all(40),
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check in"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkin ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check Out"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkout ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                30.heightBox,
                Container(
                  padding: const EdgeInsets.all(40),
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check in"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkin ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check Out"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkout ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                30.heightBox,
                Container(
                  padding: const EdgeInsets.all(40),
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check in"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkin ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check Out"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkout ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                30.heightBox,
                Container(
                  padding: const EdgeInsets.all(40),
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check in"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkin ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check Out"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkout ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                30.heightBox,
                Container(
                  padding: const EdgeInsets.all(40),
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check in"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkin ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Check Out"
                                .text
                                .size(20)
                                .semiBold
                                .color(Colors.black54)
                                .make(),
                            (attendanceservice.attendanceModel?.checkout ??
                                    "__/__")
                                .text
                                .size(25)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
