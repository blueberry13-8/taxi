import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/log/logger.dart';
import 'package:taxi/navigation/navigation_controller.dart';
import 'package:taxi/repositories/api_user.dart';

import 'package:taxi/models/user.dart';
import 'package:taxi/navigation/routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late Future<SharedPreferences> userInstance;
  final _controllerPhone = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  UserRepo userRepo = UserRepo();
  Role role = Role.customer;

  @override
  void initState() {
    super.initState();
    userInstance = SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Регистрация',
              style: TextStyle(height: 20),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: _controllerPhone,
                decoration: const InputDecoration(
                  hintText: 'Телефон',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  hintText: 'ФИО',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Пароль',
                ),
              ),
            ),
            PopupMenuButton(
              initialValue: 1,
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: 0,
                  child: const Text(
                    'Водитель-волонтёр',
                  ),
                  onTap: () {
                    role = Role.volunteer;
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  value: 1,
                  child: const Text(
                    'Пассажир',
                  ),
                  onTap: () {
                    role = Role.customer;
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  value: 2,
                  onTap: () {
                    role = Role.moderator;
                    setState(() {});
                  },
                  child: const Text(
                    'Модератор',
                  ),
                ),
              ],
              child: ListTile(
                title: const Text(
                  'Ваша роль',
                ),
                subtitle: Text(
                  role == Role.volunteer
                      ? 'Водитель-волонтёр'
                      : role == Role.customer
                          ? 'Пассажир'
                          : 'Модератор',
                ),
              ),
            ),
            TextButton(
              child: const Text('Зарегистрироваться'),
              onPressed: () async {
                var isOk = await userRepo.register(
                  User(
                    fullName: _fullNameController.text,
                    phoneNumber: _controllerPhone.text,
                    password: _passwordController.text,
                    role: Role.volunteer, orders: [],
                  ),
                );
                logger.info('Registration - $isOk');
                if (role == Role.customer) {
                  NavigationController()
                      .pushWithReplaceNamed(Routes.mainCustomer);
                } else if (role == Role.volunteer){
                  NavigationController()
                      .pushWithReplaceNamed(Routes.mainVolunteer);
                } else{
                  NavigationController()
                      .pushWithReplaceNamed(Routes.mainModerator);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
