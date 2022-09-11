import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi/components/order_tile.dart';
import 'package:taxi/repositories/api_user.dart';

import 'package:taxi/models/order.dart';

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
    //inProgress = userRepo.getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              orders = userRepo.getOrders();
              //        inProgress = userRepo.getUserOrders();
              setState(() {

              });
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
              DateTime cur = DateTime.fromMicrosecondsSinceEpoch(0);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Order order = snapshot.data!.elementAt(index);
                  List<Widget> list = [];
                  if (order.timeStart.day < cur.day) {
                    cur = order.timeStart;
                    list.add(
                      Text(
                        DateFormat('dd, MMMM, EEEE', 'ru').format(cur),
                        style: const TextStyle(
                          height: 30,
                          color: CupertinoColors.inactiveGray,
                        ),
                      ),
                    );
                  }
                  list.add(OrderTile(order: order));
                  return Column(
                    children: list,
                  );
                },
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
