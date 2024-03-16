import '../utils/logger.dart';

extension LogExt on String {
  log() {
    Logger.print(this);
  }

  isNum() {
    RegExp regex = RegExp(r'^[0-9]$');
    return regex.hasMatch(this);
  }
}
