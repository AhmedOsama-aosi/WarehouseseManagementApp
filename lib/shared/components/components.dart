import 'dart:async';

import 'package:el_zahraa_app/models/clinte.dart';
import 'package:el_zahraa_app/models/product.dart';
import 'package:el_zahraa_app/modules/clints_page/view_clint_page.dart';
import 'package:el_zahraa_app/modules/store_page/view_product_page.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import '../../modules/operationes_page/operation_details_page.dart';
import '../styles/colors.dart';

Widget defaultPageTitle(String title) =>
    Text(title, style: const TextStyle(fontWeight: FontWeight.bold));
Widget defaultFormField(
    {required TextEditingController controller,
    required TextInputType type,
    void Function(String)? onSubmit,
    Function()? onChange,
    bool readonly = false,
    int? lines,
    bool isObscure = false,
    FormFieldValidator<String>? validate,
    required String label,
    TextAlign align = TextAlign.start,
    IconData? prefix,
    FocusNode? focusNode
    // IconData? suffix,
    }) {
  return TextFormField(
    focusNode: focusNode,
    controller: controller,
    keyboardType: type,
    onEditingComplete: onChange,
    obscureText: isObscure,
    textAlign: align,
    readOnly: readonly,
    onFieldSubmitted: onSubmit,
    validator: validate,
    maxLines: lines,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: prefix != null ? Icon(prefix) : null,
      // suffixIcon: suffix != null ? Icon(suffix) : null,
    ),
  );
}

Widget buildClintItem(Clint clint, context) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      margin: const EdgeInsets.all(10),
      elevation: 3,
      child: InkWell(
        onTap: () {
          AppCubit.get(context)
              .navigateTo(context, ViewClintPage(clint), AppViewClintsPage());
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(CupertinoIcons.person),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Clint name Value

                            Text(
                              ' ${clint.fullName}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            // notify Value

                            //

                            clint.notify == 1
                                ? const Text("التنبيه فعال",
                                    style: const TextStyle(color: Colors.green))
                                : const Text("التنبيه غير فعال",
                                    style: TextStyle(color: Colors.red))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // balance value

                            Text(
                              ' ${clint.balance} ج.م',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            // Addtion Date value

                            Text(
                              '${clint.addtionDate}',
                              maxLines: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget itemSeparator() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      child: Container(
        height: 1,
        color: Colors.black,
      ),
    );

Widget buildProductItem(Product product, context) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      margin: const EdgeInsets.all(10),
      elevation: 3,
      child: InkWell(
        onTap: () {
          AppCubit.get(context).navigateTo(
              context, ViewProductPage(product), AppViewProductPage());
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(CupertinoIcons.cube_box),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Clint name Value

                            Text(
                              '${product.productName}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            // notify Value

                            Text('${product.productPrice} ج.م'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // balance value

                            Text(
                              '${product.productQuantity}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            // Addtion Date value

                            Text(
                                '${(product.productQuantity / product.productQuantityPerTon).toStringAsFixed(2)} طن'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget buildOperationItem(operation, context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(17),
    ),
    margin: const EdgeInsets.all(10),
    elevation: 3,
    child: InkWell(
      onTap: () {
        AppCubit.get(context).navigateTo(context,
            MyOperationDetailsPage(operation), AppViewOperationDetailsPage());
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(CupertinoIcons.cube_box),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Clint name Value

                          Text(
                            '${operation['clint']['FullName']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          // Describtion Value
                          Text('${operation['Operation']['Describtion']}'),

                          // OperationId Value
                          // Text(
                          //         'رقم العملية  ${operation['Operation']['OperationId']}'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // balance value

                          Text(
                            '${operation['Operation']['Paid']} ج.م',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          //Date value

                          // Text('${operation['Operation']['Date']}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  ' ${DateFormat.jm().format(DateTime.parse(operation['Operation']['Date']))}'),
                              Text(
                                  ' ${DateFormat("d/M/y").format(DateTime.parse(operation['Operation']['Date']))}'),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget defaultViewRow({required String lable, required String value}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$lable :",
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text("$value")
        ],
      ),
    );
Widget defaultSubTitle(String value) => Text(
      value,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    );

// Widget defaultAutoCompleteTextField(
//     {labelText,
//     maxSuggestions = 3,
//     prefixIcon,
//     controller,
//     required List<Map> list,
//     itemsearchvalue,
//     onFieldSubmitted,
//     onChanged,
//     onSaved,
//     validator}) {
//   return SimpleAutocompleteFormField<Map>(
//     controller: controller,
//     maxSuggestions: maxSuggestions,
//     resetIcon: null,
//     decoration: InputDecoration(
//       prefixIcon: prefixIcon,
//       labelText: labelText,
//       // border: OutlineInputBorder()
//     ),
//     suggestionsHeight: 80.0,
//     itemBuilder: (context, item) => Padding(
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(item![itemsearchvalue],
//             style: TextStyle(fontWeight: FontWeight.bold)),
//       ]),
//     ),
//     onSearch: (search) async =>
//         list.where((item) => item[itemsearchvalue].contains(search)).toList(),
//     itemFromString: (string) {
//       final matches =
//           list.where((item) => item[itemsearchvalue].contains(string));
//       return matches.isEmpty ? null : matches.first;
//     },
//     onFieldSubmitted: onFieldSubmitted,
//     onChanged: onChanged,
//     onSaved: onSaved,
//     validator: validator,
//   );
// }
Widget defaultAutoCompleteTextField(
    {labelText,
    maxSuggestions = 3,
    prefixIcon,
    controller,
    required Function getlist,
    required Function(Map) onclick,
    required Widget Function(BuildContext, Map) buildwidget,
    validator}) {
  return TypeAheadFormField<Map>(
    suggestionsCallback: (pattern) {
      return getlist(pattern);
    },
    itemBuilder: buildwidget,
    onSuggestionSelected: onclick,
    textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration:
            InputDecoration(prefixIcon: prefixIcon, labelText: labelText)),
    validator: validator,
  );
}

Widget buildlistItem(context,
        {required String text1,
        String? text2,
        required String text3,
        String? text4,
        onTap,
        icon}) =>
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      margin: const EdgeInsets.all(10),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Clint name Value

                            Text(
                              text1,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            text2 != null
                                ? const SizedBox(
                                    height: 5,
                                  )
                                : Container(),

                            // notify Value
                            text2 != null ? Text(text2) : Container(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // balance value

                            Text(
                              text3,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            text4 != null
                                ? const SizedBox(
                                    height: 5,
                                  )
                                : Container(),

                            // notify Value
                            text4 != null ? Text(text4) : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
Widget defaultMaterialButton(
    {required String title, required Function()? onPressed}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
    color: primarygreen,
    textColor: Colors.white,
    height: 45,
    minWidth: double.infinity,
    onPressed: onPressed,
  );
}
