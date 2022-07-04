import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase/app/ui/routes/routes.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
//import 'package:flutter_meedu/ui.dart' as router; //pendiente

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    //HOME
    Text(
      'Welcome!',
      style: optionStyle,
    ),
    //
    Text(
      'Index 2',
      style: optionStyle,
    ),
    Text(
      'Index 3',
      style: optionStyle,
    ),
    Text(
      'Index 4',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3C6DA5),
        title: const Text("Welcome User"),
      ),

      //Drawer
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff3C6DA5),
            ),
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

          //Flutter - Firebase Authentication - 11 (Registro email/password - parte 5) <--- referencia video
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () {
              Get.find<AuthenticationRepository>().signOut();
              router.pushNamedAndRemoveUntil(Routes.LOGIN);
            },
            onLongPress: () {},
          ),
        ]),
      ),

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xff3C6DA5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch),
            label: 'Tab',
            backgroundColor: Color(0xff3C6DA5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.diamond),
            label: 'Tab',
            backgroundColor: Color(0xff3C6DA5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color(0xff3C6DA5),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
