import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi/models/order.dart';
import 'package:taxi/repositories/api_user.dart';

import '../models/user.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<User> user;

  @override
  void initState() {
    UserRepo userRepo = UserRepo();
    user = userRepo.getUserByToken(widget.order.customerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Информация о поездке',
            style: TextStyle(
              fontSize: 25,
              height: 3,
            ),
          ),
          Text(
              'Откуда: ${widget.order.origin},\nВремя: ${DateFormat('dd MMMM, hh:mm').format(widget.order.timeStart)}'),
          Text(
              'Куда: ${widget.order.destination}, \nВремя ${DateFormat('dd MMMM, hh:mm').format(widget.order.timeTo)}'),
          Text('Комментарий к поездке: ${widget.order.description ?? ''}'),
          FutureBuilder<User>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    'Пассажир: ${snapshot.data!.fullName}, \nНомер телефона: ${snapshot.data!.phoneNumber}');
              } else {
                return const Text('Пассажир: ~, \nНомер телефона: ~');
              }
            },
          ),
        ],
      ),
    );
  }
}
