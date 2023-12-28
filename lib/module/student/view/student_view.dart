import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_management/features/colors/colors.dart';
import 'package:student_management/module/student/controller/student_provider_controller.dart';
import 'package:student_management/module/student/view/student_details_view.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<StudentProviderController>(context, listen: false).getStudent();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<StudentProviderController>(context, listen: false)
            .getStudent();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_none))
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Students",
                    style: GoogleFonts.inter(
                        fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<StudentProviderController>(
                      builder: (contexts, studentProviderController, _) {
                    if (studentProviderController.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (studentProviderController.studentLists.isEmpty) {
                      return Center(
                          child: Lottie.asset(
                              "assets/Animation - 1703798633693.json"));
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (ctx, index1) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount:
                            studentProviderController.studentLists.length,
                        itemBuilder: (context, index) {
                          final data =
                              studentProviderController.studentLists[index];
                          return ListTile(
                            onTap: () {
                              Get.to(StudentDetailView(
                                id: data.id,
                              ));
                            },
                            tileColor: const Color.fromARGB(255, 211, 209, 209),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            leading: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 138, 138, 138),
                              child: Text("${data.id}"),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  "Name: ",
                                  style: GoogleFonts.inter(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Flexible(
                                  child: Text(data.name,
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "e-mail : ",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400),
                                ),
                                Flexible(child: Text(data.email))
                              ],
                            ),
                          );
                        });
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
