import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_generator/layout/cubit/cubit.dart';
import 'package:password_generator/layout/cubit/states.dart';

import '../../shared/components/widget.dart';

class PasswordsScreen extends StatelessWidget {
    PasswordsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayOutCubit, HomeLayOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayOutCubit.get(context);
        return cardBuilder(context: context, list: cubit.myPasswords,condition: cubit.myPasswords.isNotEmpty);
      },
    );
  }
}
