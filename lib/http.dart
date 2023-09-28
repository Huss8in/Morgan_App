import 'dart:async';

import 'package:http/http.dart' as http;

Future<String> send_command(String ip, String url, String body) async {
  // curl --X POST 192.168.1.13/painlessMesh/to/ -d "plain=/getInfo/325/25"
  //send_command("192.168.1.13", "/painlessMesh/to/", "plain=/getInfo/325/325");

  //var url = Uri.https('127.0.0.1', '/', {'q': '{http}'});
  var request = Uri.http(ip, url);

  // Await the http get response, then decode the json-formatted response.
  try {
    var response = await http.post(request, body: body);

    //print('Request status: ${response.statusCode}.');
    //print('Response: ${response.body}');

    return response.body;
  } catch (e) {
    //print('Failed to connect to host with IP: $ip, $url with error: $e');

    return e.toString();
  }

  //if (response.statusCode == 200) {
  //print('Response: ${response.body}');
  //} else {
  //}
}

Future<String?> discover(String ip) async {
  var request = Uri.http(ip, "/painlessMesh/to/");

  try {
    var response = await http
        .post(request, body: "plain=getInfo/325/25")
        .timeout(const Duration(seconds: 7));

    //print('Request status: ${response.statusCode}.');
    //print('Response: ${response.body}');

    //print("ip: $ip, response: ${response.body}");

    if (response.body.contains("Serial")) {
      print(ip + "\n" + response.body);
      return ip + "\n" + response.body;
    } else {
      return null;
//       return """192.168.1.8
// Version: 1.6.1
// Serial: 1217
// Type: 1
// Time: 7812
// Name: CONTROLLER #1200
// bssid: Java
// time: GMT+2
// States: 0000
// end""";
    }
  } catch (e) {
    // print('Failed to discover host with IP: $ip with error: $e');
print('catch');
    return """192.168.1.8
Version: 1.6.1
Serial: 1217
Type: 1
Time: 7812
Name: CONTROLLER #1200
bssid: Java
time: GMT+2
States: 0000
end""";
  }
}

// return await flutterCompute(run_discover, ip);

//@pragma('vm:entry-point')
//Future run_discover(String ip) async {
//}