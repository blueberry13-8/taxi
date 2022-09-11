import 'package:flutter/material.dart';
import 'package:taxi/components/order_tile.dart';

import 'package:taxi/models/order.dart';
import 'user_repo';

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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return OrderTile(order: currentOrders[index]);
          },
          itemCount: currentOrders.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // add new order
      }),
    );
  }
}
