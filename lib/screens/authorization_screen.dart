import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/log/logger.dart';
import 'package:taxi/navigation/navigation_controller.dart';
import 'package:taxi/repositories/api_user.dart';

import 'package:taxi/models/user.dart';
import '../navigation/routes.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  late Future<SharedPreferences> userInstance;
  final _controller = TextEditingController();
  final _passwordController = TextEditingController();
  UserRepo userRepo = UserRepo();

  @override
  void initState() {
    userInstance = SharedPreferences.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userInstance.then((value) {
      String? role = value.getString('role');
      if (role != null) {
        if (role == Role.customer.name) {
          NavigationController().pushWithReplaceNamed(Routes.mainCustomer);
        } else if (role == Role.volunteer.name) {
          NavigationController().pushWithReplaceNamed(Routes.mainVolunteer);
        } else {
          NavigationController().pushWithReplaceNamed(Routes.mainModerator);
        }
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 50,
            // ),
            const Text(
              'Войдите в аккаунт или создайте новый!',
              style: TextStyle(height: 20),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Телефон',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: 20,
              ),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Пароль',
                ),
              ),
            ),
            TextButton(
              child: const Text('Войти'),
              onPressed: () async {
                var isOk = await userRepo.login(
                  User(
                    fullName: 'fullName',
                    phoneNumber: _controller.text,
                    password: _passwordController.text,
                    role: Role.volunteer,
                    orders: [],
                  ),
                );
                logger.info('LogIn - $isOk');
              },
            ),
            TextButton(
              child: const Text('Нет аккаунта?\nЗарегистрироваться'),
              onPressed: () {
                //NavigationController().pushNamed(Routes.reg);
                NavigationController().pushWithReplaceNamed(Routes.reg);
              },
            ),
          ],
        ),
      ),
    );
  }
}
