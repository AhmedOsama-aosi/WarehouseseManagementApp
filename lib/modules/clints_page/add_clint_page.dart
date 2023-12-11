import 'package:el_zahraa_app/models/clinte.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:el_zahraa_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddClintPage extends StatelessWidget {
  static bool checkboxvalue = true;

  const AddClintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          checkboxvalue = true;

          return pagecontent(context);
        });
  }

  Widget pagecontent(context) {
    var clintName = TextEditingController();
    var clintPhoneNumber = TextEditingController();
    var clintAddress = TextEditingController();
    var clintTaxCard = TextEditingController();
    var clintCommeioalRegister = TextEditingController();
    var clintNotes = TextEditingController();
    var clintDeadline = TextEditingController();

    var formkey = GlobalKey<FormState>();
    AppCubit cubitinAddClint = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                cubitinAddClint.emit(AppClintsPage());
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          const SizedBox(
            width: 10,
          ),
        ],
        title: defaultPageTitle("إضافة عميل"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                ),
                const SizedBox(height: 10.0),
                defaultFormField(
                  controller: clintPhoneNumber,
                  type: TextInputType.phone,
                  validate: (value) {
                    if (value!.length < 11 && value.isNotEmpty) {
                      return 'هذا الرقم اقل من 11 رقم !';
                    } else {
                      return null;
                    }
                  },
                  label: "رقم الهاتف",
                  prefix: Icons.phone,
                ),
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
                ),
                const SizedBox(height: 10.0),
                defaultFormField(
                  controller: clintCommeioalRegister,
                  type: TextInputType.number,
                  label: "السجل التجاري",
                  prefix: Icons.business,
                ),
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
                    const MyCheckbox()
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
                          Clint newclint = Clint({
                            'FullName': clintName.text,
                            'PhoneNumber': clintPhoneNumber.text,
                            'CommercialRegister': clintCommeioalRegister.text,
                            'Taxcard': clintTaxCard.text,
                            'Address': clintAddress.text,
                            'Notes': clintNotes.text,
                            'AddtionDate':
                                DateFormat('dd/MM/yyyy').format(DateTime.now()),
                            'PaymentDeadline': clintDeadline.text != ""
                                ? int.parse(clintDeadline.text)
                                : 30,
                            'Balance': 0.0,
                            'Notify': checkboxvalue ? 1 : 0,
                            'Deleted': 0,
                          });
                          // cubitinAddClint.emit(AppNewClintPage());
                          cubitinAddClint.testAddClint(newclint.toMap());
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('تم اضافة العميل'),
                            backgroundColor: primarygreen,
                          ));
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCheckbox extends StatefulWidget {
  const MyCheckbox({Key? key}) : super(key: key);

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: AddClintPage.checkboxvalue,
        onChanged: (newvalue) {
          setState(() {
            AddClintPage.checkboxvalue = newvalue!;
          });
        });
  }
}
