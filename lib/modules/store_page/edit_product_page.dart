import 'package:el_zahraa_app/layout/HomeLayout.dart';
import 'package:el_zahraa_app/models/product.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditProductPage extends StatelessWidget {
  final productName = TextEditingController();
  final productPrice = TextEditingController();
  final productQuantity = TextEditingController();
  final productQuantityPerTon = TextEditingController();
  final productMinimumQuantity = TextEditingController();
  late Product product;
  EditProductPage(this.product) {
    productName.text = product.productName;
    productPrice.text = product.productPrice.toString();
    productQuantity.text = product.productQuantity.toString();
    productQuantityPerTon.text = product.productQuantityPerTon.toString();
    productMinimumQuantity.text = product.productMinimumQuantity.toString();
  }
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  AppCubit.get(context).emit(AppViewProductPage());
                },
              ),
              title: defaultPageTitle("تعديل بيانات المنتج"),
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).testDeleteProduct(product.toMap());

                      AppCubit.get(context)
                          .navigateAndremove(context, const HomeLayout());
                    },
                    icon: const Icon(Icons.delete)),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      defaultFormField(
                        label: "اسم المنتج",
                        prefix: CupertinoIcons.tag,
                        controller: productName,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'يجب ادخال اسم المنتج !';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                        label: "السعر",
                        prefix: CupertinoIcons.money_pound,
                        controller: productPrice,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value == null) {
                            return 'يجب ادخال قيمة  !';
                          } else {
                            try {
                              double.parse(value);
                              return null;
                            } catch (er) {
                              return 'يجب ادخال عدد  !';
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          label: "الكمية",
                          prefix: CupertinoIcons.cube_box,
                          controller: productQuantity,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value == null) {
                              return 'يجب ادخال قيمة  !';
                            } else {
                              try {
                                double.parse(value);
                                return null;
                              } catch (er) {
                                return 'يجب ادخال عدد  !';
                              }
                            }
                          }),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          label: "الكمية داخل الطن",
                          prefix: CupertinoIcons.cube_box_fill,
                          controller: productQuantityPerTon,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value == null) {
                              return 'يجب ادخال قيمة  !';
                            } else {
                              try {
                                double.parse(value);
                                return null;
                              } catch (er) {
                                return 'يجب ادخال عدد  !';
                              }
                            }
                          }),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          label: "الحد الادني للكمية",
                          prefix: CupertinoIcons.exclamationmark_triangle,
                          controller: productMinimumQuantity,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value == null) {
                              return 'يجب ادخال قيمة  !';
                            } else {
                              try {
                                double.parse(value);
                                return null;
                              } catch (er) {
                                return 'يجب ادخال عدد  !';
                              }
                            }
                          }),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: defaultMaterialButton(
                            title: "حفظ",
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                Map newproduct = {
                                  'ProductId': product.id,
                                  'ProductName': productName.text,
                                  'Price': double.parse(productPrice.text),
                                  'Quantity':
                                      double.parse(productQuantity.text),
                                  'QuantityPerTon':
                                      double.parse(productQuantityPerTon.text),
                                  'MinimumQuantity':
                                      double.parse(productMinimumQuantity.text),
                                  'Deleted': 0,
                                };

                                AppCubit.get(context)
                                    .testEditProduct(newproduct);
                                Navigator.pop(context);
                                AppCubit.get(context).emit(AppNewProductPage());
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
