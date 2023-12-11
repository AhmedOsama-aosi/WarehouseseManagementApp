//import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:el_zahraa_app/models/clinte.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_clint_page.dart';

class MyClintsPage extends StatelessWidget {
  const MyClintsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map>? clintlist;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          clintlist = AppCubit.get(context).testgetClints();
          bool isDeleted = false;
          return Scaffold(
            appBar: AppBar(
              title: defaultPageTitle("سجل العملاء"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AddClintPage(),
                                  )));

                      // AppCubit.get(context)
                      //     .navigateTo(context, AddClintPage(), AppNewClintPage());

                      //   AppCubit.get(context).emit(AppNewClintPage());
                    },
                  ),
                )
              ],
            ),
            body: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  if (clintlist![index]['Deleted'] == 0) {
                    isDeleted = false;
                    return buildClintItem(Clint(clintlist![index]), context);
                  } else {
                    isDeleted = true;
                    return Container();
                  }
                },
                itemCount: clintlist!.length),
          );
        });
  }
}
