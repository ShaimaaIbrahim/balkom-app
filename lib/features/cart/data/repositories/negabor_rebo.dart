import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/features/cart/data/models/attrbut_cmodel.dart';
import 'package:ojos_app/features/cart/domin/entities/negabor_entity.dart';

Future<List<NegaItem>> getNega({city_id = 1}) async {
  Dio dio = Dio();
  Response response = await dio.get(API_NEGA(city_id: city_id));

  if (response.statusCode == 200) {
    print(response.data);

    return NegaModel.fromJson(response.data).result;
  } else {
    throw "Cant get Data";
  }
}

Future<Attrbuotmodel?>? getAttrbuot() async {
  Dio dio = Dio();
  Response response = await dio.get(atteripiot_APi);
  try {
    if (response.statusCode == 200) {
      print(response.data);

      return Attrbuotmodel.fromJson(response.data);
    } else {
      throw "Cant get Data";
    }
  } catch (e) {
    print(e);
  }
}

//Future<List<Deliveryto>?>
getAttrbuotloadproduct() async {
  Dio dio = Dio();
  Response response = await dio.get(atteripiot_APi);

  try {
    if (response.statusCode == 200) {
      print(response.data);
      return Attrbuotmodel.fromJson(response.data).result!.loadproduct!;
    } else {
      throw "Cant get Data";
    }
  } catch (e) {
    print(e);
  }
}

//Future<List<Deliveryto>?>
getAttrbuotprayerPlace() async {
  Dio dio = Dio();
  Response response = await dio.get(atteripiot_APi);
  try {
    if (response.statusCode == 200) {
      print(response.data);
      return Attrbuotmodel.fromJson(response.data!).result!.desttype!;
    } else {
      throw "Cant get Data";
    }
  } catch (e) {
    print(e);
  }
}
