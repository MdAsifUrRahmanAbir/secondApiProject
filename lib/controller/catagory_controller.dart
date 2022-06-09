

// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:second_api_project/http/custome_http_request.dart';
import 'package:second_api_project/models/CategoryModel.dart';
import 'package:second_api_project/models/order_model.dart';

class CatagoryController with ChangeNotifier {
  List<CategoryModel> catagoryList = [];

  getCatagoryData()async {
    catagoryList = await CustomHttpRequest().fetchCategoryData();
    notifyListeners();
  }

}