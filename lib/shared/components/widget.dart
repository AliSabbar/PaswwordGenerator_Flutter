import 'package:conditional_builder/conditional_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_generator/layout/cubit/cubit.dart';
import 'package:password_generator/shared/styles/colors.dart';

Widget passwordCard(model, context) {
  String color = model['color'];
  return Dismissible(
    background: Container(
      color: Colors.red,
      child: Center(
        child: Text(
          "Delete",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    ),
    key: ValueKey(model['id'].toString()),
    onDismissed: (dirction) {
      if (model['status'] == "new")
        HomeLayOutCubit.get(context)
            .updateDataFromDataBase(id: model['id'], status: 'deleted');
      if (model['status'] == "deleted")
        HomeLayOutCubit.get(context).deleteData(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: color==""?Colors.white:HexColor(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: 100,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.link,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              title: Text(
                model['title'],
                style: TextStyle(
                  color: color == "000000" ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                model['password'],
                style: TextStyle(color: color == "000000" ? Colors.grey : null),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                          onPressed: () {
                            if (HomeLayOutCubit.get(context).current_index ==
                                0) {
                              final data =
                                  ClipboardData(text: model['password']);
                              Clipboard.setData(data);
                              defaultToast(
                                  message:
                                      "${model['title']} Password copied Successfully");
                            } else {
                              HomeLayOutCubit.get(context)
                                  .updateDataFromDataBase(
                                      id: model['id'], status: 'new');
                            }
                          },
                          icon: Icon(
                            HomeLayOutCubit.get(context).current_index == 0
                                ? Icons.copy
                                : Icons.restart_alt,
                            color: Colors.white,
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget cardBuilder({
  required context,
  required List<Map> list,
  required bool condition,
}) {
  return ConditionalBuilder(
    condition: condition,
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.password,
            color: Colors.grey,
            size: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "You Don't have any passwords yet",
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => passwordCard(list[index], context),
        separatorBuilder: (context, index) => SizedBox(
              height: 3,
            ),
        itemCount: list.length),
  );
}

void navigateTo({
  required context,
  required Widget widget,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateAndFinish({
  required Widget widget,
  required context,
}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

Widget defaultTextField({
  required String labelText,
  required String hintText,
  required Widget prefixIcon,
  required TextEditingController? controller,
  Widget? suffixIcon,
  TextInputType? keyboardType,
  bool obscureText = false,
  bool readOnly = false,
  bool enableInteractiveSelection = true,
  required String? Function(String?) validator,
  Function(String)? onChanged,
  ValueChanged<String>? onFieldSubmitted,
  VoidCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorHeight: 20,
      autofocus: false,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      enableInteractiveSelection: enableInteractiveSelection,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}

Widget chooseCardColor({
  required VoidCallback? onTap,
  required Color backgroundColor,
  double? radius,
}) {
  return InkWell(
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    onTap: onTap,
    child: CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
    ),
  );
}

Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('About The App'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('⨀ Pull right or left to delete the password'),
              SizedBox(
                height: 10,
              ),
              Text(
                  '⨀ If you accidentally delete your password you can find it in deleted screen'),
              SizedBox(
                height: 10,
              ),
              Text(
                  '⨀ Pull right or left again in deleted passwords screen to deleted completely '),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("dev by AliSabbar"),
              ),
            ],
          ),
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void defaultToast({
  required String message,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
