import 'package:chapturn/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Chapturn',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routeInformationParser: _router.defaultRouteParser(),
        routerDelegate: _router.delegate(),
      ),
    );
  }
}
