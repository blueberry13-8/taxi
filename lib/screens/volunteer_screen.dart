import 'package:flutter/material.dart';

class VolunteerScreen extends StatefulWidget {
  const VolunteerScreen({Key? key}) : super(key: key);

  @override
  State<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const Center(child: Text('Current tasks'),),
        const Center(child: Text('All tasks'),),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.currency_bitcoin,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
