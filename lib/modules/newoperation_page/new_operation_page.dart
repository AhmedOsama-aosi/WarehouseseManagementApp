import 'package:el_zahraa_app/modules/newoperation_page/new_operation_cubit.dart';
import 'package:el_zahraa_app/modules/newoperation_page/new_operation_states.dart';
import 'package:el_zahraa_app/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/styles/colors.dart';
import 'add_to_cart.dart';

class MyNewOperationPage extends StatelessWidget {
  final clintformkey = GlobalKey<FormState>();
  final financialformkey = GlobalKey<FormState>();

  MyNewOperationPage({Key? key}) : super(key: key);

  final clintNameController = TextEditingController();
  final clintBalanceController = TextEditingController();
  final describtionController = TextEditingController();
  final totalcontroller = TextEditingController();
  final discountController = TextEditingController();
  final totalAfterDiscountController = TextEditingController();
  final clintBalanceAfterController = TextEditingController();
  final notesController = TextEditingController();
  final paidController = TextEditingController();
  final paidNode = FocusNode();
  dynamic clint;
  double totalSummtionvalue = 0;
  double discountvalue = 0;
  double totalAfterDiscountvalue = 0;

  void clearValues() {
    discountController.text = "";
    paidController.text = "";
    clintBalanceAfterController.text = "";
    NewOperationCubit.discountBoolean = false;
    NewOperationCubit.paymentBoolean = false;
  }

