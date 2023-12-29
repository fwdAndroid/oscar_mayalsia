import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oscar_mayalsia/database/storage_methods.dart';
import 'package:oscar_mayalsia/screens/product/images_screens.dart';
import 'package:oscar_mayalsia/widgets/textfieldwidget.dart';
import 'package:oscar_mayalsia/widgets/utils.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  String storeid;
  AddProduct({
    super.key,
    required this.storeid,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerDescrition = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _productCategory = TextEditingController();
  TextEditingController _productSubCategory = TextEditingController();
  Uint8List? _image;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Product",
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
              height: 20,
            ),
            InkWell(
              onTap: () => selectImage(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 374,
                  height: 157,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xffD2D2D2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 59, backgroundImage: MemoryImage(_image!))
                          : Image.asset(
                              "assets/cam.png",
                              width: 51,
                              height: 39,
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Upload Product Image',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Product Name",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Product Name',
                textInputType: TextInputType.text,
                controller: _controller,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Product Description",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: TextFormInputField(
                  controller: _controllerDescrition,
                  hintText: "Description",
                  textInputType: TextInputType.text,
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Product Price",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Price'.trim(),
                textInputType: TextInputType.number,
                controller: _price,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Product Category",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Product Category',
                textInputType: TextInputType.text,
                controller: _productCategory,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Product SubCategory",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Product SubCategory',
                textInputType: TextInputType.text,
                controller: _productSubCategory,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var uuid = Uuid().v4();
                    setState(() {
                      _isLoading = true;
                    });
                    String photoURL = await StorageMethods()
                        .uploadImageToStorage('ProductPics', _image!, true);
                    await FirebaseFirestore.instance
                        .collection("products")
                        .doc(uuid)
                        .set({
                      "productName": _controller.text,
                      "productPrice": _price.text,
                      "productCategory": _productCategory.text,
                      "productSubCategory": _productSubCategory.text,
                      "productImage": photoURL,
                      "productImages": [],
                      "rating": 5.0,
                      "uuid": uuid,
                    });

                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ImagesScreens(
                                  uuid: uuid,
                                )));
                  },
                  child: _isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Text(
                          "Create",
                          style: TextStyle(color: Colors.white),
                        ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, fixedSize: Size(250, 50)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}
