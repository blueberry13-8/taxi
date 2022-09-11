import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi/components/app.dart';
import 'package:taxi/models/order.dart';
import 'package:taxi/navigation/navigation_controller.dart';
import 'package:taxi/repositories/api_user.dart';

import '../log/logger.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _commentController = TextEditingController();
  DateTime start = DateTime.now(), end = DateTime.now();
  late String token;
  UserRepo userRepo = UserRepo();

  @override
  Widget build(BuildContext context) {
    userRepo.getToken().then((value) => token = value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая заявка'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _fromController,
                  decoration: const InputDecoration(
                    hintText: 'Откуда забрать',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _toController,
                  decoration: const InputDecoration(
                    hintText: 'Куда довезти',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: 'Комментарий к заявке',
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(DateFormat('d, MMMM, hh:mm', 'ru').format(start)),
                subtitle: const Text('Дата и время подачи такси'),
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    start = DateTime(
                      start.year,
                      start.month,
                      start.day,
                      value!.hour,
                      value.minute,
                    );
                    setState(() {});
                  });
                },
              ),
              ListTile(
                title: Text(DateFormat('d, MMMM, hh:mm', 'ru').format(end)),
                subtitle: const Text('Время окончания поездки'),
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    end = DateTime(
                      end.year,
                      end.month,
                      end.day,
                      (value!.period == DayPeriod.am ? 0 : 12) + value.hour,
                      value.minute,
                    );
                    logger.info(end.hour);
                    setState(() {});
                  });
                },
              ),
              const Divider(
                thickness: 5,
              ),
              TextButton(
                onPressed: () {
                  userRepo.addOrder(
                    Order(
                      id: DateTime.now().millisecondsSinceEpoch,
                      origin: _fromController.text,
                      destination: _toController.text,
                      description: _commentController.text,
                      timeStart: start,
                      timeTo: end,
                      customerId: token,
                    ),
                  );
                  NavigationController().pop();
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
