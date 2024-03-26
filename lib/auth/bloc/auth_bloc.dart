import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contactapp/auth/model/user_model.dart';
import 'package:contactapp/core/database/user_local_database.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthRegisterEvent>((event, emit) {
      var db = UserLocalDatasource.instance;
      emit(AuthCheck());
      db.register(event.user).then((value) {
        log("REGISTEEEEEER $value");
      }).onError((error, stackTrace) {
        emit(AuthFailed());
      });
    });
    on<AuthLoginEvent>((event, emit)  {
      var db = UserLocalDatasource.instance;
      emit(AuthCheck());
      db.login(event.email, event.password).then((value) async{
        log("LOGIIIIN ${value.email}");
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", value.email);
        emit(AuthSuccess());
      }).onError((error, stackTrace) {
        emit(AuthFailed());
      });
    });
  }
}
