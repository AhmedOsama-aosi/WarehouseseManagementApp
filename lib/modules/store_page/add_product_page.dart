import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productName = TextEditingController();
    final productPrice = TextEditingController();
    final productQuantity = TextEditingController();
    final productQuantityPerTon = TextEditingController();
    final productMinimumQuantity = TextEditingController();

    final formkey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      AppCubit.get(context).emit(AppStorePage());
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                const SizedBox(
                  width: 10,
                ),
              ],
              title: defaultPageTitle("إضافة منتج"),
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
                          if (value!.isEmpty) {
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
                            if (value!.isEmpty) {
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
                            if (value!.isEmpty) {
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
                            if (value!.isEmpty) {
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
                                DateTime now = DateTime.now();
                                Map newproduct = {
                                  'ProductId': "0315" +
                                      DateFormat("dMyHms").format(now) +
                                      "${now.millisecond}",
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
                                    .testAddProduct(newproduct);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
