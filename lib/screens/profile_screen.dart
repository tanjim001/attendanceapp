import 'package:attendenceapp/models/dbmodel.dart';
import 'package:attendenceapp/services/auth_service.dart';
import 'package:attendenceapp/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController namecontroller = TextEditingController();
  int selectedvalue = 0;

  @override
  Widget build(BuildContext context) {
    final dbservice = Provider.of<DbService>(context);
    dbservice.allDepartment.isEmpty ? dbservice.getAllDepartment() : null;
    namecontroller.text.isEmpty
        ? namecontroller.text = dbservice.userModel?.name ?? ""
        : null;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end,children: [IconButton(onPressed: (){Provider.of<AuthService>(context,listen: false).signOut();}, icon: Icon(Icons.logout))],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 50, color: Colors.white)
                      .box
                      .p32.rounded
                      .color(Colors.redAccent)
                      .make(),
                  
                ],
              ).box.p32.make(),
              "EmployeeID: ${dbservice.userModel?.employeeId}".text.make(),
              20.heightBox,
              TextField(
                    controller: namecontroller,
                    decoration: const InputDecoration(
                        label: Text("Full name"), border: OutlineInputBorder()),
                  ).box.margin(const EdgeInsets.only(left: 30,right: 30)).make(),
              30.heightBox,
              dbservice.allDepartment.isEmpty
                  ? const LinearProgressIndicator()
                  : Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                      width: double.infinity,
                      child: DropdownButtonFormField(
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        value: dbservice.employeeDepartment ??
                            dbservice.allDepartment.first.id,
                        items:
                            dbservice.allDepartment.map((DepartmentModel item) {
                          return DropdownMenuItem(
                              value: item.id,
                              child: Text(
                                item.title,
                                style: const TextStyle(fontSize: 20),
                              ));
                        }).toList(),
                        onChanged: (selectedValue) {
                          dbservice.employeeDepartment = selectedValue;
                        },
                      ),
                    ),
                    80.heightBox,
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    dbservice.updateProfile(namecontroller.text.trim(), context);
                  },
                  child: const Text(
                    "Update Profile",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
