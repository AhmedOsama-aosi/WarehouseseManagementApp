import 'package:el_zahraa_app/models/product.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_product_page.dart';

class MyStorePage extends StatefulWidget {
  MyStorePage({Key? key}) : super(key: key);

  @override
  _MyStorePageState createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  @override
  Widget build(BuildContext context) {
    List<Map>? productlist;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          productlist = AppCubit.get(context).testgetProducts();
          bool isDeleted = false;

          return Scaffold(
            appBar: AppBar(
              title: defaultPageTitle("المخزن"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AddProductPage(),
                                  )));
                      AppCubit.get(context).emit(AppNewProductPage());
                    },
                  ),
                )
              ],
            ),
            body: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  if (productlist![index]['Deleted'] == 0) {
                    isDeleted = false;
                    return buildProductItem(
                        Product(productlist![index]), context);
                  } else {
                    isDeleted = true;
                    return Container();
                  }
                },
                itemCount: productlist!.length),
          );
        });
  }
}
