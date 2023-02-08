import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_provider/controller/user_notifier.dart';
import 'package:flutter_state_provider/model/user.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    return ListView.builder(
      itemCount: userNotifier.userList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserNotifier>(
                      builder: (
                    _,
                    notifier,
                    __,
                  ) =>
                          Text(
                            'Name: ${notifier.userList[index].city}',
                            style: TextStyle(fontSize: 18),
                          ))
                ],
              ),
              Consumer<UserNotifier>(
                  builder: (_, notifier, __) => IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => {notifier.deleteUser(index)}))
            ],
          ),
        ),
      ),
    );
  }
}
