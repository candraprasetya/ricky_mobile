import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_mobile/core/providers/providers.dart';
import 'package:ricky_mobile/core/router/router.dart';
import 'package:ricky_mobile/core/storage/storage_impl.dart';

import 'utilities/utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StorageImpl().initStorage();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetProviders(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Ricky Mobile',
        theme: ThemeData(
          useMaterial3: true,
        ),
      ),
    );
  }
}
