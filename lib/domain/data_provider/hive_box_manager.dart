import 'package:hive/hive.dart';
import 'package:todos_hive/domain/entity/group.dart';
import 'package:todos_hive/domain/entity/task.dart';

class HiveBoxManager {
  //._() означает, что никто не сможет создать экземпляр этого класса
  //и будет существовать лишь данный инстанс, к которому будем обращаться
  static final HiveBoxManager instance = HiveBoxManager._();
  HiveBoxManager._();

//в стринге имя бокса, в инте количество открытий и закрытий
  final Map<String, int> _boxCounter = <String, int>{};

  String makeTaskBoxName(int groupKey) => 'tasks_box_$groupKey';

  Future<Box<Group>> openGroupBox() {
    return _openBox('groups_box', 1, GroupAdapter());
  }

  Future<Box<Task>> openTaskBox(int groupKey) {
    return _openBox(makeTaskBoxName(groupKey), 2, TaskAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }
    var count = _boxCounter[box.name] ?? 1;
    count -= 1;
    _boxCounter[box.name] = count;
    if (count > 0) return;
    _boxCounter.remove(box.name);

    await box.compact();
    await box.close();
  }

  Future<Box<T>> _openBox<T>(
      String name, int typeId, TypeAdapter<T> adapter) async {
    //каждый раз когда открываем бокс - проверяем, открыт он или нет
    //если да - к открытиям добовляем 1 (если был открыт)
    if (Hive.isBoxOpen(name)) {
      final count = _boxCounter[name] ?? 1;
      _boxCounter[name] = count + 1;
      return Hive.box(name);
    }
    _boxCounter[name] = 1;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
