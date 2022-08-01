import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/widget.dart';

class DeletedPasswordsScreen extends StatelessWidget {
  DeletedPasswordsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayOutCubit, HomeLayOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayOutCubit.get(context);
        return cardBuilder(context: context, list: cubit.deletedPasswords,condition: cubit.deletedPasswords.isNotEmpty);
      },
    );
  }
}