import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConferenceRoomLayout extends StatelessWidget {
  final int strength;

  const ConferenceRoomLayout({required this.strength, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int topRowStrength = strength ~/ 2;
    int bottomRowStrength = strength - topRowStrength;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Top row of chairs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              topRowStrength,
              (index) => const Flexible(
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    minRadius: 10,
                    child: Text('S'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          // Conference table
          Row(
            children: [
              const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 171, 171, 171),
                  child: Text("T")),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Container(
                  height: 150.0,
                  width: 100.w,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Conference Table',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          // Bottom row of chairs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              bottomRowStrength,
              (index) => const Flexible(
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: CircleAvatar(minRadius: 10, child: Text('S')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
