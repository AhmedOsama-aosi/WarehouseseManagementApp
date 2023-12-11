import 'package:el_zahraa_app/layout/HomeLayout.dart';
import 'package:el_zahraa_app/models/clinte.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditClintPage extends StatelessWidget {
  var clintName = TextEditingController();
  var clintPhoneNumber = TextEditingController();
  var clintAddress = TextEditingController();
  var clintTaxCard = TextEditingController();
  var clintCommeioalRegister = TextEditingController();
  var clintNotes = TextEditingController();
  var clintDeadline = TextEditingController();
  static bool checkboxvalue = true;
  var formkey = GlobalKey<FormState>();
  late Clint clint;
  EditClintPage(this.clint) {
    clintName.text = clint.fullName;
    clintPhoneNumber.text = clint.phoneNumber;
    clintAddress.text = clint.address;
    clintTaxCard.text = clint.taxcard;
    clintCommeioalRegister.text = clint.commercialRegister;
    clintDeadline.text = clint.paymentDeadline.toString();
    checkboxvalue = clint.notify == 1 ? true : false;
    clintNotes.text = clint.notes;
  }

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
                  AppCubit.get(context).emit(AppViewClintsPage());
                },
              ),
              title: defaultPageTitle("تعديل بيانات العميل"),
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).testDeleteClints(clint.toMap());

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
                          controller: clintName,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب ادخال اسم العميل !';
                            } else {
                              return null;
                            }
                          },
                          label: "اسم العميل",
                          prefix: Icons.person,
                          align: TextAlign.start),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          controller: clintPhoneNumber,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.length < 11 && value.length > 0) {
                              return 'هذا الرقم اقل من 11 رقم !';
                            } else {
                              return null;
                            }
                          },
                          label: "رقم الهاتف",
                          prefix: Icons.phone,
                          align: TextAlign.start),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          controller: clintAddress,
                          type: TextInputType.name,
                          label: "العنوان",
                          prefix: Icons.store,
                          align: TextAlign.start),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          controller: clintTaxCard,
                          type: TextInputType.number,
                          label: "البطاقة الضريبية",
                          prefix: Icons.credit_card,
                          align: TextAlign.start),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          controller: clintCommeioalRegister,
                          type: TextInputType.number,
                          label: "السجل التجاري",
                          prefix: Icons.business,
                          align: TextAlign.start),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: defaultFormField(
                                controller: clintDeadline,
                                type: TextInputType.number,
                                label: "مهلة السداد",
                                prefix: Icons.alarm,
                                align: TextAlign.start),
                          ),
                          const SizedBox(width: 10),
                          const Text("التنبيه"),
                          const SizedBox(width: 10),
                          MyCheckbox()
                        ],
                      ),
                      // SizedBox(height: 8.0),
                      defaultFormField(
                          controller: clintNotes,
                          type: TextInputType.multiline,
                          lines: 3,
                          label: "الملاحظات",
                          prefix: Icons.notes,
                          align: TextAlign.start),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: defaultMaterialButton(
                            title: "حفظ",
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                Map newclint = {
                                  'ClintId': clint.id,
                                  'FullName': clintName.text,
                                  'PhoneNumber': clintPhoneNumber.text,
                                  'CommercialRegister':
                                      clintCommeioalRegister.text,
                                  'Taxcard': clintTaxCard.text,
                                  'Address': clintAddress.text,
                                  'Notes': clintNotes.text,
                                  'PaymentDeadline': clintDeadline.text != ""
                                      ? int.parse(clintDeadline.text)
                                      : 30,
                                  'Notify': checkboxvalue ? 1 : 0,
                                  'Deleted': 0,
                                };
                                AppCubit.get(context).testEditClint(newclint);
                                Navigator.pop(context);
                                AppCubit.get(context).emit(AppViewClintsPage());
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

class MyCheckbox extends StatefulWidget {
  MyCheckbox({Key? key}) : super(key: key);

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: EditClintPage.checkboxvalue,
        onChanged: (newvalue) {
          setState(() {
            EditClintPage.checkboxvalue = newvalue!;
          });
        });
  }
}
