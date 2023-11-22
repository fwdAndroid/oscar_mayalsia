import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oscar_mayalsia/database/storage_methods.dart';
import 'package:oscar_mayalsia/models/product_model.dart';
import 'package:oscar_mayalsia/models/store_models.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String> profileDetailEmailAdd() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal
      StoreModel userModel = StoreModel(
          email: FirebaseAuth.instance.currentUser!.email!,
          photoUrl: FirebaseAuth.instance.currentUser!.photoURL!,
          type: 'StoreOwner',
          name: FirebaseAuth.instance.currentUser!.displayName!,
          uid: FirebaseAuth.instance.currentUser!.uid,
          phoneNumber: "");
      await firebaseFirestore
          .collection('storeowners')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            userModel.toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Profile Details
  Future<String> profileDetailEmail({
    required String email,
    required String uid,
    required String name,
    required bool verified,
    required String type,
    required String dob,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || name.isNotEmpty) {
        //Add User to the database with modal
        String photoURL = await StorageMethods()
            .uploadImageToStorage('StoreOwnerPics', file, false);
        StoreModel userModel = StoreModel(
          name: name,
          dob: dob,
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: FirebaseAuth.instance.currentUser!.email.toString(),
          type: type,
          photoUrl: photoURL,
          phoneNumber: phoneNumber,
        );
        await firebaseFirestore
            .collection('storeowners')
            .doc(uid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Store
  Future<String> store({
    required String uid,
    required String name,
    required String address,
    required String type,
    required bool verified,
    required String email,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';

    try {
      if (name.isNotEmpty || address.isNotEmpty) {
        //Add User to the database with modal
        String photoURL = await StorageMethods()
            .uploadImageToStorage('StorePics', file, false);
        StoreModel userModel = StoreModel(
          type: type,
          name: name,
          address: address,
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          photoUrl: photoURL,
          phoneNumber: phoneNumber,
        );
        await firebaseFirestore
            .collection('storesList')
            .doc(uid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Add product
  Future<String> addProduct({
    required String uid,
    required String productName,
    required String productDescription,
    required Uint8List file,
    required String productUUid,
    required List<String> productImages,
    required String storeid,
    required int price,
  }) async {
    String res = 'Some error occured';

    try {
      if (productName.isNotEmpty || productDescription.isNotEmpty) {
        String photoURL = await StorageMethods()
            .uploadImageToStorage('ProductPics', file, true);
        var uuid = Uuid().v4();

        //Add User to the database with modal
        // String photoURL = await StorageMethods()
        //     .uploadImageToStorage('ProductPics', images as Uint8List, false);
        ProductModel userModel = ProductModel(
          storeid: storeid,
          productImages: productImages,
          productName: productName,
          prductPrice: price,
          productDescription: productDescription,
          productUUid: uuid,
          image: photoURL,
          uid: FirebaseAuth.instance.currentUser!.uid,
        );
        await firebaseFirestore
            .collection('products')
            .doc(uuid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
