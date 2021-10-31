import 'package:flutter/material.dart';
import 'package:todos_hive/ui/widgets/group_form/group_form_widget.dart';
import 'package:todos_hive/ui/widgets/groups/groups_widget.dart';
import 'package:todos_hive/ui/widgets/tasks/tasks_widget.dart';
import 'package:todos_hive/ui/widgets/tasks_form/task_form_widget.dart';

abstract class MainNavigationRouteNames {
  static const groups = '/';
  static const groupsForm = '/groupForm';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
    MainNavigationRouteNames.groupsForm: (context) => const GroupFormWidget(),
  };

//добавили для страниц для которых нужны аргументы
//также тут можно настраивать определенную анимацию перехода
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.tasks:
        final configuraton = settings.arguments as TaskWidgetConfiguration;
        return MaterialPageRoute(
          builder: (context) => TasksWidget(
            configuration: configuraton,
          ),
        );
      case MainNavigationRouteNames.tasksForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => TaskFormWidget(
            groupKey: groupKey,
          ),
        );
      default:
        const widget = Text('Navigation Error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
