import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_management/features/colors/colors.dart';
import 'package:student_management/module/class_room/controller/class_room_provider.dart';
import 'package:student_management/module/class_room/view/class_room_detail_view.dart';

class ClassRoomView extends StatefulWidget {
  const ClassRoomView({super.key});

  @override
  State<ClassRoomView> createState() => _ClassRoomViewState();
}

class _ClassRoomViewState extends State<ClassRoomView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ClassRoomProvider>(context, listen: false).getClassRoom();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<ClassRoomProvider>(context, listen: false).getClassRoom();
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
                      "ClassRooms",
                      style: GoogleFonts.inter(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    Consumer<ClassRoomProvider>(
                        builder: (context, classRoomProvider, _) {
                      if (classRoomProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (classRoomProvider.classRoomList.isEmpty) {
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
                                  childAspectRatio: .97,
                                  crossAxisCount: 2),
                          itemCount: classRoomProvider.classRoomList.length,
                          itemBuilder: (context, index) {
                            final classRoomData =
                                classRoomProvider.classRoomList[index];
                            return InkWell(
                              onTap: () {
                                Get.to(ClassRoomDetailView(
                                  strength: classRoomData.size,
                                  type: classRoomData.layout,
                                  id: classRoomData.id,
                                ));
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 110,
                                      child: Image.network(
                                        "https://img.icons8.com/bubbles/50/classroom.png",
                                        centerSlice: Rect.largest,
                                      ),
                                    ),
                                    Text(
                                      classRoomData.name,
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Wrap(
                                      children: [
                                        const Text("Strength: "),
                                        Text(
                                          classRoomData.size.toString(),
                                          style: GoogleFonts.inter(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        const Text("Layout: "),
                                        Text(
                                          classRoomData.layout.toString(),
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
                ))
          ],
        ),
      ),
    );
  }
}
