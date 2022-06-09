import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:second_api_project/controller/order_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrderController>(context,listen: false).getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final orderList = Provider.of<OrderController>(context).orderList;

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
            child:Text("Total Order Is: ${orderList.length}") ,
          ),

          const SizedBox(height: 10,),

          Expanded(
            child: orderList.isNotEmpty
                ? ListView.builder(
                itemCount: orderList.length,
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
                            Text("Order Id: ${orderList[index].id}"),
                            Text("Status: ${orderList[index].orderStatus!.orderStatusCategory!.name}"),
                            Text("Price: ${orderList[index].price}"),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Payment Status"),
                            orderList[index].payment?.paymentStatus==1?
                            const Text("Payment Done.", style: TextStyle(color: Colors.green),)
                                :const Text("Payment Due.", style: TextStyle(color: Colors.red)),
                          ],
                        ),

                      ],
                    ),
                  );
                })
                : const SpinKitThreeInOut(
              color: Colors.orange,
              size: 50.0,
            )
          ),
        ],
      ),
    );
  }
}
