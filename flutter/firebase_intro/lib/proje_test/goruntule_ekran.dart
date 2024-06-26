import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:firebase_intro/proje_test/event_model.dart';

class TakvimEkrani extends StatefulWidget {
  // final EventModel event;

  const TakvimEkrani({
    super.key,
  });

  @override
  State<TakvimEkrani> createState() => _TakvimEkraniState();
}

class _TakvimEkraniState extends State<TakvimEkrani> {
  List<EventModel> events = [];
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<EventModel> _getEventsfromDay(DateTime date) {
    return events.where((event) => isSameDay(event.eventDate, date)).toList();
  }

  @override
  void initState() {
    fetchEventsFromFirestore().then((events) {
      setState(() {
        this.events = events;
      });
    });
    super.initState();
  }

  Future<List<EventModel>> fetchEventsFromFirestore() async {
    // late List<CalendarModel> events = [];
    // final user = firebaseAuthInstance.currentUser;

    var querySnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    for (var doc in querySnapshot.docs) {
      events.add(EventModel.fromMap(doc.data()));
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Takvim ekranı'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.utc(2024, 12, 31));

          EventModel deneme = EventModel(
            id: 'id',
            title: 'deneme',
            description: 'deneme',
            eventDate: pickedDate!,
          );

          await FirebaseFirestore.instance
              .collection('events')
              .add(deneme.toMap());
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(2020),
              lastDay: DateTime(2025),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
              daysOfWeekHeight: 25,
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
              eventLoader: _getEventsfromDay,
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            //  event detayları
            SingleChildScrollView(
              child: Column(
                children: _getEventsfromDay(selectedDay)
                    .map(
                      (EventModel event) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Eğitmen: ${event.id}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      event.eventDate.day.toString(),
                                      // '${event.eventDate.day.toString().padLeft(2, "0")}.${event.date.month.toString().padLeft(2, "0")}.${event.date.year}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      event.eventDate.toString(),
                                      //'${event.eventDate.toString().padLeft(2, "0")}:${event.minute.toString().padLeft(2, "0")}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
