import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uid;
  String productName;
  int prductPrice;
  String productUUid;
  String storeid;
  List<String> productImages;
  String image;
  String productDescription;

  ProductModel({
    required this.uid,
    required this.productImages,
    required this.productName,
    required this.storeid,
    required this.prductPrice,
    required this.productUUid,
    required this.productDescription,
    required this.image,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        "productUUid": productUUid,
        'image': image,
        "storeid": storeid,
        'uid': uid,
        'productImages': productImages,
        'prductPrice': prductPrice,
        'productDescription': productDescription,
        'productName': productName,
      };

  ///
  static ProductModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProductModel(
      productDescription: snapshot['productDescription'],
      uid: snapshot['uid'],
      storeid: snapshot['storeid'],
      productImages: snapshot['productImages'],
      productUUid: snapshot['productUUid'],
      prductPrice: snapshot['prductPrice'],
      image: snapshot['image'],
      productName: snapshot['productName'],
    );
  }
}
