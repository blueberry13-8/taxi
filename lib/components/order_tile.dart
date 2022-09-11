import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/models/order.dart';
import 'package:taxi/navigation/navigation_controller.dart';
import 'package:taxi/navigation/routes.dart';
import 'package:taxi/repositories/api_user.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  //late final Order _order;

  @override
  void initState() {
    super.initState();
    //_order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          DateFormat('d MMMM, hh:mm', 'ru').format(widget.order.timeStart) +
              DateFormat('-hh:mm', 'ru').format(widget.order.timeTo)),
      //title: Text('${widget.order.timeStart.month}, ${widget.order.timeStart.day}, ${widget.order.timeStart.hour}:${widget.order.timeStart.minute}-${widget.order.timeTo.hour}:${widget.order.timeTo.minute}'),
      subtitle: Text('${widget.order.origin} - ${widget.order.destination}'),
      trailing: Icon(Icons.info_outline),
      onTap: () {
        NavigationController()
            .pushNamed(Routes.infoOrder, arguments: [widget.order]);
      },
      onLongPress: () async {
        var prefs = await SharedPreferences.getInstance();
        if (prefs.getString('role') == 'volunteer') {
          UserRepo repo = UserRepo();
          await repo.acceptOrder(widget.order.id);
          setState(() {});
        }
      },
    );
  }
}
