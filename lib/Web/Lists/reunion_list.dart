import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../Core/Database/Controllers/reunion_controller.dart';
import '../../Core/Database/Models/reunion.dart';
import '../ControlPopUps/add_reunion_page.dart';
import '../ControlPopUps/modify_reunion_page.dart';
import '../Widgets/scrollable_widget.dart';

class ReunionListPage extends StatelessWidget {
  const ReunionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ReunionController.getReunions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ReunionList(
            data: snapshot.data as List<Reunion>,
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ReunionList extends StatefulWidget {
  const ReunionList({super.key, required this.data});

  final List<Reunion> data;

  @override
  State<ReunionList> createState() => _ReunionListState();
}

class _ReunionListState extends State<ReunionList> {
  Future<List<Appointment>> getAppointments(List<Reunion> data) async {
    List<Appointment> meetings = <Appointment>[];
    List<Reunion> reunions = await ReunionController.getReunionFuture();

    for (var r in reunions) {
      meetings.add(Appointment(
          id: r.uid,
          startTime: r.date,
          endTime: r.date.add(const Duration(hours: 2)),
          subject: r.subject,
          // ignore: use_build_context_synchronously
          color: Theme.of(context).primaryColor,
          isAllDay: false));
    }
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getAppointments(widget.data),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ScrollableWidget(
                    child: SfCalendar(
                      view: CalendarView.schedule,
                      dataSource:
                          ReunionDataSource(snapshot.data as List<Appointment>),
                      onTap: (details) {
                        // Appointment tappedAppointment;
                        // tappedAppointment = details.appointments![0];
                      },
                      appointmentBuilder: (BuildContext context,
                          CalendarAppointmentDetails details) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(details.appointments.first.subject),
                              ),
                              const Spacer(),
                              IconButton(
                                splashRadius: 10,
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  Reunion? reunion =
                                      await ReunionController.getReunion(
                                          details.appointments.first.id);
                                  Get.to(() => ModifyReunionPage(
                                        reunion: reunion!,
                                      ));
                                },
                              ),
                              IconButton(
                                splashRadius: 10,
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    ReunionController.deleteReunion(
                                        details.appointments.first.id);
                                  });
                                },
                              ),
                              const SizedBox(width: 25),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Row(
            children: _buildButtons(),
          )
        ],
      ),
    );
  }

  _buildButtons() {
    return [
      const Spacer(),
      ElevatedButton(
        onPressed: () => Get.to(() => const AddReunionPage()),
        child: const Text("Add Reunion"),
      ),
    ];
  }
}

class ReunionDataSource extends CalendarDataSource {
  ReunionDataSource(List<Appointment> source) {
    appointments = source;
  }
}
