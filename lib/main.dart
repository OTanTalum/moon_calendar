import 'dart:developer';

import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CrCalendarController calendarController =
      CrCalendarController(events: []);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white(),
      appBar: AppBar(
        backgroundColor: MyColors.accent(),
        title: const Text("Calendar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80 * 5,
              child: CrCalendar(
                  firstDayOfWeek: WeekDay.monday,
                  eventsTopPadding: 35,
                  initialDate: DateTime.now(),
                  maxEventLines: 1,
                  controller: calendarController,
                  forceSixWeek: true,
                  onDayClicked:
                      (List<CalendarEventModel> events, DateTime day) =>
                          createEvent(day),
                  minDate: DateTime.now().subtract(const Duration(days: 1000)),
                  maxDate: DateTime.now().add(const Duration(days: 180)),
                  dayItemBuilder: (day) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: MyColors.second(),
                        ),
                        child: Center(
                          child: Text(
                            day.dayNumber.toString(),
                            style: TextStyle(
                                color: MyColors.black(), fontSize: 14),
                          ),
                        ),
                      ),
                  eventBuilder: (EventProperties eventP) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: MyColors.accent(),
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            eventP.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }

  createEvent(DateTime day) {
    CalendarEventModel newEvent = CalendarEventModel(
        name: "newEvent", begin: day, end: day.add(Duration(days: 7)));
    calendarController.addEvent(newEvent);
    setState(() {
      log("newEvent");
    });
  }
}

class MyColors {
  static Color black() => const Color(0xff100F0F);
  static Color accent() => const Color(0xff0F3D3E);
  static Color second() => const Color(0xffE2DCC8);
  static Color white() => const Color(0xffF1F1F1);
}
