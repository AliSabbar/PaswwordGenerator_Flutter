import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_generator/layout/cubit/cubit.dart';
import 'package:password_generator/layout/cubit/states.dart';

import '../../shared/components/widget.dart';

class PasswordsScreen extends StatefulWidget {
  PasswordsScreen({Key? key}) : super(key: key);

  @override
  State<PasswordsScreen> createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayOutCubit, HomeLayOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayOutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.myPasswords.isNotEmpty,
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
          builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => passwordCard(cubit.myPasswords[index],context),
              separatorBuilder: (context, index) => SizedBox(
                    height: 3,
                  ),
              itemCount: cubit.myPasswords.length),
        );
      },
    );
  }
}
