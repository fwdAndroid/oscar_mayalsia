import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/main_dashborad.dart';

class CurrentOrderDetail extends StatefulWidget {
  final image;
  final prductPrice;
  final productDescription;
  final productName;
  final productUUid;
  final storeAddress;
  final productQuantity;
  final storeName;
  final storeid;
  CurrentOrderDetail(
      {super.key,
      required this.productQuantity,
      required this.image,
      required this.prductPrice,
      required this.productDescription,
      required this.productName,
      required this.productUUid,
      required this.storeAddress,
      required this.storeName,
      required this.storeid});

  @override
  State<CurrentOrderDetail> createState() => _CurrentOrderDetailState();
}

class _CurrentOrderDetailState extends State<CurrentOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Order Detail",
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
            SizedBox(
              height: 10,
            ),
            Container(
              child: Image.network(
                widget.image,
                fit: BoxFit.fitWidth,
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
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
              child: Text(widget.productName),
            ),
            Divider(),
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
              child: Text(widget.productDescription),
            ),
            Divider(),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Product Quantity",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.productQuantity.toString()),
            ),
            Divider(),
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
              child: Text(widget.prductPrice.toString()),
            ),
            Divider(),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Store Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.storeName.toString()),
            ),
            Divider(),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "Store Address",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.storeAddress.toString()),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("orders")
                          .doc(widget.productUUid)
                          .update({
                        'orderstatus': 'completed',
                      }).then((value) => {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Order is Delivered")))
                              });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => MainDashboard()));
                    },
                    child: Text("Mark Order As Complete")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
