import 'package:el_zahraa_app/modules/home_page/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentindex = 0;
  List<Widget> selecteditem = [];

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: defaultPageTitle("الرئيسية"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Directionality(
                //               textDirection: TextDirection.rtl,
                //               child: AddProductPage(),
                //             )));
                // AppCubit.get(context).emit(AppNewProductPage());
                cubit.getClintList();
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) {
            // if ([InitalStateOperationsLog].contains(current.runtimeType)) {
            //   return true;
            // } else {
            //   return false;
            // }
            return true;
          },
          builder: (context, state) {
            // WidgetsBinding.instance?.addPostFrameCallback(
            //     (_) => {OperationsLogCubit.get(context).emit(state)});
            // List<Map> operationlist =
            //     AppCubit.operationsDataList.reversed.toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                      color: primarygreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 40),
                        child: Row(
                          children: [
                            const Text(
                              "اجمالي الدخل",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            const Text(
                              "50000",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              " ج.م",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          defaultSubTitle("عملاء انتهت مهلة السداد لديهم"),
                          const Spacer(),
                          Text('${HomeCubit.clintslist.length}'),
                          IconButton(
                            onPressed: () {
                              cubit.showClintList();
                            },
                            icon: const Icon(Icons.keyboard_arrow_down),
                            color: primarygreen,
                          )
                        ],
                      ),
                    ),
                    Builder(builder: (context) {
                      if (HomeCubit.showClintListBoolean) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final clint = HomeCubit.clintslist[index];
                            return buildlistItem(context,
                                text1: "${clint['FullName']}",
                                text3: "${clint['Balance']} ج.م",
                                icon: CupertinoIcons.person);
                          },
                          itemCount: HomeCubit.clintslist.length,
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          defaultSubTitle("منتجات اوشكت علي النفاذ"),
                          const Spacer(),
                          Text('${HomeCubit.productslist.length}'),
                          IconButton(
                            onPressed: () {
                              cubit.showProductList();
                            },
                            icon: const Icon(Icons.keyboard_arrow_down),
                            color: primarygreen,
                          )
                        ],
                      ),
                    ),
                    Builder(builder: (context) {
                      if (HomeCubit.showProductListBoolean) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = HomeCubit.productslist[index];
                            return buildlistItem(context,
                                text1: "${item['ProductName']}",
                                text3: "${item['Quantity']}",
                                icon: CupertinoIcons.cube_box);
                          },
                          itemCount: HomeCubit.productslist.length,
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
