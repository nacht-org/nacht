import 'package:chapturn/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Chapturn',
        theme: ThemeData.dark(),
        routeInformationParser: _router.defaultRouteParser(),
        routerDelegate: _router.delegate(),
        routeInformationProvider: _router.routeInfoProvider(),
      ),
    );
  }
}
