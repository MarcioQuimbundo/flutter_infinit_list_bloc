import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinit_list_bloc/src/widgets/home_page.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  return runApp(App());
} 

class App extends StatefulWidget {
  final Widget child;

  App({Key key, this.child}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinit Scroll Bloc',
      home: HomePage(),
    );
  }
}