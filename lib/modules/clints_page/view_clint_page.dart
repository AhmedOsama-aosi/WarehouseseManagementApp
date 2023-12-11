import 'package:el_zahraa_app/models/clinte.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_clint_page.dart';

// ignore: must_be_immutable
class ViewClintPage extends StatelessWidget {
  static late Clint clint;
  ViewClintPage(theclint) {
    clint = theclint;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
      print(" ViewClint : i have listen too");
    }, builder: (BuildContext context, AppStates state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              AppCubit.get(context).emit(AppClintsPage());
            },
          ),
          title: defaultPageTitle("بيانات العميل"),
          actions: [
            IconButton(
                onPressed: () {
                  AppCubit.get(context).navigateTo(
                      context, EditClintPage(clint), AppEditClintPage());
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
                  defaultViewRow(lable: "الاسم", value: clint.fullName),
                  defaultViewRow(
                      lable: "تاريخ الاضافة", value: clint.addtionDate),
                  defaultViewRow(lable: "الهاتف", value: clint.phoneNumber),
                  defaultViewRow(lable: "العنوان", value: clint.address),
                  defaultViewRow(
                      lable: "البطاقة الضريبية", value: clint.taxcard),
                  defaultViewRow(
                      lable: "السجل التجاري", value: clint.commercialRegister),
                  defaultViewRow(lable: "الرصيد", value: "${clint.balance}"),
                  defaultViewRow(
                      lable: "فترة السداد", value: "${clint.paymentDeadline}"),
                  defaultViewRow(
                      lable: "التنبيه",
                      value: clint.notify == 1 ? "فعال" : "غير فعال"),
                  defaultViewRow(lable: "الملاحظات", value: clint.notes),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
