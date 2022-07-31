import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/widget.dart';

class DeletedPasswordsScreen extends StatefulWidget {
  DeletedPasswordsScreen({Key? key}) : super(key: key);

  @override
  State<DeletedPasswordsScreen> createState() => _DeletedPasswordsScreenState();
}

class _DeletedPasswordsScreenState extends State<DeletedPasswordsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayOutCubit, HomeLayOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayOutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.deletedPasswords.isNotEmpty,
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
          builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => passwordCard(cubit.deletedPasswords[index],context),
              separatorBuilder: (context, index) => SizedBox(
                    height: 3,
                  ),
              itemCount: cubit.deletedPasswords.length),
        );
      },
    );
  }
}