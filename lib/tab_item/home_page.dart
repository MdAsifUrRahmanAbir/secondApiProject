import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:second_api_project/http/custome_http_request.dart';
import 'package:second_api_project/models/order_model.dart';
import 'package:second_api_project/screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<OrderModel> orderData = [];
  late OrderModel orderModel;



  fetchOrderData() async {
    var responce = await http.get(Uri.parse('${CustomHttpRequest.uri}${CustomHttpRequest.orderApi}'),
        headers: await CustomHttpRequest().getHeaderWithToken() );

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("Order list are $data");
      for (var item in data) {
        orderModel = OrderModel.fromJson(item);
        setState(() {
          orderData.add(orderModel);
        });
      }
    }
  }





  @override
  void initState() {
    // TODO: implement initState
    fetchOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10,),

          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 22, top: 10, right: 10, bottom: 10),

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: Colors.white,
                boxShadow:  [
                  BoxShadow(
                      color: const Color(0xff000000).withOpacity(.05),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: const Offset(0, 2)
                  )
                ]

            ),
            child:Text("Total Order Is: ${orderData.length}") ,
          ),

          const SizedBox(height: 10,),

          Expanded(
            child: ListView.builder(
                itemCount: orderData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: 85,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.only(left: 22, top: 10, right: 10, bottom: 10),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: Colors.white,
                        boxShadow:  [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(.05),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 2)
                          )
                        ]

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Id: ${orderData[index].id}"),
                            Text("Status: ${orderData[index].orderStatus!.orderStatusCategory!.name}"),
                            Text("Price: ${orderData[index].price}"),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Payment Status"),
                            orderData[index].payment?.paymentStatus==1?
                            const Text("Payment Done.", style: TextStyle(color: Colors.green),)
                                :const Text("Payment Due.", style: TextStyle(color: Colors.red)),
                          ],
                        ),

                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
