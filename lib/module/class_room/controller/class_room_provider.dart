import 'dart:convert';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:student_management/data/api_essential.dart';
import 'package:student_management/module/class_room/model/class_room_detail.dart';
import 'package:student_management/module/class_room/model/class_room_model.dart';

class ClassRoomProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Classroom> classRoomList = [];
  ClassRoomDetailsModel? classRoomDetailsModelData;
  bool isButtonLoading = false;
  bool isAssignLoading = false;
  dynamic subjectId;

  void loader(bool status) {
    isLoading = status;
    // Delay the call to notifyListeners until after the build phase
    Future.microtask(() {
      notifyListeners();
    });
  }

  void assignLoader(bool status) {
    isAssignLoading = status;
    // Delay the call to notifyListeners until after the build phase
    Future.microtask(() {
      notifyListeners();
    });
  }

  void buttonLoader(bool status) {
    isButtonLoading = status;
    // Delay the call to notifyListeners until after the build phase
    Future.microtask(() {
      notifyListeners();
    });
  }

  Future<void> getClassRoom() async {
    loader(true);

    try {
      final response = await http.get(
        Uri.parse('${ApiService().baseUrl}/classrooms/?api_key=Cb26D'),
        headers: ApiService().headers,
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        final classRoomModel = classRoomModelFromJson(response.body);
        classRoomList.clear();
        classRoomList.addAll(classRoomModel.classrooms);
        notifyListeners();
      } else {
        // Handle error cases if needed
        log('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions if needed
      log('Error: $error');
    } finally {
      loader(false);
      // Delay the call to notifyListeners until after the build phase
      Future.microtask(() {
        notifyListeners();
      });
    }
  }

  Future<void> getClassRoomDetails(id) async {
    loader(true);

    try {
      final response = await http.get(
        Uri.parse('${ApiService().baseUrl}/classrooms/$id?api_key=Cb26D'),
        headers: ApiService().headers,
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        final classRoomDetailsModel =
            classRoomDetailsModelFromJson(response.body);
        classRoomDetailsModelData = classRoomDetailsModel;
        notifyListeners();
      } else {
        // Handle error cases if needed
        log('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions if needed
      log('Error: $error');
    } finally {
      loader(false);
      // Delay the call to notifyListeners until after the build phase
      Future.microtask(() {
        notifyListeners();
      });
    }
  }

  assignFunct({classId}) async {
    assignLoader(true);
    buttonLoader(true);
    log(subjectId.toString());
    try {
      final body = {"subject": subjectId};

      final response = await http.patch(
          Uri.parse(
              '${ApiService().baseUrl}/classrooms/$classId?api_key=Cb26D'),
          headers: ApiService().headers,
          body: jsonEncode(body));

      log(response.body.toString());

      if (response.statusCode == 200) {
        AnimatedSnackBar.rectangle(
          'Success',
          'Assigned Successfully',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
      } else {
        AnimatedSnackBar.rectangle(
          'Error',
          'Something went wrong',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
        // Handle error cases if needed
        log('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions if needed
      log('Error: $error');
    } finally {
      assignLoader(false);
      buttonLoader(false);
      // Delay the call to notifyListeners until after the build phase
      Future.microtask(() {
        notifyListeners();
      });
    }
  }
}
