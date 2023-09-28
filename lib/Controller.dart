import 'package:flutter/material.dart';
import 'package:morgan/helpers.dart';

/*
#define COMPILATION_SETTING_BOARD_TYPE_NULL             0
#define COMPILATION_SETTING_BOARD_TYPE_ESP32            1
#define COMPILATION_SETTING_BOARD_TYPE_ESP8266          2

#define COMPILATION_SETTING_CONTROL_TYPE_NULL           0
#define COMPILATION_SETTING_CONTROL_TYPE_LATCH          1
#define COMPILATION_SETTING_CONTROL_TYPE_MOTOR          2

#define COMPILATION_SETTING_ROLE_TYPE_NULL              0
#define COMPILATION_SETTING_ROLE_TYPE_MASTER            1
#define COMPILATION_SETTING_ROLE_TYPE_SLAVE             2
#define COMPILATION_SETTING_ROLE_TYPE_ALONE             3

#define COMPILATION_SETTING_CLEAR_DATA_NULL             0
#define COMPILATION_SETTING_CLEAR_DATA_NO               1
#define COMPILATION_SETTING_CLEAR_DATA_YES              2

#define COMPILATION_SETTING_BUILD_TYPE_NULL             0
#define COMPILATION_SETTING_BUILD_TYPE_DEBUG            1
#define COMPILATION_SETTING_BUILD_TYPE_RELEASE          2

#define COMPILATION_SETTING_CONNECTION_TYPE_NULL        0
#define COMPILATION_SETTING_CONNECTION_TYPE_MQTT        1
#define COMPILATION_SETTING_CONNECTION_TYPE_HTTP        2
*/

class Controller {
/*
Version: 1.6.1
Serial: 1151
Type: 2
Time: 7845
Name: CONTROLLER #1147
motor: Java
bssid: Java
time: GMT+2
States: 00000011
end
*/

  String ip = "";
  String version = "";
  String serial = "";
  int type = -1;
  int time = -1;
  String name = "";
  String bssid = "";
  String time_zone = "";
  List<bool> states = [];
  List<String> switchNames = [];
  bool connected = false;
  String state = "";

  BoxDecoration get_decoration() {
    double borderRadiusValue = 50.0;
    if (connected == false) {
      return BoxDecoration(
        color: Colors.red,
      );
    } else if (connected == true) {
      return BoxDecoration(
        color: Colors.green,
      );
    } else {
      return BoxDecoration(
        color: Color.fromRGBO(128, 128, 128, 100),
      );
    }
  }

