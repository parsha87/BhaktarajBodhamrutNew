import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/view/app.dart';
import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await bootstrap(() => const App());
}
