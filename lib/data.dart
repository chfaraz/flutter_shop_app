import 'package:flutter/material.dart';

class DataBlock extends ChangeNotifier {
  var _data;
  var _add;
  var _cart;
  var _list = List();
  var _empty = List();
  get data => _data;
  get add => _add;
  get cart => _cart;
  get list => _list;
  get empty => _empty;

  set data(var value) {
    _data = value;
    notifyListeners();
  }

  set add(int x) {
    _add = x;
    notifyListeners();
  }

  set cart(var dataa) {
    _cart = dataa;
    _list.add(_cart);
    print(_cart);
    notifyListeners();
  }

  setData(var dataa) {
    data = dataa;
  }

  setAdd(var num) {
    add = num;
  }

  setAddToCart(var data) {
    cart = data;
  }

  setQuantityPlus(var id) {
    list.forEach((item) => {
          if (item['id'] == id) {item['quantity']++}
        });

    print(list);
  }

  setQuantityMinus(var id) {
    list.forEach((item) => {
          if (item['id'] == id) {item['quantity']--}
        });

    print(_list);
  }

  deteteFromCart(var id) {
    var item = list.where((item) => (item['id'] != id)).toList();

    _list = item;
  }

  emptyList() {
    _list.clear();
    notifyListeners();
    print(_list);
  }
}
