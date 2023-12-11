//import 'dart:io';
import 'package:el_zahraa_app/models/clinte.dart';
import 'package:el_zahraa_app/models/product.dart';
import 'package:el_zahraa_app/modules/clints_page/view_clint_page.dart';
import 'package:el_zahraa_app/modules/store_page/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_zahraa_app/shared/cubit/states.dart';
import 'package:el_zahraa_app/modules/clints_page/clints_page.dart';
import 'package:el_zahraa_app/modules/home_page/home_page.dart';
import 'package:el_zahraa_app/modules/newoperation_page/new_operation_page.dart';
import 'package:el_zahraa_app/modules/operationes_page/operationes_log_page.dart';
import 'package:el_zahraa_app/modules/store_page/store_page.dart';
//import 'package:path_provider/path_provider.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> selecteditem = [
    MyHomePage(),
    MyOperationPage(),
    MyNewOperationPage(),
    MyClintsPage(),
    MyStorePage(),
  ];
  static List<Map> clintsDataList = [];
  static List<Map> productDataList = [];
  static List<Map> operationsDataList = [];
  static List<Map> operationDetailsDataList = [];

  void changeIndex(int index) {
    currentindex = index;

    switch (index) {
      case 0:
        emit(AppHomePage());
        break;
      case 1:
        emit(AppOperationsPage());
        break;
      case 2:
        emit(AppNewOperationPage());
        break;
      case 3:
        emit(AppClintsPage());
        break;
      case 4:
        emit(AppStorePage());
        break;
    }
  }

  //String? path;
  String tableCustomersData = 'CustomersData';
  String tableCustomersOperations = 'CustomersOperations';
  String tableOperationsDetials = 'OperationsDetials';
  String tableProductsStore = 'ProductsStore';
  String tableStoreOperation = 'StoreOperation';

  // void createTabel({required String tablecontent, required String tablename}) {
  //   database!.execute(tablecontent).then((value) {
  //     print("TABLE $tablename created");
  //   }).catchError((error) {
  //     print("Error when creating TABLE $tablename ${error.toString()}");
  //   });
  // }

  // void createDataBase() {
  //   // if (database != null) {
  //   //   return database!;
  //   // }

  //   //String path = join(await getDatabasesPath(), 'El_Zhraa.db');
  //   try {
  //     String path = join(getDatabasesPath().toString(), 'El_Zhraa.db');

  //     openDatabase(
  //       path,
  //       version: 1,
  //       onCreate: (db, version) {
  //         print("database created");
  //         database = db;
  //         createTabel(
  //             tablecontent: 'CREATE TABLE $tableCustomersData ' +
  //                 '(ClintId INTEGER PRIMARY KEY autoincrement,' +
  //                 'FullName TEXT,' +
  //                 'PhoneNumber TEXT,' +
  //                 'CommercialRegister TEXT,' +
  //                 'Taxcard TEXT,' +
  //                 'Address TEXT,Notes TEXT,' +
  //                 'AddtionDate TEXT,' +
  //                 'OperationCount INTEGER,' +
  //                 'Balance REAL,' +
  //                 'LastPaidDate TEXT,' +
  //                 'PaymentDeadline INTEGER,' +
  //                 'Notify INTEGER,' +
  //                 'Deleted INTEGER)',
  //             tablename: '$tableCustomersData');

  //         createTabel(
  //             tablecontent: 'CREATE TABLE $tableCustomersOperations ' +
  //                 '(OperationId INTEGER PRIMARY KEY,' +
  //                 'ClintId INTEGER,' +
  //                 'OperationDescribe TEXT,' +
  //                 'OperationNotes TEXT,' +
  //                 'OperationDate TEXT,' +
  //                 'Discount REAL,' +
  //                 'Required REAL,' +
  //                 'Paid REAL,' +
  //                 'Residual REAL,' +
  //                 'LastBalance REAL,' +
  //                 'CurrentBalance REAL)',
  //             tablename: '$tableCustomersOperations');
  //         createTabel(
  //             tablecontent: 'CREATE TABLE $tableOperationsDetials ' +
  //                 '(ProductId INTEGER,' +
  //                 'OperationId INTEGER,' +
  //                 'ClintId INTEGER,' +
  //                 'Price REAL,' +
  //                 'Quantity REAL,' +
  //                 'TotalPrice REAL)',
  //             tablename: '$tableOperationsDetials');

  //         createTabel(
  //             tablecontent: 'CREATE TABLE $tableProductsStore ' +
  //                 '(ProductId INTEGER,' +
  //                 'ProductName TEXT,' +
  //                 'Price REAL,' +
  //                 'Quantity REAL,' +
  //                 'QuantityPerTon REAL,' +
  //                 'MinimumQuantity REAL,' +
  //                 'Deleted INTEGER)',
  //             tablename: '$tableProductsStore');

  //         createTabel(
  //             tablecontent: 'CREATE TABLE $tableStoreOperation ' +
  //                 '(ProductId INTEGER,' +
  //                 'OperationId INTEGER,' +
  //                 'OperationDescribe TEXT,' +
  //                 'Quantity REAL,' +
  //                 'OperationDate TEXT)',
  //             tablename: '$tableStoreOperation');
  //       },
  //       onOpen: (database) {
  //         print("database opend");
  //         database
  //             .query(tableCustomersData)
  //             .then((value) => clintsDataList = value);
  //         print(clintsDataList);
  //         emit(AppGetDataBaseState());
  //         print("dataaaaa gated");
  //       },
  //     ).then((value) {
  //       database = value;
  //       emit(AppCreatDataBaseState());
  //     });
  //   } catch (error) {
  //     print("my erroooor" + error.toString());
  //   }
  // }

  // Future<int> creatCustomer(Clint clint) async {
  //   emit(AppCreateClint());
  //   Database db = database!;
  //   int? id;
  //   db.insert(tableCustomersData, clint.toMap()).then((value) {
  //     id = value;

  //     clintsDataList = getCustomersData();
  //   });

  //   return id!;
  // }

  // List<Map> getCustomersData() {
  //   emit(AppGetDataBaseState());
  //   database!.query(tableCustomersData).then((value) {
  //     clintsDataList = value;
  //     try {
  //       print(clintsDataList[clintsDataList.length - 1]["FullName"]);
  //     } catch (ero) {
  //       print("لا يوجد عملاء");
  //     }
  //     emit(AppClintsPage());
  //   });

  //   return clintsDataList;
  // }

  // Future<int> updateCustomer(Clint customer) async {
  //   Database db = database!;
  //   return await db.update(tableCustomersData, customer.toMap(),
  //       where: 'id = ?', whereArgs: [customer.id]);
  // }

  // Future deleteCustomer(int id) async {
  //   Database db = database!;
  //   db.execute(
  //       'update $tableCustomersData Set Deleted = 1 Where ClintId =$id ');
  // }

  void navigateTo(context, newRoute, state) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: newRoute,
                )));
    emit(state);
  }

  void navigateAndremove(context, newRoute) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: newRoute,
                )),
        (route) => false);
  }

