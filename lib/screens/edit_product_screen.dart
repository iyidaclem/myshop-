import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

// stl
class EditProductScreen extends StatefulWidget {
  static const routeName = "./edit_product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editProduct = Product(
      id: "", title: "title", description: "", price: 0.0, imageUrl: "");
  var url = "";
  void changeUrl(_) {
    setState(() {
      url = _imageUrlController.text;
    });
  }

  _saveForm() {
    final isValid = _form.currentState!.validate();
    if(!isValid){return;} 
    _form.currentState!.save();
    Provider.of<Products>(context,listen: false).addProduct(_editProduct);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Title", icon: Icon(Icons.title)),
                textInputAction: TextInputAction.next,
                validator:(value){
                  if(value!.isEmpty){
                    return "Enter valid input";
                  }
                  return null;
                },
                onSaved: (value) {
                 _editProduct =  Product(
                      id: _editProduct.id,
                      title: value.toString(),
                      description: _editProduct.description,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Price", icon: Icon(Icons.money),),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator:(value){
                  if(value!.isEmpty){
                    return "Enter valid input";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct =  Product(
                      id: _editProduct.id,
                      title: _editProduct.title,
                      description: _editProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editProduct.imageUrl);
                },
              ),

              TextFormField(
                decoration: InputDecoration(
                    labelText: "Description", icon: Icon(Icons.details)),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator:(value){
                  if(value!.isEmpty){
                    return "Enter valid input";
                  }
                  return null;
                },
                onSaved:(value){
                  _editProduct =  Product(
                      id: _editProduct.id,
                      title: _editProduct.title,
                      description: value!,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl);
                }
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )),
                    child: _imageUrlController.text == ""
                        ? Text("Enter a URL")
                        : Image.network(_imageUrlController.text,
                            fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Image Url",
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onChanged: (e) => {changeUrl("")},
                      onFieldSubmitted: (e) {
                        _saveForm();
                      },
                      validator:(value){
                        if(value!.isEmpty){
                          return "Enter valid input";
                        }
                        return null;
                      },
                      onSaved:(value){
                        _editProduct =  Product(
                      id: _editProduct.id,
                      title: _editProduct.title,
                      description: _editProduct.description,
                      price: _editProduct.price,
                      imageUrl: value!);
                      }
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
