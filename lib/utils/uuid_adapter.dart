import 'package:uuid/uuid.dart';

abstract class IdAdapter {
  String genId();
}

class UUIDAdapter implements IdAdapter {
  @override
  String genId() {
    return const Uuid().v4();
  }
}
