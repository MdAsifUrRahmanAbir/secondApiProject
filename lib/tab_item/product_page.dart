import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:second_api_project/controller/product_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductController>(context, listen: false).getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final productList = Provider.of<ProductController>(context).productList;
    final product = Provider.of<ProductController>(context);

    return SafeArea(child: Scaffold(
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
            child:Text("Total Product Is: ${productList.length}") ,
          ),

          const SizedBox(height: 10,),

          Expanded(
              child: productList.isNotEmpty
                  ? ListView.builder(
                  itemCount: productList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.only(left: 22, top: 10, right: 10, bottom: 10),

                      decoration: BoxDecoration(
                          // image: DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage(
                          //         "https://apihomechef.antopolis.xyz/images/${productList[index].image}"
                          //     )),
                          borderRadius: BorderRadius.circular(23),

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
                          Expanded(child: Image.network("https://apihomechef.antopolis.xyz/images/${productList[index].image}")),

                          const SizedBox(width: 5,),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Order Id: ${productList[index].id}"),
                                Text("Name: ${productList[index].name}"),
                                Text("Price: ${productList[index].price![0].originalPrice}"),
                              ],
                            ),
                          ),

                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text("Payment Status"),
                              productList[index].isAvailable==1?
                              const Text("Available.", style: TextStyle(color: Colors.green),)
                                  :const Text("Unavailable.", style: TextStyle(color: Colors.red)),
                            ],
                          ),)

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
    ));
  }
}
