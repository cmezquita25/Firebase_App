import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/domain/inputs/sign_up.dart';
import 'package:flutter_firebase/app/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;
  SignUpRepositoryImpl(this._auth);
  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      await userCredential.user!.updateDisplayName(
        // ignore: unnecessary_string_interpolations
        "${data.name}",
      );
      return SignUpResponse(null, userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(
        parseStringToSignUpError(e.code),
        null,
      );
    }
  }
}
