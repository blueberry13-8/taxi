import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi/components/order_tile.dart';
import 'package:taxi/models/order.dart';
import 'package:taxi/navigation/navigation_controller.dart';
import 'package:taxi/navigation/routes.dart';
import 'package:taxi/repositories/api_user.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late Future<List<Order>> currentOrders;
  UserRepo userRepo = UserRepo();

  @override
  void initState() {
    super.initState();
    currentOrders = userRepo.getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваши заявки'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Order>>(
          future: currentOrders,
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
                return (Column(
                  children: list,
                ));
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationController()
              .pushNamed(Routes.addOrderScreen)
              ?.then((value) => setState(() {}));
          // add new order
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
