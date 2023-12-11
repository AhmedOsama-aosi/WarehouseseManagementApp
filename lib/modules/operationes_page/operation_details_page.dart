import 'package:el_zahraa_app/modules/operationes_page/operations_log_cubit.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/colors.dart';
import 'operations_log_States.dart';

// ignore: must_be_immutable
class MyOperationDetailsPage extends StatelessWidget {
  static late dynamic operation;
  MyOperationDetailsPage(_operation) {
    operation = _operation;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationsLogCubit, OperationsLogStates>(
        builder: (context, state) {
      OperationsLogCubit cubit = OperationsLogCubit.get(context);
      cubit.getproducts();
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: defaultPageTitle("بيانات العملية"),
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
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
                            lable: "اسم العميل",
                            value: operation['clint']['FullName']),
                        defaultViewRow(
                            lable: "رقم العملية",
                            value: "${operation['Operation']['OperationId']}"),
                        defaultViewRow(
                            lable: "الوصف",
                            value: "${operation['Operation']['Describtion']}"),
                        defaultViewRow(
                            lable: "التاريخ",
                            value: "${operation['Operation']['Date']}"),
                        defaultViewRow(
                            lable: "الخصم",
                            value: "${operation['Operation']['Discount']}"),
                        defaultViewRow(
                            lable: "المطلوب",
                            value: "${operation['Operation']['Required']}"),
                        defaultViewRow(
                            lable: "المدفوع",
                            value: "${operation['Operation']['Paid']}"),
                        defaultViewRow(
                            lable: "الرصيد قبل",
                            value:
                                "${operation['Operation']['BalanceBefore']}"),
                        defaultViewRow(
                            lable: "الرصيد بعد",
                            value: "${operation['Operation']['BalanceAfter']}"),
                        defaultViewRow(
                            lable: "الملاحظات",
                            value: "${operation['Operation']['Notes']}"),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    defaultSubTitle("المشتريات"),
                    const Spacer(),
                    IconButton(
                      // visualDensity:
                      //     VisualDensity(horizontal: 30, vertical: 30),
                      padding: const EdgeInsets.all(1),
                      iconSize: 25,
                      splashRadius: 20,
                      onPressed: () {
                        cubit.showCart();
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      color: primarygreen,
                    )
                  ],
                ),
              ),
              Builder(builder: (context) {
                /// to get cart product related to the operation
                final matchlist = AppCubit.operationDetailsDataList.where(
                    (product) =>
                        product['OperationId'] ==
                        operation['Operation']['OperationId']);

                ///
                List prodcutsInCartlist = matchlist.toList();
                if (OperationsLogCubit.showCartList) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        /// to get name of the prodcut by their id
                        var product = OperationsLogCubit.productslist.where(
                            (product) =>
                                product['ProductId'] ==
                                prodcutsInCartlist[index]['ProductId']);

                        ///
                        /// to calculate the total value of all amount of the product
                        double totalvalue = prodcutsInCartlist[index]['Price'] *
                            prodcutsInCartlist[index]['Quantity'];

                        ///
                        return buildlistItem(context,
                            text1: "${product.first['ProductName']}",
                            text2: "${prodcutsInCartlist[index]['Price']}ج.م",
                            text3: "$totalvalue ج.م",
                            text4: "${prodcutsInCartlist[index]['Quantity']}",
                            icon: CupertinoIcons.cube_box);
                      },
                      itemCount: prodcutsInCartlist.length);
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      );
    });
  }
}
