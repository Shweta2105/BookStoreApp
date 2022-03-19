import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/providers/books.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBookScreen extends StatefulWidget {
  static const String routeName = '/editbook';

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _form = GlobalKey<FormState>();
  var _editedProduct = Book(id: '', title: '', author: '', price: 0, image: '');
  final _priceFocusNode = FocusNode();

  final _authorFocusNode = FocusNode();

  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  var _isInit = true;
  var isLoading = false;

  var _initValues = {
    'title': '',
    'author': '',
    'price': '',
    'image': '',
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImage);
    super.initState();
  }

  void didChangeDependencies() {
    if (_isInit) {
      final bookId = ModalRoute.of(context)?.settings.arguments;

      if (bookId != null) {
        var prodId = bookId as String;
        _editedProduct =
            Provider.of<Books>(context, listen: false).findById(prodId);

        _initValues = {
          'title': _editedProduct.title,
          'author': _editedProduct.author,
          'price': _editedProduct.price.toString(),
          'image': '',
        };

        _imageController.text = _editedProduct.image;
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _authorFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });
    if (_editedProduct.id != '') {
      await Provider.of<Books>(context, listen: false)
          .updateBook(_editedProduct.id, _editedProduct);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      await Provider.of<Books>(context, listen: false)
          .addBook(_editedProduct)
          .catchError((e) {
        return showDialog<Null>(
            context: context,
            builder: (c) => AlertDialog(
                  title: const Text("An error occured.!"),
                  content: const Text("Something went wrong..!"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(c).pop();
                        },
                        child: const Text('OK'))
                  ],
                ));
      }).then((_) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_authorFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide value';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Book(
                              id: '',
                              title: value!,
                              author: _editedProduct.author,
                              price: _editedProduct.price,
                              image: _editedProduct.image);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['author'],
                        decoration: InputDecoration(labelText: 'Author'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide value';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Book(
                              id: '',
                              title: _editedProduct.title,
                              author: value!,
                              price: _editedProduct.price,
                              image: _editedProduct.image);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'],
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_imageFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a price.';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter valid number.';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please enter a number greater then zero.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Book(
                              id: '',
                              title: _editedProduct.title,
                              author: _editedProduct.author,
                              price: double.parse(value!),
                              image: _editedProduct.image);
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 10, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _imageController.text.isEmpty
                                ? Text('add image URL')
                                : FittedBox(
                                    child: Image.network(
                                      _imageController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageController,
                            focusNode: _imageFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an image URL';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please entera valid URL';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter valid image URL';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Book(
                                  id: '',
                                  title: _editedProduct.title,
                                  author: _editedProduct.author,
                                  price: _editedProduct.price,
                                  image: value!);
                            },
                          ))
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
