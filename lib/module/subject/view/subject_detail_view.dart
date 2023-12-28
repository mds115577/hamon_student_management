import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_management/features/colors/colors.dart';
import 'package:student_management/module/subject/controller/subject_provider.dart';

class SubjectDetailView extends StatefulWidget {
  const SubjectDetailView({super.key, this.id});
  final id;

  @override
  State<SubjectDetailView> createState() => _SubjectDetailViewState();
}

class _SubjectDetailViewState extends State<SubjectDetailView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SubjectProvider>(context, listen: false)
        .getSubjectDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subject Details",
          style:
              GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          Consumer<SubjectProvider>(builder: (context, subjectProvider, _) {
            if (subjectProvider.isLoading) {
              return const Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
            final detailData = subjectProvider.subjectDetails;
            return Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 0,
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    "https://img.icons8.com/cute-clipart/64/book.png"),
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
                            Text("ID : ${detailData.id.toString()}",
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.w300)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Tutor: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                Text(detailData.teacher,
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Credits: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                Text(detailData.credits.toString(),
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          })
        ],
      ),
    );
  }
}
