import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'operations_log_States.dart';

class OperationsLogCubit extends Cubit<OperationsLogStates> {
  OperationsLogCubit() : super(InitalStateOperationsLog());

  static OperationsLogCubit get(context) => BlocProvider.of(context);
  static List<Map> clintslist = [];
  static List<Map> productslist = [];
  static List<Map> cartlist = [];

  static bool showCartList = true;

  void getdata() {
    getclints();
    getproducts();
  }

  void getclints() {
    clintslist = [];
    for (var item in AppCubit.clintsDataList) {
      if (item["Deleted"] != 1) {
        clintslist.add(item);
      }
    }
  }

  void getproducts() {
    productslist = [];
    for (var item in AppCubit.productDataList) {
      if (item["Deleted"] != 1) {
        productslist.add(item);
      }
    }
  }

  void showCart() {
    showCartList = !(showCartList);
    emit(ShowCartStateOperationsLog());
  }
}
