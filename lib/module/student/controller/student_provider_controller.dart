import 'dart:convert';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart';
import 'package:student_management/data/api_essential.dart';
import 'package:student_management/module/student/model/student_details_model.dart';
import 'package:student_management/module/student/model/student_lists_model.dart';

class StudentProviderController extends ChangeNotifier {
  List<Student> studentLists = [];
  StudentDetailsModel? studentDetailsList;
  bool isLoading = false;
  bool isAssignLoading = false;
  bool isButtonLoading = false;
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

  Future<void> getStudent() async {
    loader(true);

    try {
      final response = await get(
        Uri.parse('${ApiService().baseUrl}/students/?api_key=Cb26D'),
        headers: ApiService().headers,
      );

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final studentListModel = studentListModelFromJson(response.body);
        studentLists.clear();
        studentLists.addAll(studentListModel.students);
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

  Future<void> getStudentDetails(id) async {
    loader(true);

    try {
      final response = await get(
        Uri.parse('${ApiService().baseUrl}/students/$id?api_key=Cb26D'),
        headers: ApiService().headers,
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        final studentDetailsModel = studentDetailsModelFromJson(response.body);
        studentDetailsList = studentDetailsModel;
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

  assignFunct({studentId}) async {
    assignLoader(true);
    buttonLoader(true);
    log(studentId.toString());
    log(subjectId.toString());
    try {
      final body = {"student": studentId, "subject": subjectId};

      final response = await post(
          Uri.parse('${ApiService().baseUrl}/registration/?api_key=Cb26D'),
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
