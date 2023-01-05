import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studiofoto/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
final Map product;

EditProduct({required this.product});
final _formKey= GlobalKey<FormState>();
TextEditingController _nameController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TextEditingController _priceController = TextEditingController();
TextEditingController _imageURLController = TextEditingController();
Future updateProduct() async{
final response = await http.put(
  Uri.parse(
    "http://127.0.0.1:8000/api/products/" + product['id'].toString()),
  body: {
  "name":_nameController.text,
  "description":_descriptionController.text,
  "price":_priceController.text,
  "image_url":_imageURLController.text

});
print(response.body);

return json.decode(response.body);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Product"),),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController..text = product['name'],
              decoration: InputDecoration(labelText: "Name"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter product name";
                }
                return null;
              },
            ),
             TextFormField(
              controller: _descriptionController..text = product['description'],
              decoration: InputDecoration(labelText: "Description"),
                validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter product description";
                }
                return null;
              },
            ),
             TextFormField(
                validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter product price";
                }
                return null;
              },
              controller: _priceController..text = product['Price'],
              decoration: InputDecoration(labelText: "Price"),
            ),
             TextFormField(
                validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter product imageURL";
                }
                return null;
              },
              controller: _imageURLController..text = product['image_url'],
              decoration: InputDecoration(labelText: "image_url"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  updateProduct().then((value) {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => Homepage()));
                  });
                }
            }, 
            child: Text("Update"))
            ],
         ),
      ),
    );
  }
}