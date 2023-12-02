import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/invoice_api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleController extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = true;

  User? _user;

  User? get user => _user;

  shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('user_id');
    return  userId;
  }

  Future<void> restoreSignInStatus(BuildContext context, ControllerCart controllerCart, InvoiceController controllerInvoice) async {
    _user = await _auth.currentUser;
      int? userId = user?.uid.hashCode;
      controllerCart.getCart(userId!);
      controllerInvoice.getInvoice(userId);
    isLoading = false;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      _user = authResult.user;
      isLoading = false;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', _user!.uid);

      notifyListeners();
    } catch (error) {
      final snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    _user = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');

    notifyListeners();
  }
}