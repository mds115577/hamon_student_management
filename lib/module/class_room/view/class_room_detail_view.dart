import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:student_management/module/class_room/controller/class_room_provider.dart';
import 'package:student_management/module/class_room/refactors/class_room_layout.dart';
import 'package:student_management/module/class_room/refactors/conference_layout.dart';
import 'package:student_management/module/subject/controller/subject_provider.dart';

class ClassRoomDetailView extends StatefulWidget {
  const ClassRoomDetailView(
      {super.key, required this.strength, required this.type, this.id});
  final int strength;
  final String type;
  final id;
  @override
  State<ClassRoomDetailView> createState() => _ClassRoomDetailViewState();
}

class _ClassRoomDetailViewState extends State<ClassRoomDetailView> {
  @override
  void initState() {
    Provider.of<ClassRoomProvider>(context, listen: false)
        .getClassRoomDetails(widget.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ClassRoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ClassRoom Details",
          style:
              GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Consumer<ClassRoomProvider>(
                builder: (context, classRoomProvider, _) {
              if (classRoomProvider.isLoading) {
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

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    classRoomProvider.classRoomDetailsModelData!.name,
                    style: GoogleFonts.inter(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "Strength: ${classRoomProvider.classRoomDetailsModelData!.size}",
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w300)),
                  Row(
                    children: [
                      Text("Subject:  ",
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      Text(
                          classRoomProvider
                                  .classRoomDetailsModelData!.subject.isEmpty
                              ? "Please Assign Subject"
                              : classRoomProvider
                                  .classRoomDetailsModelData!.subject,
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w500))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 4.w, left: 0.w, top: 10),
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
                                          color: Color.fromARGB(
                                              255, 199, 199, 179))),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 0,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor:
                                      const Color.fromARGB(153, 215, 213, 213),
                                  focusColor:
                                      const Color.fromARGB(255, 231, 231, 231)),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.assignFunct(classId: widget.id);
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.15000000596046448),
                                    offset: Offset(0, 2),
                                    blurRadius: 10)
                              ],
                              color: const Color.fromRGBO(20, 145, 253, 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                classRoomProvider.isButtonLoading
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  widget.type == "classroom"
                      ? ClassroomLayout(
                          classStrength: widget.strength,
                        )
                      : ConferenceRoomLayout(strength: widget.strength),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
