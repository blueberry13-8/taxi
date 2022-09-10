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
    return Scaffold(
      body: FutureBuilder<SharedPreferences>(
        future: userInstance,
        //initialData: const CircularProgressIndicator(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? role = snapshot.data!.getString('role');
            if (role != null) {
              switch (
                  Role.values.singleWhere((element) => element.name == role)) {
                case Role.customer:
//                  NavigationController().pushWithReplaceNamed(page);
                  return const Text('Customer');
                case Role.volunteer:
                  return const Text('Volunteer');
                case Role.moderator:
                  return const Text('Moderator');
              }
            } else {
              //Start registration or login
              //return const Text('Registration');
              return SingleChildScrollView(
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
                          right: 20, left: 20, bottom: 20),
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
                          ),
                        );
                        logger.info('LogIn - $isOk');
                      },
                    ),
                    TextButton(
                      child: const Text('Нет аккаунта?\nЗарегистрироваться'),
                      onPressed: () async {

                      },
                    ),

                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: const Text('Перезагрузите приложение!'),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
