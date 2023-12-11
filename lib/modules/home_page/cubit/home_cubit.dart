import 'package:el_zahraa_app/models/product.dart';
import 'package:el_zahraa_app/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  static List<Map> clintslist = [];
  static List<Map> productslist = [];
  static bool showClintListBoolean = true;
  static bool showProductListBoolean = true;

  void getData() {
    getClintList();
    getProductList();
  }

  void getTodayIncome() {}
  void getClintList() {
    try {
      final match = AppCubit.clintsDataList.where((clint) {
        DateTime lastPaidDate = DateTime.parse(clint["LastPaidDate"]);
        DateTime todayDate = DateTime.now();
        Duration durationvalue = todayDate.difference(lastPaidDate);
        int deadline = clint["PaymentDeadline"];
        if (durationvalue.inDays < deadline) {
          return false;
        } else {
          return true;
        }
      });
      clintslist = match.toList();
    } catch (e) {
      print(e.toString());
    }
  }

  void getProductList() {
    try {
      final match = AppCubit.productDataList.where((product) {
        double currentAmount = product["Quantity"];
        double minimumAmount = product["MinimumQuantity"];

        if (currentAmount > minimumAmount) {
          return false;
        } else {
          return true;
        }
      });
      productslist = match.toList();
    } catch (e) {
      print(e.toString());
    }
  }

  void showClintList() {
    showClintListBoolean = !(showClintListBoolean);
    emit(ShowClintListHome());
  }

  void showProductList() {
    showProductListBoolean = !(showProductListBoolean);
    emit(ShowProductListHome());
  }
}
