import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_generator/shared/components/widget.dart';
import 'package:password_generator/shared/cubit/cubit.dart';
import 'package:password_generator/shared/styles/colors.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var textfieldKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  static var lengthController = TextEditingController();
  var colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayOutCubit, HomeLayOutStates>(
      listener: (context, state) {
        if (state is InsertDataToDataBaseState) Navigator.pop(context);
      },
      builder: (context, state) {
        var cubit = HomeLayOutCubit.get(context);
        var cubit2 = myCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Passwordic"),
            actions: [
              IconButton(
                onPressed: () {
                  cubit2.changeTheme();
                },
                icon: cubit2.isDark
                    ? Icon(Icons.sunny)
                    : Icon(
                        Icons.dark_mode,
                      ),
              ),
              IconButton(
                onPressed: () {
                  showMyDialog(context);
                },
                icon: Icon(Icons.info),
              ),
            ],
            centerTitle: false,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.current_index,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.lock), label: "My Passowrds"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.delete), label: "Deleted Passowrds"),
            ],
          ),
          body: cubit.screen[cubit.current_index],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottom) {
                if (textfieldKey.currentState!.validate()) {
                  cubit.insertDataToDataBase(
                    title: titleController.text,
                    length: lengthController.text,
                    color: colorController.text,
                    password: cubit.generatePassword(),
                  );
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet((context) => Form(
                          key: textfieldKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextField(
                                  labelText: "Password Title",
                                  hintText: "Enter Password Title",
                                  prefixIcon: Icon(Icons.title),
                                  controller: titleController,
                                  validator: (v) {
                                    if (v!.isEmpty)
                                      return "this field musn't be empty ! ";
                                  }),
                              defaultTextField(
                                  keyboardType: TextInputType.phone,
                                  labelText: "Password Length",
                                  hintText: "Enter Password Length",
                                  prefixIcon: Icon(Icons.password),
                                  controller: lengthController,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "no";
                                    }
                                    if (v.contains(
                                        RegExp(r'^\D+|(?<=\d),(?=\d)'))) {
                                      return "Enter Only Numbers ! ";
                                    }
                                    final length = int.parse(v!);
                                    if (length >= 31) {
                                      return "Length must be only 30 or less";
                                    }
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    chooseCardColor(
                                      backgroundColor: Colors.amber,
                                      onTap: () {
                                        colorController.text = "FFC107";
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    chooseCardColor(
                                      backgroundColor: Colors.pinkAccent,
                                      onTap: () {
                                        colorController.text = "FF4081";
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    chooseCardColor(
                                      backgroundColor: Colors.indigoAccent,
                                      onTap: () {
                                        colorController.text = "536DFE";
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    chooseCardColor(
                                      backgroundColor: cubit2.isDark
                                          ? Colors.white
                                          : Colors.black12,
                                      onTap: () {
                                        colorController.text = "FFFFFF";
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    chooseCardColor(
                                      backgroundColor: Colors.black,
                                      onTap: () {
                                        colorController.text = "000000";
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    chooseCardColor(
                                      backgroundColor: Colors.red,
                                      onTap: () {
                                        colorController.text = "F44336";
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ))
                    .closed
                    .then((value) {
                  cubit.changeBottomSheet(icon: Icons.add, bot: false);
                });
                cubit.changeBottomSheet(icon: Icons.done, bot: true);
              }
            },
            child: Icon(cubit.iconBottom),
          ),
        );
      },
    );
  }
}
