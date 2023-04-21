import 'package:calender_app/app/data/database/event_dao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEventController extends GetxController {
  List<String> repeatValues = [
    "Once",
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
  ];
  var repeatValueSelected = "Once".obs;
  var eventNameFieldController = TextEditingController();
  var startDateFieldController = TextEditingController();
  var endDateFieldController = TextEditingController();
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var repeatValue = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  selectStartDate() async {
    var selectedDate = await selectDate(startDate.value);
    startDate.value = selectedDate!;
    startDateFieldController.text =
        DateFormat('dd-MM-yyyy').format(startDate.value);
  }

  selectEndDate() async {
    var selectedDate = await selectDate(endDate.value);
    endDate.value = selectedDate!;
    endDateFieldController.text =
        DateFormat('dd-MM-yyyy').format(endDate.value);
    // endDateFieldController.text = endDate.value.toString();
  }

  Future<DateTime?> selectDate(DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    // if (picked != null && picked != _selectedDate) {

    //     _selectedDate = picked;

    // }

    return picked;
  }

  validate() async {
    if (eventNameFieldController.text == "" ||
        startDateFieldController.text == "" ||
        endDateFieldController.text == "") {
      errorSnackBar("Please enter the corresponding values");
    } else {
      await EventDAO.saveToDB(
        
          eventNameFieldController.text,
          startDate.value,
          endDate.value,
          repeatValueSelected.value.toString(),
          repeatValue.toString());
      Get.back();
    }
  }

  errorSnackBar(String error) {
    return Get.snackbar(
      "Error",
      error,
      backgroundColor: Colors.blueGrey,
      colorText: Colors.white,
    );
  }

  repeatSelected(value) {
    repeatValueSelected.value = value.toString();
    if (repeatValueSelected.value == "Yearly") {
      repeatValue.value = DateFormat('dd-MM').format(startDate.value);
    } else if (repeatValueSelected.value == "Monthly") {
      repeatValue.value = DateFormat('dd').format(startDate.value);
    } else if (repeatValueSelected.value == "Weekly") {
      repeatValue.value = DateFormat('EEEE').format(startDate.value);
    } else if (repeatValueSelected.value == "Daily") {
      repeatValue.value = "true";
    } else {

    }
  }
}
