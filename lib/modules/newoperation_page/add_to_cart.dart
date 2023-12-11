import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'new_operation_cubit.dart';

addProductDialog(BuildContext context, cubit) {
  return showDialog(
      context: context,
      builder: (context) {
        final namedialogcontroller = TextEditingController();
        final pricedialogcontroller = TextEditingController();
        final intanialogcontroller = TextEditingController();
        final avilablequantityialogcontroller = TextEditingController();
        final requiredquantityialogcontroller = TextEditingController();
        dynamic productId;
        final formkey = GlobalKey<FormState>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text("اضافة منتج"),
              content: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultAutoCompleteTextField(
                        labelText: 'اسم المنتج',
                        prefixIcon: const Icon(Icons.label),
                        controller: namedialogcontroller,
                        getlist: (string) {
                          final matches = NewOperationCubit.productslist.where(
                              (product) =>
                                  product["ProductName"].contains(string));
                          return matches;
                          // return NewOperationCubit.productslist;
                        },
                        buildwidget: (context, list) {
                          final product = list;
                          return ListTile(
                            title: Text(product["ProductName"],
                                textAlign: TextAlign.right),
                          );
                        },
                        onclick: (value) {
                          try {
                            var product = value;
                            productId = product['ProductId'];

                            namedialogcontroller.text =
                                product['ProductName'].toString();

                            pricedialogcontroller.text =
                                product['Price'].toString();

                            intanialogcontroller.text =
                                product['QuantityPerTon'].toString();
                            avilablequantityialogcontroller.text =
                                product['Quantity'].toString();
                            requiredquantityialogcontroller.text = "";
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        validator: (value) {
                          if (namedialogcontroller.text == "") {
                            return 'يجب ادخال اسم المنتج !';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextField(
                        controller: pricedialogcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "السعر "),
                      ),
                      TextField(
                        controller: intanialogcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "الكمية داخل الطن"),
                      ),
                      TextField(
                        controller: avilablequantityialogcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "الكمية داخل المخزن"),
                      ),
                      TextFormField(
                        controller: requiredquantityialogcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "الكمية"),
                        validator: (value) {
                          if (requiredquantityialogcontroller.text == "") {
                            return 'يجب ادخال قيمة !';
                          } else if (double.parse(
                                  requiredquantityialogcontroller.text) >
                              double.parse(
                                  avilablequantityialogcontroller.text)) {
                            return ' الكمية المتوفرة في المخزن لا تكفي!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: defaultMaterialButton(
                            title: "اضافة",
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                double price =
                                    double.parse(pricedialogcontroller.text);
                                double quantity = double.parse(
                                    requiredquantityialogcontroller.text);

                                cubit.addToCart({
                                  'ProductId': productId,
                                  'ProductName': namedialogcontroller.text,
                                  'Price': price,
                                  'TotalPrice': quantity * price,
                                  'Quantity': quantity
                                });
                                namedialogcontroller.text = "";
                                pricedialogcontroller.text = "";
                                intanialogcontroller.text = "";
                                avilablequantityialogcontroller.text = "";
                                requiredquantityialogcontroller.text = "";
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              )),
        );
      });
}
