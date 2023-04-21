import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_event_controller.dart';

class AddEventView extends GetView<AddEventController> {
  const AddEventView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Event Name",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _eventNameFiled(),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Start Date",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _startDateFiled(),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "End Date",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _endDateFiled(),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Repeat",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _repeatDropDown(),
          const SizedBox(
            height: 50,
          ),
          _saveButton(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _eventNameFiled() {
    return TextField(
      controller: controller.eventNameFieldController,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(left: 10, right: 20, top: 11),
        counterText: "",
        hintText: "Event Name",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
      ),
      onChanged: (String value) {},
    );
  }

  Widget _startDateFiled() {
    return GestureDetector(
      onTap: () {
        controller.selectStartDate();
      },
      child: TextField(
        enabled: false,
        controller: controller.startDateFieldController,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 5, right: 20, top: 15),
          counterText: "",
          hintText: "Start Date",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          suffixIcon: Icon(
            Icons.calendar_month,
            size: 18,
            color: Colors.black,
          ),
        ),
        onChanged: (String value) {},
      ),
    );
  }

  Widget _endDateFiled() {
    return GestureDetector(
      onTap: () {
        controller.selectEndDate();
      },
      child: TextField(
        enabled: false,
        controller: controller.endDateFieldController,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 5, right: 20, top: 15),
          counterText: "",
          hintText: "End Date",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          suffixIcon: Icon(
            Icons.calendar_month,
            size: 18,
            color: Colors.black,
          ),
        ),
        onChanged: (String value) {},
        onTap: () {},
      ),
    );
  }

  Widget _repeatDropDown() {
    return Obx(() {
      return DropdownButton<String>(
        value: controller.repeatValueSelected.value,
        onChanged: (newValue) {
         controller.repeatSelected(newValue);
        },
        items: controller.repeatValues.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(width: Get.width * .8, child: Text(value)),
          );
        }).toList(),
      );
    });
  }

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: SizedBox(
        height: 46,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            controller.validate();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
