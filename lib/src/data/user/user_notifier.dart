
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/data/authentication.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier(auth : ref.watch(authProvider));
});


class UserNotifier extends StateNotifier<User?> {
  UserNotifier({required this.auth}) : super(null);
  Authentication auth;

  Future getUser(BuildContext context)async{
    try{
      final result = await auth.signInWithGoogle(context: context);
      state = result;
      return true;
    }catch (e){
      return false;
    }
  }

  Future setUser()async{
    final User result = await auth.initializeFirebase();
    state = result;
    return result;
  }


}
