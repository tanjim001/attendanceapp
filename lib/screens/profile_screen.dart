
import 'package:attendenceapp/constants/style.dart';
import 'package:attendenceapp/models/user_model.dart';
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
  final TextEditingController namecontroller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Provider.of<AuthService>(context, listen: false).signOut(),
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const Icon(Icons.person, size: 50, color: Colors.white)
                          .box
                          .p32
                          .rounded
                          .color(Colors.redAccent)
                          .make(),
                      InkWell(child: "Add Profile pic".text.make()),
                    ],
                  ),
                ],
              ).box.p32.make(),
              60.heightBox,
              Consumer<DbService>(
                builder: (context, dbservice, _) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getStyledText("Joined",context),
                        20.heightBox,
                        getStyledText("Name: ${dbservice.userModel?.name??""}" ,context),
                        20.heightBox,
                        getStyledText("Role: ${dbservice.userModel?.role??""}",context),
                        20.heightBox,
                        getStyledText("Profession: ${dbservice.userModel?.profession??""}",context),
                      ],
                    ),
                  );
                },
                
              ),
              30.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

