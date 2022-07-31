import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_generator/shared/cubit/cubit.dart';
import 'package:password_generator/shared/cubit/states.dart';
import 'package:password_generator/shared/network/local/shared_helpder.dart';
import 'package:password_generator/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  bool? isDark = SharedHelper.getPreferences(key: 'isDark');
  runApp(MyApp(isDark ?? true));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>myCubit()..changeTheme(isPrefs: isDark)),
        BlocProvider(create: (context)=>HomeLayOutCubit()..createDatabase()
        ),
      ],
      child: BlocConsumer<myCubit, MyAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: myCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            title: 'Flutter Demo',
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

      // create: (context) =>  HomeLayOutCubit()
      //         ..changeTheme(isPrefs: isDark)
      //         ..createDatabase(),