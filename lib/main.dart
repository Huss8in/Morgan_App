import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:morgan/helpers.dart';

import 'package:morgan/Controller.dart';
import 'package:morgan/Timer.dart';

void main() {
  //List

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Controllers()),
      ChangeNotifierProvider(create: (_) => Timers()),
    ], child: const Morgan()),
  );
  //runApp(Morgan());
}

class Morgan extends StatelessWidget {
  const Morgan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    search_for_controllers(context);

    return MaterialApp(
      initialRoute: "/",
      home: Builder(
        builder: (context) => Scaffold(
          //--------------------- APP BAR ------------------//
          appBar: AppBar(
            title: const Text(
              'Morden',
              style: TextStyle(
                color: Colors.white, // Set the text color to white
                fontSize: 20, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make the title bold
              ),
            ),
            centerTitle: true, // Center the title
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            elevation: 0, // Remove the shadow from the AppBar
          ),
          //-----------------------Drawer-------------------------//
          drawer: Drawer(
            child: Container(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    accountName:
                        Text("Willian"), // Replace with the user's name
                    accountEmail: Text(
                        "Willian.Morgan@gmail.com"), // Replace with the user's email
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/logo.jpeg'), // Replace with the user's profile picture
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.green
                        ], // Replace with the desired gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      // Add the code to navigate to the settings screen here
                      Navigator.pop(
                          context); // Close the drawer after navigating
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      // Add the code to handle the logout functionality here
                      Navigator.pop(
                          context); // Close the drawer after performing logout
                    },
                  ),
                ],
              ),
            ),
          ),
          //-----------------------body-------------------------//
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.green], // Adjust gradient colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: PageView(
                      children: [
                        Image.asset(
                            'assets/logo.jpeg'), // Change 'image1.png' to your image path
                        Image.asset('assets/Garden-Irrigation.jpg'),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[200],
                          padding: EdgeInsets.all(20),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Manual(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.build,
                              color: Colors.green[700],
                            ),
                            SizedBox(
                                width:
                                    10), // Adding some spacing between the icon and text
                            Text(
                              "Manual",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 5), // Adding some spacing between the buttons
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[200],
                          padding: EdgeInsets.all(20),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TimedOrders(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_alarm,
                              color: Colors.green[700],
                            ),
                            SizedBox(
                                width:
                                    10), // Adding some spacing between the icon and text
                            Text(
                              "Timed Orders",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 5), // Adding some spacing between the buttons
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[200],
                          padding: EdgeInsets.all(20),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Groups(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.group,
                              color: Colors.green[700],
                            ),
                            SizedBox(
                                width:
                                    10), // Adding some spacing between the icon and text
                            Text(
                              "Groups",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          
        ),
      ),
    );
  }
}

class Manual extends StatelessWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MANUAL',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
            fontSize: 20, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Make the title bold
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0, // Remove the shadow from the AppBar
      ),
      body: Center(
        child: ListView(children: context.watch<Controllers>().get_controllers),
      ),
    );
  }
}

class TimedOrders extends StatelessWidget {
  const TimedOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Timed Orders",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TimerCreate(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(children: context.watch<Timers>().get_timers),
      ),
    );
  }
}

class NewTimerAlert extends StatelessWidget {
  const NewTimerAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text_hour = "";
    String text_minute = "";

    String text_day = "";
    String text_month = "";
    String text_year = "";

    String text_command = "";
    String text_weekdays = "";
    String text_duration = "";

    String text_repeat = "";
    String text_control = "";
    String text_count = "";

    TextField input_hour = TextField(
      onChanged: (newText) {
        text_hour = newText;
      },
    );
    TextField input_minute = TextField(
      onChanged: (newText) {
        text_minute = newText;
      },
    );

    TextField input_day = TextField(
      onChanged: (newText) {
        text_day = newText;
      },
    );
    TextField input_month = TextField(
      onChanged: (newText) {
        text_month = newText;
      },
    );
    TextField input_year = TextField(
      onChanged: (newText) {
        text_year = newText;
      },
    );

    TextField input_command = TextField(
      onChanged: (newText) {
        text_command = newText;
      },
    );
    TextField input_weekdays = TextField(
      onChanged: (newText) {
        text_weekdays = newText;
      },
    );
    TextField input_duration = TextField(
      onChanged: (newText) {
        text_duration = newText;
      },
    );

    TextField input_repeat = TextField(
      onChanged: (newText) {
        text_repeat = newText;
      },
    );
    TextField input_control = TextField(
      onChanged: (newText) {
        text_control = newText;
      },
    );
    TextField input_count = TextField(
      onChanged: (newText) {
        text_count = newText;
      },
    );
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("Hour"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter hour",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text("Minute"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter minute",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("Day"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter day",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text("Month"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter month",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("Year"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Year",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text("Command"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Command",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("Weekdays"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Weekdays",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text("Duration"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Duration",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("Repeat"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Repeat",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text("Control"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Control",
                      ),
                      // You can add your logic to capture input here
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Add similar rows for other inputs

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Handle the submit button logic here
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                primary:
                    Colors.blue, // Change to your preferred background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white, // Change to your preferred text color
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerCreate extends StatelessWidget {
  const TimerCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Timer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: const NewTimerAlert(),
    );
  }
}

class ControllerChoose extends StatelessWidget {
  const ControllerChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Controller> temp = context.watch<Controllers>().contorllers;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Choose Controller",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            for (int i = 0; i < temp.length; i++)
              GestureDetector(
                child: Text(temp[i].name),
                onTap: !temp[i].connected
                    ? null
                    : () {
                        Navigator.pop(context, temp[i]);
                      },
              ),
          ],
        ));
  }
}

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Groups",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // add your function her
            },
          ),
        ],
      ),
    );
  }
}
