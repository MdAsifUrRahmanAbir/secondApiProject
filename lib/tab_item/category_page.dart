import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:second_api_project/controller/catagory_controller.dart';
import 'package:second_api_project/screen/add_catagory.dart';
import 'package:second_api_project/widget/brand_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CatagoryController>(context, listen: false).getCatagoryData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<CatagoryController>(context).catagoryList;
    final category = Provider.of<CatagoryController>(context);

    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          child: categoryList.isNotEmpty
              ? NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    setState(() {
                      if (notification.direction == ScrollDirection.forward) {
                        _bottomVisible = true;
                      } else if (notification.direction ==
                          ScrollDirection.reverse) {
                        _bottomVisible = false;
                      }
                    });
                    return true;
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              Column(
                                children: [

                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://apihomechef.antopolis.xyz/images/${categoryList[index].image ?? ""}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Expanded(
                                          child: Text(
                                            categoryList[index].name ?? "",
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                width: 0.1),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5)),
                                          ),
                                          child: TextButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.edit,
                                                  size: 15,
                                                  color: aTextColor,
                                                ),
                                                Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                    color: aTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              /*Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) {
                                              return CategoryEditPage(
                                                id: categories
                                                    .categoriesList[index].id,
                                                index: index,
                                                name: categories.categoriesList[index].name,
                                              );
                                            })).then((value) => categories.getCategories(context,onProgress));*/
                                            },
                                          ),
                                        )),
                                        Container(
                                          height: 30,
                                          width: 0.5,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                width: 0.1),
                                            borderRadius: const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(5)),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Are you sure ?'),
                                                      titleTextStyle: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: aTextColor),
                                                      titlePadding:
                                                          const EdgeInsets.only(
                                                              left: 35,
                                                              top: 25),
                                                      content: const Text(
                                                          'Once you delete, the item will gone permanently.'),
                                                      contentTextStyle:
                                                          const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  aTextColor),
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 35,
                                                              top: 10,
                                                              right: 40),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                border: Border.all(
                                                                    color:
                                                                        aTextColor,
                                                                    width:
                                                                        0.2)),
                                                            child: const Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      aTextColor),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .redAccent
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      aPriceTextColor),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            /*    CustomHttpRequest.deleteCategoryItem(
                                                      context,
                                                      categories
                                                          .categoriesList[
                                                      index]
                                                          .id)
                                                      .then((value) =>
                                                  value);
                                                  setState(() {
                                                    categories
                                                        .categoriesList
                                                        .removeAt(
                                                        index);
                                                  });
                                                  Navigator.pop(
                                                      context);*/
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.delete,
                                                  size: 15,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                right: 55,
                                top: 80,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: aTextColor, width: 0.5)),
                                  child: Center(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://apihomechef.antopolis.xyz/images/${categoryList[index].icon ?? ""}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : const SpinKitThreeInOut(
            color: Colors.orange,
            size: 50.0,
          )

      ),
      floatingActionButton: _bottomVisible == true
          ? FloatingActionButton(
              onPressed: () {
                /*   Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCategory())).then((value) => categories.getCategories(context,onProgress));
        */
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCategory()))
                    .then((value) => category.getCatagoryData());
              },
              backgroundColor: aBlackCardColor,
              child: const Icon(
                Icons.add,
                size: 30,
                color: aPrimaryColor,
              ),
            )
          : null,
    );
  }

  bool onProgress = false;
  bool _bottomVisible = true;
  //ScrollController? _scrollController;
}
