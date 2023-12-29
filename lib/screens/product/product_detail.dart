import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/main_dashborad.dart';

class ProductDetail extends StatefulWidget {
  final ProductName;
  final ProductDescritption;
  final ProductImage;
  final ProductPrice;
  final productImages;
  final productUuod;
  final productCategory;
  final productSubCategory;
  final productRating;
  ProductDetail(
      {super.key,
      required this.productUuod,
      required this.productImages,
      required this.productCategory,
      required this.productRating,
      required this.productSubCategory,
      required this.ProductDescritption,
      required this.ProductImage,
      required this.ProductName,
      required this.ProductPrice});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Product Detail",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(
                widget.ProductImage,
                fit: BoxFit.fitWidth,
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
            Divider(
              color: Colors.blue.withOpacity(.4),
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Product Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.ProductName),
            ),
            Divider(
              color: Colors.blue.withOpacity(.4),
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Product Category",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.productCategory),
            ),
            Divider(
              color: Colors.blue.withOpacity(.4),
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Product Sub Category",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.productSubCategory),
            ),
            Divider(
              color: Colors.blue.withOpacity(.4),
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Product Description",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.ProductDescritption),
            ),
            Divider(
              color: Colors.blue.withOpacity(.4),
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Product Price",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.ProductPrice.toString()),
            ),
            Divider(
              color: Colors.blue.withOpacity(.4),
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Product Images",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              height: 160,
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: GridView.builder(
                  itemCount: widget.productImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(widget.productImages.toString()),
                      ),
                    );
                  }),
            ),
            Divider(
              color: Colors.blue.withOpacity(.4),
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Rating",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.productRating.toString()),
            ),
            Divider(
              color: Colors.blue.withOpacity(.4),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: const Text('Delete Alert'),
                                content: const Text(
                                    'Are You Sure To Delete This Product'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("products")
                                          .doc(widget.productUuod)
                                          .delete()
                                          .then((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Product Delete Successfully"),
                                                  ),
                                                ),
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            MainDashboard()))
                                              });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ]));
                  },
                  child: Text(
                    "Delete Product",
                    style: TextStyle(color: Colors.blue),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
