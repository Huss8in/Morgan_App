import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:morgan/http.dart';

import 'package:morgan/Controller.dart';
import 'package:morgan/Timer.dart';

Future<String?> get_self_ip() async {
    //NetworkInterface.list().
    //String ip = await Wifi.ip;

    if (Platform.isAndroid || Platform.isIOS) {
        String? ip = await NetworkInfo().getWifiIP();
        return ip;
    } else {
        return "192.168.1.2";
    }
}

Future find_timers(BuildContext context, Controller controller) async {
    // curl --X POST 192.168.1.11/painlessMesh/to/ -d "plain=listEvents/0/25"
    bool more = true;
    String temp = "EMPTY";
    int number = 0;

    List<Timer> results = [];

    while (more) {
        String events = await send_command(controller.ip, "/painlessMesh/to/", "plain=listEvents/$number/25");

        for (int i = 0; i < 4; i++) {
            try {
                temp = events.substring(0, events.indexOf("\n"));

                events = events.substring(events.indexOf("\n") + 1);
                Timer timer = Timer.parse(controller, temp);

                if (timer.device_id != "NULL") {
                    results.add(timer);
                }
            } catch (e) {
                Timer timer = Timer.parse(controller, temp);

                if (timer.device_id != "NULL") {
                    results.add(timer);
                }

                more = false;
                break;
            }
        }

        number += 4;
    }

    if (context.mounted) {
        context.read<Timers>().add_timers(results);
    }
}

Future search_for_controllers(BuildContext context) async {
    String? ip = await get_self_ip();

    if (ip == null) {
        print("could not find ip address");
        return 0;
    }

    print('IP: $ip');

    var ip_address = ip.substring(0, ip.lastIndexOf('.'));

    while (true) {
        print("running");

        List<String> ips = [];
        List<Future<String?>> requests = [];

        for (int i = 1; i <= 255; i++) {
            String temp_ip = ip_address + "." + i.toString();

            ips.add(temp_ip);
            requests.add(discover(temp_ip));
        }

        List<String?> info = (await Future.wait(requests)).toList();
        List<Controller> results = [];

        if (context.mounted) {
            for (var i in info) {
                if (i != null) {
                    Controller temp = Controller(i);
                    results.add(temp);
                    find_timers(context, temp);
                }
            }

            context.read<Controllers>().add_controllers(results);
        }
        //print("found device at ${ips[i]}");

        await Future.delayed(const Duration(seconds: 15));
    }
}

Future create_timer(BuildContext context, Controller controller, Timer timer) async {
    // plain=newEvent/11:30:6:19:2022:64:255:10:0:0:24
    String temp = "plain=newEvent/${timer.hour}:${timer.minute}:${timer.month}:${timer.day}:${timer.year}:${timer.command}:${timer.weekdays}:10:0:0:24";
    print(temp);
    send_command(controller.ip, "/painlessMesh/to/", temp);
}

Future change_state(String ip, int command) async {
    return send_command(ip, "/painlessMesh/to/", "plain=command/$command/1/25");
}
