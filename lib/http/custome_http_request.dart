import 'dart:convert';
import 'package:second_api_project/models/CategoryModel.dart';
import 'package:second_api_project/models/ProductModel.dart';
import 'package:second_api_project/models/order_model.dart';
import 'package:second_api_project/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class CustomHttpRequest {

  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
    "Authorization":
        "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY1NDAwNzYwNiwiZXhwIjoxNjY2OTY3NjA2LCJuYmYiOjE2NTQwMDc2MDYsImp0aSI6IjlLWGFGNmRFdlgwWVNZVzIiLCJzdWIiOjUwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Cbii274lgjkMIf2Ix9fZ7e8HPAT47B5MV0QP03Rd520",
  };

  static String uri = "https://apihomechef.antopolis.xyz/api/admin";

  static String registration = '/create/new/admin';
  static String login = '/sign-in';
  static String orderApi = "/all/orders";
  static String categoryApi = "/category";
  static String productApi = "/products";


  late SharedPreferences sharedPreferences;
  Future<Map<String, String>> getHeaderWithToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}",
    };
    print("Token is ${sharedPreferences.getString("token")} ");

    return header;
  }



  fetchOrderData() async {
    List<OrderModel> orderList = [];
    late OrderModel orderModel;

    var responce = await http.get(Uri.parse('${CustomHttpRequest.uri}${CustomHttpRequest.orderApi}'),
        headers: await CustomHttpRequest().getHeaderWithToken() );

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("Order list are $data");
      for (var item in data) {
        orderModel = OrderModel.fromJson(item);
        orderList.add(orderModel);
      }
    }

    return orderList;
  }

  fetchCategoryData() async {
    List<CategoryModel> categoryList = [];
    late CategoryModel categoryModel;

    var responce = await http.get(Uri.parse('${CustomHttpRequest.uri}${CustomHttpRequest.categoryApi}'),
        headers: await CustomHttpRequest().getHeaderWithToken() );

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("Order list are $data");
      for (var item in data) {
        categoryModel = CategoryModel.fromJson(item);
        categoryList.add(categoryModel);
      }
    }

    return categoryList;
  }

  fetchProductData() async {
    List<ProductModel> productList = [];
    late ProductModel productModel;

    var responce = await http.get(Uri.parse('${CustomHttpRequest.uri}${CustomHttpRequest.productApi}'),
        headers: await CustomHttpRequest().getHeaderWithToken() );

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("Product list are $data");

      for (var item in data) {
        productModel = ProductModel.fromJson(item);
        productList.add(productModel);
      }
    }

    return productList;
  }

  static Future<dynamic> deleteCategory(int id) async {
    var responce = await http.delete(
        Uri.parse(
            "https://apihomechef.antopolis.xyz/api/admin/category/$id/delete"),
        headers: await CustomHttpRequest().getHeaderWithToken());

    if (responce.statusCode == 200) {
      showInToast("Category Item Deleted Successfully");
    } else {
      showInToast("PLs try again");
    }
  }

}
