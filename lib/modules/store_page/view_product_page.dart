import 'package:el_zahraa_app/models/product.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_product_page.dart';

// ignore: must_be_immutable
class ViewProductPage extends StatelessWidget {
  static late Product product;
  ViewProductPage(theproduct) {
    product = theproduct;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
      print(" ViewProduct : i have listen too");
    }, builder: (BuildContext context, AppStates state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              AppCubit.get(context).emit(AppStorePage());
            },
          ),
          title: defaultPageTitle("بيانات المنتج"),
          actions: [
            IconButton(
                onPressed: () {
                  AppCubit.get(context).navigateTo(
                      context, EditProductPage(product), AppEditProductPage());
                },
                icon: const Icon(Icons.edit)),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          margin: const EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  defaultViewRow(
                      lable: "اسم المنتج", value: product.productName),
                  defaultViewRow(
                      lable: "السعر", value: product.productPrice.toString()),
                  defaultViewRow(
                      lable: "الكمية",
                      value: product.productQuantity.toString()),
                  defaultViewRow(
                      lable: "الكمية داخل الطن",
                      value: product.productQuantityPerTon.toString()),
                  defaultViewRow(
                      lable: "الحد الادني للكمية",
                      value: product.productMinimumQuantity.toString()),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
