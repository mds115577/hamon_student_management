import 'package:flutter/material.dart';

class ClassroomLayout extends StatelessWidget {
  final int classStrength;

  const ClassroomLayout({super.key, required this.classStrength});

  @override
  Widget build(BuildContext context) {
    return _buildClassroomLayout();
  }

  Widget _buildClassroomLayout() {
    // Number of seats per row in the classroom
    int seatsPerRow = 4;

    // Calculate the number of rows needed based on class strength
    int numRows = (classStrength / seatsPerRow).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 171, 171, 171),
            child: Text("T")),
        Column(
          children: List.generate(
            numRows,
            (rowIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    seatsPerRow,
                    (seatIndex) {
                      int seatNumber = rowIndex * seatsPerRow + seatIndex + 1;

                      return seatNumber <= classStrength
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(child: Text('S')),
                            )
                          : Container();
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
