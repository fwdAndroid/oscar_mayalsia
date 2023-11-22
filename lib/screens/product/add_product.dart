import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oscar_mayalsia/database/database_methods.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/main_dashborad.dart';
import 'package:oscar_mayalsia/widgets/textfieldwidget.dart';
import 'package:oscar_mayalsia/widgets/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;

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
  Uint8List? _image;
  List<File> _images = [];
  double val = 0;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

  bool _isLoading = false;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
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
              decoration: BoxDecoration(
                  color: Color(0xffFFBF00), shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
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
                  "Item Name",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Item Name',
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
                  "Item Description",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  controller: _controllerDescrition,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    fillColor: Colors.white,
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1, // <-- SEE HERE
                  maxLines: 10, // <-- SEE HERE
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
                  "Product Images",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 200,
                padding: EdgeInsets.all(4),
                child: GridView.builder(
                    itemCount: _images.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => choosesImage()),
                            )
                          : Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: FileImage(_images[index - 1]),
                                      fit: BoxFit.cover)),
                            );
                    }),
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
                    String rse = await DatabaseMethods().addProduct(
                      productUUid: uuid,
                      storeid: widget.storeid,
                      productImages: [_images.toString()],
                      file: _image!,
                      productDescription: _controllerDescrition.text,
                      productName: _controller.text,
                      price: int.parse(_price.text),
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    );

                    print(rse);
                    setState(() {
                      _isLoading = false;
                    });
                    if (rse == 'success') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => MainDashboard()));
                    } else {
                      showSnakBar(rse, context);
                    }
                  },
                  child: _isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Text("Create"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFBF00),
                      fixedSize: Size(250, 50)),
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

  choosesImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _images.add(File(pickedFile!.path));
    });
  }
}
