import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_generator/shared/cubit/states.dart';

import '../network/local/shared_helpder.dart';

class myCubit extends Cubit<MyAppStates> {
  myCubit() : super(InitialState());
  static myCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

   void changeTheme({bool? isPrefs}) {
    if (isPrefs != null) {
      isDark = isPrefs;
      emit(ChangeThemeModeState());
    } else {
      isDark = !isDark;
      SharedHelper.savePreferences(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
      }).catchError((e) {
        print(e.toString());
      });
    }
  }
}
