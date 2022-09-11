import 'package:flutter/material.dart';
import 'package:taxi/repositories/api_user.dart';

import '../models/order.dart';

class VolunteerScreen extends StatefulWidget {
  const VolunteerScreen({Key? key}) : super(key: key);

  @override
  State<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  int _selectedIndex = 0;
  late Future<List<Order>> orders;
  late Future<List<Order>> inProgress;
  UserRepo userRepo = UserRepo();

  @override
  void initState() {
    super.initState();
    orders = userRepo.getOrders();
    inProgress = userRepo.getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              orders = userRepo.getOrders();
              inProgress = userRepo.getUserOrders();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: [
        const Center(
          child: Text('Current tasks'),
        ),
        Center(
          child: FutureBuilder<List<Order>>(
            future: orders,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.hasError) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                itemBuilder: () {},
              );
            },
          ),
        ),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.now_widgets,
            ),
            label: 'Текущие заказы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: 'Все заказы',
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
