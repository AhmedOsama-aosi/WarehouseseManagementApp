import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        final AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.selecteditem[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "الرئيسية",
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book),
                label: "العملبات",
              ),
              const BottomNavigationBarItem(
                icon: Center(
                  child: const Icon(
                    Icons.add_circle,
                    size: 35,
                  ),
                ),
                label: "عملية جديدة",
              ),
              const BottomNavigationBarItem(
                icon: const Icon(Icons.people_outline),
                label: "العملاء",
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cube_box),
                label: "المخزن",
              ),
            ],
          ),
        );
      },
    );
  }
}
