import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({super.key});

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FirebaseAuth.instance.currentUser != null
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('storeid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("orderstatus", isEqualTo: "initialized")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     '29 Decemeber 2002',
                        //     textAlign: TextAlign.start,
                        //     style:
                        //         TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                        //   ),
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                final DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];
                                return Column(
                                  children: [
                                    ListTile(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (builder) =>
                                          //         CurrentOrderDetail(
                                          //       image: documentSnapshot[
                                          //               'productImage']
                                          //           .toString(),
                                          //       prductPrice: documentSnapshot[
                                          //           'productPrice'],
                                          //       productDescription:
                                          //           documentSnapshot[
                                          //               'productDescription'],
                                          //       productName: documentSnapshot[
                                          //           'productName'],
                                          //       productUUid: documentSnapshot[
                                          //           'productId'],
                                          //       storeAddress: documentSnapshot[
                                          //           'storeaddress'],
                                          //       storeName: documentSnapshot[
                                          //           'storeName'],
                                          //       storeid:
                                          //           documentSnapshot['storeid'],
                                          //       productQuantity:
                                          //           documentSnapshot[
                                          //               'productQuantity'],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              documentSnapshot['productImage']
                                                  .toString()),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Product Name"),
                                            Text(documentSnapshot[
                                                'productName']),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Product Description"),
                                            Text(documentSnapshot[
                                                'productDescription']),
                                          ],
                                        ),
                                        trailing: TextButton(
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection("orders")
                                                .doc(documentSnapshot.id)
                                                .update({"chat": 'yes'});
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (builder) =>
                                            //             ChatPage(
                                            //               storeid:
                                            //                   documentSnapshot[
                                            //                       'storeid'],
                                            //             )));
                                          },
                                          child: Text("Chat"),
                                        )),
                                    Divider()
                                  ],
                                );
                              }),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                })
            : const Center(
                child: Text('No Appointment CurrentOrders'),
              ),
      ),
    );
  }
}
