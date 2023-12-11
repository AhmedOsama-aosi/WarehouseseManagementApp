import 'package:el_zahraa_app/modules/home_page/cubit/home_cubit.dart';
import 'package:el_zahraa_app/shared/bloc_observer.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:el_zahraa_app/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/HomeLayout.dart';
import 'modules/newoperation_page/new_operation_cubit.dart';
import 'modules/operationes_page/operations_log_cubit.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              // create: (context) => AppCubit()..createDataBase(),
              create: (context) => AppCubit()..testCreateLists()),
          BlocProvider(create: (context) => NewOperationCubit()..getdata()),
          BlocProvider(create: (context) => OperationsLogCubit()),
          BlocProvider(create: (context) => HomeCubit()..getData())
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, AppStates state) {},
            builder: (BuildContext context, AppStates state) {
              return MaterialApp(
                title: 'Business Manager',
                theme: lightTheme(context),
                debugShowCheckedModeBanner: false,
                home: const Directionality(
                  textDirection: TextDirection.rtl,
                  child: HomeLayout(),
                ),
              );
            }));
  }
}
