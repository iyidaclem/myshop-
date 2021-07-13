import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

// stl
class EditProductScreen extends StatefulWidget {
  static const routeName = "./edit_product";
  @override
  _EditedProductScreenState createState() => _EditedProductScreenState();
}

class _EditedProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _editedProduct =
      Product(id: "", title: "", description: "", price: 0.0, imageUrl: "");
  var url = "";
  var _isLoading = false;
  void changeUrl(_) {
    setState(() {
      url = _imageUrlController.text;
    });
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != "") {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
       await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("An error occured"),
                  content: Text("Something went wrong"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Okay"))
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }

    // Navigator.of(context).pop();
  }

  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;

      if (productId != "") {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);

        _initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          "imageUrl": ""
        };

        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues["title"],
                      decoration: InputDecoration(
                          labelText: "Title", icon: Icon(Icons.title)),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter valid title";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: value.toString(),
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues["price"],
                      decoration: InputDecoration(
                        labelText: "Price",
                        icon: Icon(Icons.money),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter price";
                        }
                        if (double.parse(value) <= 0) {
                          return "Enter amount greater than 0";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value!),
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    TextFormField(
                        initialValue: _initValues["description"],
                        decoration: InputDecoration(
                            labelText: "Description",
                            icon: Icon(Icons.details)),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter valid input";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              title: _editedProduct.title,
                              description: value!,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl);
                        }),
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
                              // initialValue: _initValues[""],
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter valid input";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                    id: _editedProduct.id,
                                    isFavorite: _editedProduct.isFavorite,
                                    title: _editedProduct.title,
                                    description: _editedProduct.description,
                                    price: _editedProduct.price,
                                    imageUrl: value!);
                              }),
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
