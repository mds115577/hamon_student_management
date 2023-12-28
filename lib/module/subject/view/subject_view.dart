import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_management/features/colors/colors.dart';
import 'package:student_management/module/subject/controller/subject_provider.dart';
import 'package:student_management/module/subject/view/subject_detail_view.dart';

class SubjectView extends StatefulWidget {
  const SubjectView({super.key});

  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  void initState() {
    Provider.of<SubjectProvider>(context, listen: false).getSubjects();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<SubjectProvider>(context, listen: false).getSubjects();
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
                    "Subjects",
                    style: GoogleFonts.inter(
                        fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<SubjectProvider>(
                      builder: (context, subjectProvider, _) {
                    if (subjectProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (subjectProvider.subjectList.isEmpty) {
                      return Center(
                          child: Lottie.asset(
                              "assets/Animation - 1703798633693.json"));
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                                crossAxisCount: 2),
                        itemCount: subjectProvider.subjectList.length,
                        itemBuilder: (context, index) {
                          final data = subjectProvider.subjectList[index];
                          return InkWell(
                            onTap: () {
                              Get.to(SubjectDetailView(
                                id: data.id,
                              ));
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 110,
                                    child: Image.network(
                                      "https://img.icons8.com/cute-clipart/64/book.png",
                                      centerSlice: Rect.largest,
                                    ),
                                  ),
                                  Text(
                                    data.name,
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Wrap(
                                    children: [
                                      const Text("Tutor: "),
                                      Text(
                                        data.teacher,
                                        style: GoogleFonts.inter(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
