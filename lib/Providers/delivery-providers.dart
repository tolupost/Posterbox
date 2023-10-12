
import 'package:flutter/material.dart';

import '../models/delivery.dart';


class DeliveryProvider extends ChangeNotifier {
  Delivery _delivery = Delivery(
      deliveryfee: '',
      deliveryinstructions: '',
      deliverytimeline: '',
      deliveryweight: '',
      progress: '',
      recevieraddress: '',
      receviername: '',
      senderaddress: '',
      sendername: '',
      usernumber: '',
      username: '',
      receviernumber: '',
      sendernumber:'',
      deliverydate:'',
      state1: '',
      state2: '',
      start: 0,
      end: 0,
      wallet: false, senderusername: '', deliverId: '', userId: ''

  );

  Delivery get delivery => _delivery;

  void setDelivery(String delivery) {
    _delivery = Delivery.fromJson(delivery);
    notifyListeners();
  }

  void setDeliveryFromModel(Delivery delivery) {
    _delivery = delivery;
    notifyListeners();
  }
}