
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_auth_repository.dart';


final authenticationProvider = Provider<FirebaseAuthRepository>((ref) {
  return FirebaseAuthRepository();
});


final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChanges();
});

final fireBaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});