import 'package:flutter/material.dart';
import 'app.dart';
import 'config.dart';

void main() => Config.init(() => runApp(const App()));
