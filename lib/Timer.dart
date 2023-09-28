import 'package:flutter/material.dart';
import 'package:morgan/Controller.dart';

class Timer {
    String? device_ip = null;
    String? device_id = null;
    String? id = null;
    String? number = null;

    String hour = "";
    String minute = "";

    String day = "";
    String month = "";
    String year = "";

    String command = "";
    String weekdays = "";
    String duration = "";

    String repeat = "";
    String control = "";
    String count = "";

    Timer(this.hour, this.minute,
            this.month, this.day, this.year,
            this.command, this.weekdays, this.duration,
            this.repeat, this.control, this.count, this.device_id, this.id, this.number);

    Timer.parse(Controller controller, String input) {
        //Event 1 at 1073496848	11:30	6/19/2022	command: 64, weekdays: 255, duration: 10, repeat: 0, control: 0, count: 24

        if (input.contains("Empty Event queue")) {
            device_id = "NULL";
            return;
        }

        device_ip = controller.ip;
        device_id = controller.serial;

        String temp = input;

        //print("input: $temp");

        number = temp.substring(6, temp.indexOf(" ", 6));
        temp = temp.substring(temp.indexOf("at") + 1);

        id = temp.substring(2, temp.indexOf("\t"));
        temp = temp.substring(temp.indexOf("\t") + 1);

        hour = temp.substring(0, temp.indexOf(":"));
        temp = temp.substring(temp.indexOf(":") + 1);

        minute = temp.substring(0, temp.indexOf("\t"));
        temp = temp.substring(temp.indexOf("\t") + 1);

        month = temp.substring(0, temp.indexOf("/"));
        temp = temp.substring(temp.indexOf("/") + 1);

        day = temp.substring(0, temp.indexOf("/"));
        temp = temp.substring(temp.indexOf("/") + 1);

        year = temp.substring(0, temp.indexOf("\t"));
        temp = temp.substring(temp.indexOf("command:") + 1);

        //Event 1 at 1073496848	11:30	6/19/2022	command: 64, weekdays: 255, duration: 10, repeat: 0, control: 0, count: 24

        command = temp.substring(8, temp.indexOf(","));
        temp = temp.substring(temp.indexOf("weekdays:") + 1);

        weekdays = temp.substring(9, temp.indexOf(","));
        temp = temp.substring(temp.indexOf("duration:") + 1);

        duration = temp.substring(9, temp.indexOf(","));
        temp = temp.substring(temp.indexOf("repeat:") + 1);

        repeat = temp.substring(7, temp.indexOf(","));
        temp = temp.substring(temp.indexOf("control:") + 1);

        control = temp.substring(8, temp.indexOf(","));
        temp = temp.substring(temp.indexOf("count:") + 1);

        count = temp.substring(6);
        //temp = temp.substring(temp.indexOf("\n") + 1);

        print("device_ip: ${device_ip}, device_id: \"${device_id}\", id: \"$id\", number: \"$number\", hour: \"$hour\", minute: \"$minute\"");
        print("month: \"$month\", day: \"$day\", year: \"$year\", command: \"$command\", weekdays: \"$weekdays\", duration: \"$duration\"");
        print("repeat: \"$repeat\", control: \"$control\", count: \"$count\"");
    }

    Column get get_widget {
        return Column(
            children: [
                Text("$hour:$minute"),
                Text("$day/$month/$year"),
                Row(
                    children: [
                        Text("command"),
                        Text("$command"),
                    ],
                ),
                Row(
                    children: [
                        Text("weekdays"),
                        Text("$weekdays"),
                    ],
                ),
                Row(
                    children: [
                        Text("duration"),
                        Text("$duration"),
                    ],
                ),
                Row(
                    children: [
                        Text("repeat"),
                        Text("$repeat"),
                    ],
                ),
                Row(
                    children: [
                        Text("control"),
                        Text("$control"),
                    ],
                ),
                Row(
                    children: [
                        Text("count"),
                        Text("$count"),
                    ],
                ),
            ],
        );
    }
}

class Timers with ChangeNotifier {
    List<Timer> timers = [];

    int get count => timers.length;

    List<Column> get get_timers {
        List<Column> temp = [];

        for (int i = 0; i < timers.length; i++) {
            Column col = timers[i].get_widget;
            temp.add(
                Column(
                    children: [
                        col,
                        TextButton(
                            child: Text("X"),
                            onPressed: () {
                                print("id: ${timers[i].device_id} ${timers[i].id}");
                            },
                        )
                    ],
                ),
            );
        }

        return temp;
    }

    void add_timers(List<Timer> new_timers) {
        bool add;

        for (var i in new_timers) {
            add = true;

            for (var j in timers) {
                if (i.device_id == j.device_id && i.id == j.id) {
                    add = false;
                    break;
                }
            }

            if (add) {
                //print("adding controller");
                timers.add(i);
            }
        }

        notifyListeners();
    }
}