//for testing
  void testCreateLists() {
    operationDetailsDataList = [
      {
        'OperationId': 02155,
        'ProductId': 1,
        'Quantity': 20,
        'Price': 100.0,
      }
    ];
    operationsDataList = [
      {
        'OperationId': 02155,
        'ClintId': 1,
        'Describtion': "فاتورة + خصم",
        'Date': "2022-02-11 23:31:46.545913",
        'Required': 500.0,
        'Discount': 300.0,
        'Paid': 200.0,
        'BalanceBefore': 1200.0,
        'BalanceAfter': 1200.0,
        'Notes': "لا يوجد"
      },
    ];
    clintsDataList = [
      {
        'ClintId': 1,
        'FullName': "علي",
        'PhoneNumber': "01111111111",
        'CommercialRegister': "135-12564-54146",
        'Taxcard': "565456",
        'Address': "القاهرة",
        'Notes': "لديه حساب بنكي 56454560540545",
        'AddtionDate': "15/05/2021",
        'OperationCount': 0,
        'Balance': 1500.0,
        'LastPaidDate': "2022-01-01 23:31:46.545913",
        'PaymentDeadline': 50,
        'Notify': 1,
        'Deleted': 0,
      },
      {
        'ClintId': 2,
        'FullName': "ابراهيم",
        'PhoneNumber': "02222222222",
        'CommercialRegister': "000-12564-54146",
        'Taxcard': "321231",
        'Address': "دمياط",
        'Notes': "لا يوجد",
        'AddtionDate': "16/05/2021",
        'OperationCount': 0,
        'Balance': 0.0,
        'LastPaidDate': "2022-01-01 23:31:46.545913",
        'PaymentDeadline': 50,
        'Notify': 1,
        'Deleted': 0,
      },
      {
        'ClintId': 3,
        'FullName': "السيد",
        'PhoneNumber': "033333333333",
        'CommercialRegister': "111-12564-54146",
        'Taxcard': "7897897",
        'Address': "العبور",
        'Notes': "لا يوجد",
        'AddtionDate': "18/07/2021",
        'OperationCount': 0,
        'Balance': 20000.0,
        'LastPaidDate': "2021-10-01 23:31:46.545913",
        'PaymentDeadline': 50,
        'Notify': 1,
        'Deleted': 0,
      },
    ];
    productDataList = [
      {
        'ProductId': 1,
        'ProductName': "دقيق",
        'Price': 100.0,
        'Quantity': 40.0,
        'QuantityPerTon': 20.0,
        'MinimumQuantity': 40.0,
        'Deleted': 0
      },
      {
        'ProductId': 2,
        'ProductName': "عدس",
        'Price': 70.0,
        'Quantity': 90.0,
        'QuantityPerTon': 40.0,
        'MinimumQuantity': 100.0,
        'Deleted': 0
      },
      {
        'ProductId': 3,
        'ProductName': "رز",
        'Price': 150.0,
        'Quantity': 1000.0,
        'QuantityPerTon': 25.0,
        'MinimumQuantity': 60.0,
        'Deleted': 0
      },
    ];
  }

  void testAddClint(Map clint) {
    emit(AppInsertDataBaseState());
    clint['ClintId'] = clintsDataList[clintsDataList.length - 1]['ClintId'] + 1;
    clintsDataList.add(clint);
    emit(AppNewClintPage());
  }

  List<Map> testgetClints() {
    return clintsDataList;
  }

  void testEditClint(Map clint) {
    int oldid;
    int newid;
    for (var item in clintsDataList) {
      oldid = item['ClintId'];
      newid = clint['ClintId'];
      if (oldid == newid) {
        item['FullName'] = clint['FullName'];
        item['PhoneNumber'] = clint['PhoneNumber'];
        item['Address'] = clint['Address'];
        item['Taxcard'] = clint['Taxcard'];
        item['CommercialRegister'] = clint['CommercialRegister'];
        item['PaymentDeadline'] = clint['PaymentDeadline'];
        item['Notify'] = clint['Notify'];
        item['Notes'] = clint['Notes'];
        ViewClintPage.clint = Clint.fromMap(item);
        emit(AppUpdateDataBaseState());
      }
    }
  }

  void testDeleteClints(Map clint) {
    int oldid;
    int newid;
    for (var item in clintsDataList) {
      oldid = item['ClintId'];
      newid = clint['ClintId'];
      if (oldid == newid) {
        item['Deleted'] = 1;

        emit(AppUpdateDataBaseState());
      }
    }
  }

  void testAddProduct(Map product) {
    product['ProductId'] =
        productDataList[productDataList.length - 1]['ProductId'] + 1;
    productDataList.add(product);
    emit(AppInsertDataBaseState());
  }

  List<Map> testgetProducts() {
    return productDataList;
  }

  void testEditProduct(Map product) {
    int oldid;
    int newid;
    for (var item in productDataList) {
      oldid = item['ProductId'];
      newid = product['ProductId'];
      if (oldid == newid) {
        item['ProductName'] = product['ProductName'];
        item['Price'] = product['Price'];
        item['Quantity'] = product['Quantity'];
        item['QuantityPerTon'] = product['QuantityPerTon'];
        item['MinimumQuantity'] = product['MinimumQuantity'];

        ViewProductPage.product = Product.fromMap(item);
        emit(AppUpdateDataBaseState());
      }
    }
  }

  void testDeleteProduct(Map product) {
    int oldid;
    int newid;
    for (var item in productDataList) {
      oldid = item['ProductId'];
      newid = product['ProductId'];
      if (oldid == newid) {
        item['Deleted'] = 1;

        emit(AppUpdateDataBaseState());
      }
    }
  }
}
