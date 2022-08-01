import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_generator/layout/cubit/states.dart';
import 'package:password_generator/shared/network/local/shared_helpder.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/deletedPassScreen copy/deleted_passwords_screen.dart';
import '../../modules/passwordsScreen/passwords_screen.dart';
import 'package:password_generator/layout/home_layout.dart';

class HomeLayOutCubit extends Cubit<HomeLayOutStates> {
  HomeLayOutCubit() : super(InitialAppState());
  static HomeLayOutCubit get(context) => BlocProvider.of(context);
  int current_index = 0;
  bool isDark = false;
  bool isBottom = false;
  IconData iconBottom = Icons.add;
  List<Widget> screen = [
    PasswordsScreen(),
    DeletedPasswordsScreen(),
  ];
  // DataBase
  Database? database;
  List<Map> myPasswords = [];
  List<Map> deletedPasswords = [];

  void changeIndex(index) {
    current_index = index;
    emit(ChangeBottomIndexState());
  }

  void changeBottomSheet({required bool bot, required IconData icon}) {
    iconBottom = icon;
    isBottom = bot;
    emit(ChangeBottomSheetState());

  }

// Password Generate
  String generatePassword(
  {
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }
  ) {
    final passwordLength = MyHomePage.lengthController.text;
    final length = int.parse(passwordLength);
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';
    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  //  Data Base

  void createDatabase() {
    openDatabase('passapp.db', version: 1, onCreate: (database, version) {
      print("DataBase Created");
      database
          .execute(
              'CREATE TABLE passgen(id INTEGER PRIMARY KEY , title TEXT , length TEXT , color TEXT , password TEXT , status TEXT)')
          .then((value) {
        print("Table Created ");
      }).catchError((e) {
        print("Error when Created Table ${e.toString()}");
      });
    }, onOpen: (database) {
      getDataFromDataBase(database);
      print("Database Opened");
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  insertDataToDataBase({
    required String title,
    required String length,
    required String color,
    required String password,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO passgen(title , length , color , password , status) VALUES("$title" , "$length" , "$color" , "$password" ,"new")')
          .then((value) {
        getDataFromDataBase(database);
        print("${value.toString()} inserted successfully");
        emit(InsertDataToDataBaseState());
      }).catchError((e) {
        print("Error when Inserted Records ${e.toString()}");
      });
    });
  }

  getDataFromDataBase(database) async {
    myPasswords = [];
    deletedPasswords = [];
    emit(LoadingDataState());
    await database!.rawQuery('SELECT * FROM passgen').then((value) {
      value.forEach((e) {
        if (e['status'] == "new") myPasswords.add(e);
        if (e['status'] == "deleted") deletedPasswords.add(e);
      });
      print(myPasswords);
    }).catchError((e) {
      print("Error when get Data${e.toString()}");
    });
    emit(GetDataFromDataBaseState());
  }

  void updateDataFromDataBase({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate('UPDATE passgen SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(UpdateDataFromDataBaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM passgen WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(DeleteDataFromDataBaseState());
    });
  }
}
