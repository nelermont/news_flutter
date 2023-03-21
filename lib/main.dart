import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/app_navigator.dart';
import 'package:news/cubit/nav_cubit.dart';
import 'package:news/cubit/posts_cubit.dart';
import 'package:news/pages/posts_view.dart';
import 'package:news/const.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: myColor,
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: myColor,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))))),
        home: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => NavCubit()),
          BlocProvider(
            create: (context) => PostsBloc()..add(LoadPostsEvent()),
          )
        ], child: const AppNavigator()));
  }
}
