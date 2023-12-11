import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../newoperation_page/new_operation_cubit.dart';
import 'operations_log_States.dart';
import 'operations_log_cubit.dart';

class MyOperationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defaultPageTitle("سجل العمليات"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Directionality(
                //               textDirection: TextDirection.rtl,
                //               child: AddProductPage(),
                //             )));
                // AppCubit.get(context).emit(AppNewProductPage());
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<OperationsLogCubit, OperationsLogStates>(
        buildWhen: (previous, current) {
          if ([InitalStateOperationsLog].contains(current.runtimeType)) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          WidgetsBinding.instance?.addPostFrameCallback(
              (_) => {OperationsLogCubit.get(context).emit(state)});
          List<Map> operationlist =
              AppCubit.operationsDataList.reversed.toList();

          return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                final clint = AppCubit.clintsDataList.where((clint) =>
                    clint['ClintId'] == operationlist[index]['ClintId']);

                Map operation = {
                  'clint': clint.first,
                  'Operation': operationlist[index],
                };

                return buildOperationItem(operation, context);
                // if (productlist![index]['Deleted'] == 0) {
                //   isDeleted = false;
                //   return buildProductItem(Product(productlist![index]), context);
                // } else {
                //   isDeleted = true;
                //   return Container();
                // }
              },
              itemCount: operationlist.length);
        },
      ),
    );
  }
}
