import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_management/data/api_essential.dart';
import 'package:student_management/module/subject/model/subject_details_model.dart';
import 'package:student_management/module/subject/model/subject_model.dart';

class SubjectProvider extends ChangeNotifier {
  List<Subject> subjectList = [];
  SubjectDetailsModel? subjectDetails;
  bool isLoading = false;

  void loader(bool status) {
    isLoading = status;
    // Delay the call to notifyListeners until after the build phase
    Future.microtask(() {
      notifyListeners();
    });
  }

  Future<void> getSubjects() async {
    loader(true);

    try {
      final response = await http.get(
        Uri.parse('${ApiService().baseUrl}/subjects/?api_key=Cb26D'),
        headers: ApiService().headers,
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        final subjectModel = subjectModelFromJson(response.body);
        subjectList.clear();
        subjectList.addAll(subjectModel.subjects);
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

  Future<void> getSubjectDetails(id) async {
    loader(true);

    try {
      final response = await http.get(
        Uri.parse('${ApiService().baseUrl}/subjects/$id?api_key=Cb26D'),
        headers: ApiService().headers,
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        final subjectDetailsModel = subjectDetailsModelFromJson(response.body);
        subjectDetails = subjectDetailsModel;
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
}
