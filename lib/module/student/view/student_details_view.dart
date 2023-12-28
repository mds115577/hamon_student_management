import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_management/features/colors/colors.dart';
import 'package:student_management/module/student/controller/student_provider_controller.dart';
import 'package:student_management/module/subject/controller/subject_provider.dart';

class StudentDetailView extends StatefulWidget {
  const StudentDetailView({super.key, this.id});
  final id;
  @override
  State<StudentDetailView> createState() => _StudentDetailViewState();
}

class _StudentDetailViewState extends State<StudentDetailView> {
  @override
  void initState() {
    Provider.of<StudentProviderController>(context, listen: false)
        .getStudentDetails(widget.id);
    Provider.of<SubjectProvider>(context, listen: false).getSubjects();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StudentProviderController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Details",
          style:
              GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          Consumer<StudentProviderController>(
              builder: (context, studentProviderController, _) {
            if (studentProviderController.isLoading) {
              return Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: const Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
              );
            }
            final detailData = studentProviderController.studentDetailsList;
            return Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Card(
                      color: const Color.fromARGB(138, 255, 255, 255),
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 70,
                              child: Icon(
                                Icons.person,
                                size: 70,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              detailData!.name,
                              style: GoogleFonts.inter(
                                  color: primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("ID : ${detailData.id}",
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.w300)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Age:  ",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                Text(detailData.age.toString(),
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Text(detailData.email,
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          }),
          Padding(
            padding: EdgeInsets.only(right: 4.w, left: 4.w, top: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Assign Subject",
                        style: GoogleFonts.inter(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 100.w,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      isDense: true,
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: const Color.fromRGBO(0, 0, 0, 1)),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.1725,
                            color: const Color.fromARGB(93, 0, 0, 0),
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10),
                          hintText: "Select Shop",
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 0,
                                  color: Color.fromARGB(255, 199, 199, 179))),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: const Color.fromARGB(153, 215, 213, 213),
                          focusColor: const Color.fromARGB(255, 231, 231, 231)),
                      value: controller.subjectId,
                      onChanged: (value) async {
                        controller.subjectId = value;
                      },
                      items: Provider.of<SubjectProvider>(context)
                          .subjectList
                          .map((data) {
                        return DropdownMenuItem(
                            value: data.id.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                data.name,
                                overflow: TextOverflow.visible,
                              ),
                            ));
                      }).toList(),
                    )),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            Consumer<StudentProviderController>(builder: (context, value, _) {
          return InkWell(
            onTap: () {
              value.assignFunct(studentId: controller.studentDetailsList!.id);
            },
            child: Container(
              width: 100.w,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                      offset: Offset(0, 2),
                      blurRadius: 10)
                ],
                color: const Color.fromRGBO(20, 145, 253, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  value.isButtonLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("Assign",
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
