import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_management/module/bottom_bar/view/bottom_bar_view.dart';
import 'package:student_management/features/colors/colors.dart';
import 'package:student_management/module/class_room/controller/class_room_provider.dart';
import 'package:student_management/module/student/controller/student_provider_controller.dart';
import 'package:student_management/module/subject/controller/subject_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudentProviderController>(create: (context) {
          return StudentProviderController();
        }),
        ChangeNotifierProvider<SubjectProvider>(create: (context) {
          return SubjectProvider();
        }),
        ChangeNotifierProvider<ClassRoomProvider>(create: (context) {
          return ClassRoomProvider();
        })
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
          ),
          home: BottomBarView(),
        );
      }),
    );
  }
}
