import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos_hive/widgets/group_form/group_form_widget.dart';
import 'package:todos_hive/widgets/groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      routes: {
        '/groups': (context) => const GroupsWidget(),
        'groups/form': (context) => const GroupFormWidget(),
      },
      initialRoute: '/groups',
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}
