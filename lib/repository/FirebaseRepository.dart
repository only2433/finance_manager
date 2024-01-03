import 'package:finance_manager/data/UserBalanceDataObject.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository
{
  late FirebaseAuth auth;

  FirebaseRepository()
  {
    auth = FirebaseAuth.instance;
  }

  FirebaseAuth getFirebaseAuth()
  {
    return auth;
  }

  Future<void> uploadUserBalanceData(UserBalanceDataObject data) async
  {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(data.toMap());
  }

  Future<UserBalanceDataObject> getUserBalanceData() async
  {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    if(snapshot.exists)
    {
      return UserBalanceDataObject.fromJson(snapshot.data()!);
    }
    else
    {
      throw Exception("No data found");
    }
  }

  Future<UserCredential> login(String email, String password) async
  {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async
  {
    await auth.signOut();
  }
}