  @override
  Widget build(BuildContext context) {
    ///variables

    NewOperationCubit cubit = NewOperationCubit.get(context);

    return Scaffold(
        appBar: AppBar(
          title: defaultPageTitle("عملية جديدة"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              clintSection(cubit),
              cartSection(cubit),
              financialSection(cubit),
            ],
          ),
        ));
  }

  BlocBuilder<NewOperationCubit, NewOperationStates> clintSection(
      NewOperationCubit cubit) {
    return BlocBuilder<NewOperationCubit, NewOperationStates>(
      buildWhen: (previous, current) {
        if (ChangeClintStateNewOperation == current.runtimeType) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        print('clint i have been build');
        return Form(
          key: clintformkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  defaultAutoCompleteTextField(
                    labelText: 'اسم العميل',
                    prefixIcon: const Icon(Icons.person),
                    controller: clintNameController,
                    getlist: (string) {
                      final matches = NewOperationCubit.clintslist
                          .where((clint) => clint["FullName"].contains(string));
                      return matches;
                      // return NewOperationCubit.clintslist;
                    },
                    buildwidget: (context, list) {
                      final clint = list;
                      return ListTile(
                        title:
                            Text(clint["FullName"], textAlign: TextAlign.right),
                      );
                    },
                    onclick: (value) {
                      try {
                        clint = value;
                        clintNameController.text = clint['FullName'];
                        clintBalanceController.text =
                            clint['Balance'].toString();
                        cubit.emit(ChangeClintStateNewOperation());
                      } catch (e) {
                        // ignore: avoid_print
                        print(e.toString());
                      }
                    },
                    validator: (value) {
                      if (clintNameController.text == "" || value == null) {
                        return 'يجب ادخال اسم العميل !';
                      } else {
                        return null;
                      }
                    },
                  ),
                  defaultFormField(
                    label: "الرصيد",
                    prefix: Icons.account_balance,
                    controller: clintBalanceController,
                    readonly: true,
                    type: TextInputType.number,
                  ),
                ]),
          ),
        );
      },
    );
  }

  BlocBuilder<NewOperationCubit, NewOperationStates> cartSection(
      NewOperationCubit cubit) {
    return BlocBuilder<NewOperationCubit, NewOperationStates>(
      buildWhen: (previous, current) {
        if ([
          RemoveProductsStateNewOperation,
          AddProductsStateNewOperation,
          OperationSavedNewOperation
        ].contains(current.runtimeType)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
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
                      if (clintformkey.currentState!.validate()) {
                        addProductDialog(context, cubit);
                      }
                    },
                    icon: const Icon(Icons.add),
                    color: primarygreen,
                  ),
                  Text('${NewOperationCubit.cartlist.length}'),
                  IconButton(
                    onPressed: () {
                      cubit.showCart();
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    color: primarygreen,
                  )
                ],
              ),
            ),
            Builder(builder: (context) {
              if (NewOperationCubit.cartlist.isNotEmpty) {
                WidgetsBinding.instance?.addPostFrameCallback((_) => {
                      totalcontroller.text = totalSummtionvalue.toString(),
                      totalAfterDiscountController.text =
                          totalSummtionvalue.toString(),
                      clearValues(),
                      print(
                          "cart i have been build,${NewOperationCubit.discountBoolean}"),
                    });

                /// to get the total require
                totalSummtionvalue = 0;
                for (var product in NewOperationCubit.cartlist) {
                  totalSummtionvalue += product['TotalPrice'];
                }

                if (NewOperationCubit.showCartList) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = NewOperationCubit.cartlist[index];
                      return Dismissible(
                        key: Key(DateTime.now().toString()),
                        onDismissed: (direction) {
                          cubit.removeFromCart(index);
                        },
                        child: buildlistItem(context,
                            text1: "${item['ProductName']}",
                            text2: "${item['Price']}ج.م",
                            text3: "${item['TotalPrice']} ج.م",
                            text4: "${item['Quantity']}",
                            icon: CupertinoIcons.cube_box),
                      );
                    },
                    itemCount: NewOperationCubit.cartlist.length,
                  );
                } else {
                  return Container();
                }
              } else {
                WidgetsBinding.instance?.addPostFrameCallback((_) => {
                      totalAfterDiscountvalue = 0,
                      totalcontroller.text = "",
                      totalAfterDiscountController.text = "",
                      clearValues(),
                    });
                return Container();
              }
            }),
          ],
        );
      },
    );
  }

  BlocBuilder<NewOperationCubit, NewOperationStates> financialSection(
      NewOperationCubit cubit) {
    return BlocBuilder<NewOperationCubit, NewOperationStates>(
      builder: (context, state) {
        WidgetsBinding.instance?.addPostFrameCallback((_) => {
              print(
                  "finaical i have been built ,${NewOperationCubit.discountBoolean}"),
              describtionController.text = "",
              if (NewOperationCubit.cartlist.isNotEmpty)
                {
                  describtionController.text = "فاتورة",
                  if (NewOperationCubit.discountBoolean)
                    {describtionController.text += " + خصم"},
                  if (NewOperationCubit.paymentBoolean)
                    {describtionController.text += " + سداد"}
                }
              else
                {
                  if (NewOperationCubit.paymentBoolean)
                    {describtionController.text = "سداد"}
                }
            });

        return Form(
          key: financialformkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                defaultFormField(
                    label: "الوصف",
                    prefix: Icons.attach_money,
                    controller: describtionController,
                    type: TextInputType.text,
                    readonly: true),
                defaultFormField(
                    label: "الاجمالي",
                    prefix: Icons.attach_money,
                    controller: totalcontroller,
                    type: TextInputType.number,
                    readonly: true),
                defaultFormField(
                    label: "الخصم",
                    prefix: Icons.money_off,
                    controller: discountController,
                    type: TextInputType.number,
                    onChange: () {
                      discountvalue = 0;
                      if (discountController.text.isNotEmpty) {
                        discountvalue = double.parse(discountController.text);
                      }

                      totalAfterDiscountvalue =
                          totalSummtionvalue - discountvalue;
                      totalAfterDiscountController.text =
                          totalAfterDiscountvalue.toString();

                      if (discountvalue > 0 &&
                          discountController.text.isNotEmpty) {
                        NewOperationCubit.discountBoolean = true;
                      } else {
                        NewOperationCubit.discountBoolean = false;
                      }
                      cubit.emit(DiscountStateNewOperation());
                    },
                    onSubmit: (value) {
                      FocusScope.of(context).requestFocus(paidNode);
                    }),
                defaultFormField(
                    label: "المطلوب",
                    prefix: Icons.attach_money,
                    controller: totalAfterDiscountController,
                    type: TextInputType.number,
                    readonly: true),
                // SizedBox(height: 8.0),
                defaultFormField(
                    label: "المدفوع",
                    focusNode: paidNode,
                    prefix: Icons.payment,
                    controller: paidController,
                    type: TextInputType.number,
                    onChange: () {
                      if (clintformkey.currentState!.validate()) {
                        double clintBalanceBefore =
                            double.parse(clintBalanceController.text);
                        double paidValue = 0;
                        if (paidController.text.isNotEmpty) {
                          paidValue = double.parse(paidController.text);
                        }

                        clintBalanceAfterController.text = (clintBalanceBefore +
                                totalAfterDiscountvalue -
                                paidValue)
                            .toString();
                        if (paidValue > totalAfterDiscountvalue) {
                          NewOperationCubit.paymentBoolean = true;
                        } else {
                          NewOperationCubit.paymentBoolean = false;
                        }
                      }
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'يجب ادخال قيمة او صفر !';
                      } else {
                        return null;
                      }
                    },
                    onSubmit: (value) {
                      FocusScope.of(context).unfocus();
                    }),
                defaultFormField(
                    label: "الرصيد المتبقي",
                    prefix: Icons.account_balance,
                    controller: clintBalanceAfterController,
                    type: TextInputType.number,
                    readonly: true),
                defaultFormField(
                  label: "الملاحظات",
                  prefix: Icons.notes,
                  controller: notesController,
                  type: TextInputType.text,
                ),
                const SizedBox(height: 40.0),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: defaultMaterialButton(
                      title: "حفظ",
                      onPressed: () {
                        DateTime now = DateTime.now();

                        if (clintformkey.currentState!.validate() &&
                            financialformkey.currentState!.validate()) {
                          Map operation = {
                            'OperationId': "0215${now.millisecond}",
                            'ClintId': clint['ClintId'],
                            'Describtion': describtionController.text,
                            'Date': "${DateTime.now()}",
                            'Required': double.tryParse(
                                totalAfterDiscountController.text),
                            'Discount':
                                double.tryParse(discountController.text),
                            'Paid': double.parse(paidController.text),
                            'BalanceBefore': clint['Balance'],
                            'BalanceAfter':
                                double.parse(clintBalanceAfterController.text),
                            'Notes': notesController.text
                          };

                          cubit.saveOperation(operation);

                          clintNameController.text = "";
                          clintBalanceController.text = "";
                          describtionController.text = "";
                          totalcontroller.text = "";
                          totalAfterDiscountController.text = "";
                          clearValues();
                          notesController.text = "";
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('تم حفظ العملية'),
                            backgroundColor: primarygreen,
                          ));
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
