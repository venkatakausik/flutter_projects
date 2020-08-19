import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import '../db/category.dart';
import '../db/product.dart';
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  ProductService _productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  File _image;
  bool isLoading= false;
  bool available = false;
  @override
  void initState(){
    _getCategories();
    //_currentCategory = categoriesDropDown[0].value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(Icons.close,
          color: black,),
          onPressed: ()=>Navigator.pop(context),
        ),
        title: Text(
          "Add Product",
          style: TextStyle(color: black),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: isLoading ? CircularProgressIndicator():Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide:
                            BorderSide(color: grey.withOpacity(0.8), width: 2.0),
                        onPressed: () {
                          // ignore: deprecated_member_use
                          _selectImage(ImagePicker.pickImage(source: ImageSource.gallery));
                        },
                        child: displayChild(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: "Product Name",
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return "You must enter the product name";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Price",
                    hintText: "Price",
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return "You must enter the product name";
                    }
                  },
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children:<Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Category',style: TextStyle(color: Colors.red,),),
                ),
                DropdownButton(items: categoriesDropDown, onChanged: changeSelectedCategory,value: _currentCategory,),
                    Row(
                      children: <Widget>[
                        Text('Available'),
                        SizedBox(width: 10,),
                        Switch(value: available, onChanged: (value){
                          setState(() {
                            available = value;
                          });
                        }),
                      ],
                  ),
                ],
              ),
    FlatButton(
                color : Colors.red,
                textColor: white,
                child: Text('Add Product'),
                onPressed: (){
                  validateAndUpload();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = List();
    for(int i=0;i<categories.length;i++){
      setState(() {
        items.insert(0, DropdownMenuItem(child: Text(categories[i].data['name']),
        value: categories[i].data['name'],
        ));
      });
    }
    return items;
  }

   _getCategories() async{
     List<DocumentSnapshot> data = await _categoryService.getCategories();
     setState(() {
       categories = data;
       categoriesDropDown = getCategoriesDropDown();
       _currentCategory = categories[0].data['name'];
     });
   }

  changeSelectedCategory(String selectedCategory) {
    setState(()=>_currentCategory= selectedCategory);
  }

  void _selectImage(Future<File> pickImage) async{
    _image = await pickImage;
  }

  Widget displayChild() {
    if(_image == null){
      return  Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 50, 14, 50),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    }
    else{
      return  Image.file(_image,fit:BoxFit.fill,width: double.infinity,);
    }
  }
  void validateAndUpload() async {
    if(_formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      if(_image!=null){
        String imageUrl;
        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture = '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        StorageUploadTask task = storage.ref().child(picture).putFile(_image);
        task.onComplete.then((snapshot) async{
          imageUrl = await snapshot.ref.getDownloadURL();
          _productService.uploadProduct(productName: productNameController.text,price: double.parse(priceController.text),image: imageUrl,available:available,category: _currentCategory);
          _formKey.currentState.reset();
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "Product added");
          Navigator.pop(context);
        });
      }else{
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Image must be provided");
      }
    }
  }

}