  Column get get_widget {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: get_decoration(),
          child: Center(
            child: Text(
              connected ? 'ON' : (connected == null ? 'Sleep' : 'OFF'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
            height: 10), // Add some spacing between the container and the rows
        Row(
          children: [
            const Text("IP:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.left),
            SizedBox(width: 10), // Add space from the left side of the text
            Text("$ip", style: TextStyle(fontSize: 18)),
          ],
        ),
        SizedBox(height: 5), // Add a bit more spacing between the rows
        Row(
          children: [
            const Text("Version:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.left),
            SizedBox(width: 10), // Add space from the left side of the text
            Text("$version", style: TextStyle(fontSize: 18)),
          ],
        ),
        Row(
          children: [
            const Text("Serial:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.left),
            SizedBox(width: 10), // Add space from the left side of the text
            Text("$serial", style: TextStyle(fontSize: 18)),
          ],
        ),
        Row(
          children: [
            const Text("Name:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.left),
            SizedBox(width: 10), // Add space from the left side of the text
            Text("$name", style: TextStyle(fontSize: 18)),
          ],
        ),
        Row(
          children: [
            const Text("Bssid:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.left),
            SizedBox(width: 10), // Add space from the left side of the text
            Text("$bssid", style: TextStyle(fontSize: 18)),
          ],
        ),
      ],
    );
  }

  //void change_state(int number, bool new_state) {
  //print(new_state);
  //states[number] = new_state;
  //}

  void change_state(String new_state) {
    int offset1 = 0;
    int offset2 = 0;

    if (new_state.contains("latch")) {
      offset1 = 6;
      offset2 = 1;
    }

    // LED 1 at pin 14 set to 1
    int led_begin = 4 + offset1;
    int led_end = new_state.indexOf(" ", led_begin);

    String led = new_state.substring(led_begin, led_end);

    int pin_begin = new_state.indexOf("pin") + 4 + offset2;
    int pin_end = new_state.indexOf(" ", pin_begin);

    String pin = new_state.substring(pin_begin, pin_end);

    int state_begin = new_state.indexOf("set to") + 7;
    int state_end = new_state.indexOf("\n", state_begin);

    String state_state = new_state.substring(state_begin, state_end);

    print("new_state: $new_state");
    if (offset1 != 0) {
      int pin2_begin = new_state.indexOf("and") + 4;
      int pin2_end = new_state.indexOf(" ", pin2_begin);

      String pin2 = new_state.substring(pin2_begin, pin2_end);

      print(
          "latch led: \"$led\", pins: \"$pin\" and \"$pin2\", state: \"$state_state\"");
    } else {
      print("led: \"$led\", pin: \"$pin\", state: \"$state_state\"");
    }

    int led_num = int.parse(led);
    int state_bool = int.parse(state_state);

    states[led_num] = state_bool == 1 ? true : false;
  }

  void change_states(String new_states) {
    try {
      String temp_state = new_states;
      int number_of_states = temp_state.length;

      print("states: $temp_state, number: $number_of_states");

      for (int i = 0; i < number_of_states; i++) {
        bool temp_bool =
            int.parse(temp_state.substring(0, 1)) == 1 ? true : false;
        states[i] = temp_bool;
        temp_state = temp_state.substring(1);
        print("temp: $temp_bool");
      }
    } catch (e) {
      print("could not convert to int: $e");
    }
  }

  Controller(String input) {
    String temp = input;

    ip = temp.substring(0, temp.indexOf("\n"));
    temp = temp.substring(temp.indexOf("\n") + 1);

    version = temp.substring(9, temp.indexOf("\n"));
    temp = temp.substring(temp.indexOf("\n") + 1);

    serial = temp.substring(8, temp.indexOf("\n"));
    temp = temp.substring(temp.indexOf("\n") + 1);

    try {
      type = int.parse(temp.substring(6, temp.indexOf("\n")));
    } catch (e) {
      print("could not convert to int: $e");
    }
    temp = temp.substring(temp.indexOf("\n") + 1);

    try {
      time = int.parse(temp.substring(6, temp.indexOf("\n")));
    } catch (e) {
      print("could not convert to int: $e");
    }
    temp = temp.substring(temp.indexOf("\n") + 1);

    name = temp.substring(6, temp.indexOf("\n"));
    temp = temp.substring(temp.indexOf("\n") + 1);

    bssid = temp.substring(7, temp.indexOf("\n"));
    temp = temp.substring(temp.indexOf("\n") + 1);

    time_zone = temp.substring(6, temp.indexOf("\n"));
    temp = temp.substring(temp.indexOf("\n") + 1);

    try {
      state = temp.substring(8, temp.indexOf("\n"));

      String temp_state = state;
      int number_of_states = temp_state.length;

      for (int i = 0; i < number_of_states; i++) {
        states.add(int.parse(temp_state.substring(0, 1)) == 1 ? true : false);
        temp_state = temp_state.substring(1);

        switchNames.add("Switch #${i + 1}");
      }
    } catch (e) {
      print("could not convert to int: $e");
    }
    temp = temp.substring(temp.indexOf("\n") + 1);

    /*
        print('''
            ip: "$ip"
            version: "$version"
            serial: "$serial"
            type: "$type"
            time: "$time"
            name: "$name"
            bssid: "$bssid"
            time_zone: "$time_zone"
            state: "$state"
        ''');
        */
  }
}

class Controllers with ChangeNotifier {
  List<Controller> contorllers = [];

  int get count => contorllers.length;

  //bool switch_value(int number) {
  //return contorllers[number].current_state;
  //}

  //void set_switch_value(bool value) {
  //contorllers[0].current_state = value;
  //}

  List<Column> get get_controllers {
    List<Column> temp = [];

    for (int i = 0; i < contorllers.length; i++) {
      Column col = contorllers[i].get_widget;
      temp.add(Column(
        children: [
          col,
          for (int j = 0; j < contorllers[i].states.length; j++)
            Row(
              children: [
                Text("${contorllers[i].switchNames[j]}"),
                Switch(
                  value: contorllers[i].states[j],
                  onChanged: !contorllers[i].connected
                      ? null
                      : (bool state) async {
                          int command = j;

                          if (!contorllers[i].states[j]) {
                            command |= (1 << 6);
                          } else {
                            command &= 127;
                          }

                          print(
                              "state: $state, other state: ${contorllers[i].states[j]}, command: $command");

                          String result =
                              await change_state(contorllers[i].ip, command);

                          //print("Result: $result");

                          if (result.indexOf("set to") == -1) {
                            // TODO: toast
                          } else {
                            //contorllers[i].change_state(j, state);
                            contorllers[i].change_state(result);
                            notifyListeners();
                          }
                        },
                ),
              ],
            ),
          // ----------------------------Delete controller Button----------------------------//
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius:
                  BorderRadius.circular(5), // Adding a border radius of 10
            ),
            child: TextButton(
              onPressed: () {
                // Your button's onPressed function
                contorllers.removeAt(i);
                notifyListeners();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Delete Controller",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.delete, // Using the bin icon
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          // ----------------------------=========----------------------------//
        ],
      ));
    }

    return temp;
    //List<Text> temp = [];

    //for (var i in contorllers)
    //temp.add(Text(i));

    //return temp;
  }

  /*
    List<Column> get get_controllers_summary {
        List<Column> temp = [];

        for (int i = 0; i < contorllers.length; i++) {
             temp.add(contorllers[i]);
        }

        return temp;
    }
    */

  void add_controller(String input) {
    Controller new_conroller = Controller(input);

    for (int i = 0; i < contorllers.length; i++) {
      if (new_conroller.serial == contorllers[i].serial) {
        return;
      }
    }

    contorllers.add(new_conroller);
    notifyListeners();
  }

  void add_controllers(List<Controller> new_conrollers) {
    for (int i = 0; i < contorllers.length; i++) {
      contorllers[i].connected = false;
    }

    //print("new Controllers:\n$new_conrollers");

    bool add;

    for (int i = 0; i < new_conrollers.length; i++) {
      Controller temp = new_conrollers[i];

      temp.connected = true;
      add = true;

      for (int j = 0; j < contorllers.length; j++) {
        if (temp.serial == contorllers[j].serial) {
          //print("found controller");
          contorllers[j].connected = true;
          contorllers[j].change_states(temp.state);
          add = false;
          break;
        }
      }

      if (add) {
        //print("adding controller");
        contorllers.add(temp);
      }
    }

    notifyListeners();
  }
}
