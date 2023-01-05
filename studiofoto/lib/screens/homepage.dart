import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studiofoto/screens/add_product.dart';
import 'package:studiofoto/screens/edit_product.dart';
import 'package:studiofoto/screens/product_detail.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    Key?  key,
  }) : super(key: key);

  final String url = 'http://127.0.0.1:8000/api/products';
  

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Studio Foto"),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
          return  ListView.builder(

            itemCount: snapshot.data['data'].length,
            itemBuilder: (context, index) {
              return Container(
                height: 180,
                child: Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(product: snapshot.data['data']
                          [index],)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0)),
                          padding: EdgeInsets.all(5),
                          height: 120,
                          width: 120,
                          child: Image.network (
                            snapshot.data['data'][index]['image_url'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(snapshot.data['data'][index]['name'],
                                 style: TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold ),),
                              ),
                              Text(snapshot.data['data'][index]['description']),
                              Row(
                                mainAxisAlignment: 
                                MainAxisAlignment.spaceBetween,
                                
                                children: [
                                  GestureDetector(
                                    onTap: ()  {
                                      Navigator.push(context, 
                                      MaterialPageRoute(
                                        builder: (context) => 
                                        EditProduct(product: snapshot.data['data'][index],)));
                                    },
                                    child: Icon(Icons.edit)),
                                  Text(snapshot.data['data'][index]['price']
                                  .toString())
                                  
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                   
                  ),
                ),
              );
            }
          );
          }else{
            return Text('Data Error');
          }
        },
      )
      );
  }
}