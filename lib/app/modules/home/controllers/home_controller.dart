import 'package:calender_app/app/data/database/event_dao.dart';
import 'package:calender_app/app/data/database/event_db_model.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var today = DateTime.now().obs;
  var eventList = <EventDBModel>[].obs;
  List<EventDBModel> eventListDuplicate = [];

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  onDaySelected(DateTime day, DateTime focusedDay) async {
    today.value = day;
    await fetchEvents();
  }

  fetchEvents() async {
    // var response = await EventDAO.fetchAll();
    var response = await EventDAO.fetchEvent(
      today.value,
      DateFormat('dd-MM').format(today.value).toString(),
      DateFormat('dd').format(today.value).toString(),
      DateFormat('EEEE').format(today.value).toString(),
      "true",
    );
    eventList.value = response;
    // for(int i=0;i<eventListDuplicate.length;i++) {
    //   DateTime startDate = DateTime.parse(eventListDuplicate[i].startDate.toString());
    //   int start = startDate.compareTo(today as DateTime);
    //   if(start<0){
    //     print("before");
    //   } else if (start > 0) {
    //     print("after");
    //   } else {
    //     print("same");
    //   }
    // }
    // print("##############################");
    print(eventList.length);
  }

  delete(String eventName) async {
    var responce = await EventDAO.deleteRow(eventName);
    fetchEvents();
  }
}
