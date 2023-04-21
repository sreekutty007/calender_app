import 'package:calender_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calender'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: _body()),
      floatingActionButton: _addEvent(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Obx(() {
          return TableCalendar(
            focusedDay: controller.today.value,
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.utc(2030, 12, 31),
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            availableGestures: AvailableGestures.all,
            onDaySelected: controller.onDaySelected,
            selectedDayPredicate: (day) =>
                isSameDay(day, controller.today.value),
            rangeSelectionMode: RangeSelectionMode.toggledOn,
          );
        }),
        const SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Events",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              _eventList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addEvent() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addEvent)?.then((value) {
          controller.fetchEvents();
        });
      },
      child: Container(
        // height: 50,
        // width: 100,
        // ignore: prefer_const_constructors
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "Add Event",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _eventList() {
    return Obx(() {
      return ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: controller.eventList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.black12)),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.eventList[index].eventName}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Start Date: ${DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(controller.eventList[index].startDate!))}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "End Date: ${DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(controller.eventList[index].endDate!))}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.delete(
                            controller.eventList[index].eventName.toString());
                      },
                      child: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
