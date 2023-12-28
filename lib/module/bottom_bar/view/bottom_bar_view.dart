import 'package:flutter/material.dart';
import 'package:student_management/module/class_room/view/class_room_view.dart';
import 'package:student_management/features/colors/colors.dart';
import 'package:student_management/module/student/view/student_view.dart';
import 'package:student_management/module/subject/view/subject_view.dart';

class BottomBarView extends StatelessWidget {
  BottomBarView({super.key});
  static ValueNotifier<int> selectedPageIndex = ValueNotifier(0);
  final pages = [
    const StudentView(),
    const SubjectView(),
    const ClassRoomView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: BottomBarView.selectedPageIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13), topRight: Radius.circular(13)),
            child: BottomNavigationBar(
              elevation: 19,
              unselectedItemColor: const Color.fromARGB(255, 107, 107, 107),
              showUnselectedLabels: true,
              selectedItemColor: primaryColor,
              // backgroundColor: Color.fromARGB(255, 255, 255, 255),
              currentIndex: updatedIndex,
              backgroundColor: const Color.fromARGB(255, 233, 227, 227),
              onTap: ((newIndex) {
                BottomBarView.selectedPageIndex.value = newIndex;
              }),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_4_outlined),
                  label: 'Student',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.my_library_books_outlined),
                    label: 'Subject'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Classroom'),
              ],
            ),
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: BottomBarView.selectedPageIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return pages[updatedIndex];
        },
      ),
    );
  }
}
