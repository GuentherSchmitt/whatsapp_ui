import 'dart:math';

//import 'package:flutter/foundation.dart';   // was needed for kIsWeb
import 'package:flutter/material.dart';
import 'active_navigationbar_icon.dart';
import 'chats_widget.dart';
import 'contacts/contact_provider.dart';
import 'settings/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // AppBar background
          // foregroundColor: Colors.white, // Text & icon color
          // elevation: 4, // Shadow effect
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor:
              Colors.white, // Background color of BottomNavigationBar
          selectedItemColor: Colors.black, // Color for selected item
          unselectedItemColor: Colors.black, // Color for unselected items
          elevation: 10, // Shadow effect
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green, // Set your desired color
          foregroundColor: Colors.white, // Set your desired color
        ),

// Set background color here
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final contactProvider = ContactProvider();

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      ChatsWidget(
        contactProvider: contactProvider,
      ),
      const Center(child: Text('Updates Page', style: TextStyle(fontSize: 24))),
      const Center(
          child: Text('Communities Page', style: TextStyle(fontSize: 24))),
      const Center(child: Text('Calls Page', style: TextStyle(fontSize: 24))),
    ];

    var statusBarHeight = MediaQuery.of(context).padding.top;
    //print(statusBarHeight);

    return Scaffold(
      drawerScrimColor: Colors.transparent, // Remove the overlay effect
      appBar: AppBar(
        //foregroundColor: Colors.green,
        title: const Text(
          "WhatsApp",
          style: TextStyle(color: Colors.green),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.local_see_outlined,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              )),
          const EndDrawerButton()
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Height of the divider
          // child: Container(
          //   color: Colors.grey.shade300, // Color of the separator
          //   height: 0.5, // Thickness
          // ),
          child: Divider(height: 1, thickness: 1, color: Colors.grey),
        ),
      ),
      endDrawer: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin:
              EdgeInsets.only(top: kToolbarHeight + statusBarHeight, right: 4),
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(4, 4), // Shadow position
              ),
            ],
          ),
          child: Drawer(
            backgroundColor: Colors.transparent,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: const Text('New group'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  title: const Text('New broadcast'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  title: const Text('Linked devices'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  title: const Text('Starred messages'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  //leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       if (_selectedIndex == 0)
      //         const Text(
      //           'This is the Home Page',
      //         ),
      //       if (_selectedIndex == 1)
      //         const Text(
      //           'This is the Search Page',
      //         ),
      //       // Text(
      //       //   '$_selectedIndex',
      //       //   style: Theme.of(context).textTheme.headlineMedium,
      //       // ),
      //     ],
      //   ),
      // ),
      body: pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var random = Random();
          var contacts = contactProvider.contacts;
          var index = random.nextInt(contacts.length);
          //print("index is $index");
          setState(() {
            contacts[index].simulateNewMessage();
          });
        },
        tooltip: 'simulate new message',
        child: const Icon(Icons.add_box_rounded),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 34,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        items: const [
          BottomNavigationBarItem(
              activeIcon: ActiveNavigationBarIcon(iconData: Icons.chat_sharp),
              icon: Icon(Icons.chat_outlined),
              label: 'Chats'),
          BottomNavigationBarItem(
              activeIcon: ActiveNavigationBarIcon(iconData: Icons.update_sharp),
              icon: Icon(Icons.update_outlined),
              label: 'Updates'),
          BottomNavigationBarItem(
              activeIcon:
                  ActiveNavigationBarIcon(iconData: Icons.groups_3_sharp),
              icon: Icon(Icons.groups_3_outlined),
              label: 'Communities'),
          BottomNavigationBarItem(
              activeIcon: ActiveNavigationBarIcon(iconData: Icons.call_sharp),
              icon: Icon(Icons.call_outlined),
              label: 'Calls'),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
