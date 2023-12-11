import 'package:el_zahraa_app/modules/newoperation_page/new_operation_states.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewOperationCubit extends Cubit<NewOperationStates> {
  NewOperationCubit() : super(InitalStateNewOperation());

  static NewOperationCubit get(context) => BlocProvider.of(context);
  static List<Map> clintslist = [];
  static List<Map> productslist = [];
  static List<Map> cartlist = [];

  static bool showCartList = true;
  static bool discountBoolean = false;
  static bool paymentBoolean = false;

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

  void addToCart(item) {
    cartlist.add(item);
    emit(AddProductsStateNewOperation());
  }

  void removeFromCart(index) {
    cartlist.removeAt(index);
    emit(RemoveProductsStateNewOperation());
  }

  void showCart() {
    showCartList = !(showCartList);
    emit(ShowCartStateNewOperation());
  }

  void saveOperation(item) {
    AppCubit.operationsDataList.add(item);
    for (var product in cartlist) {
      Map operationItem = {
        'OperationId': item['OperationId'],
        'ProductId': product['ProductId'],
        'Quantity': product['Quantity'],
        'Price': product['Price'],
      };
      AppCubit.operationDetailsDataList.add(operationItem);
    }
    cartlist.clear();
    emit(OperationSavedNewOperation());
  }
}
