import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_api_project/controller/catagory_controller.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {


  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CatagoryController>(context,listen: false).getCatagoryData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final catagoryList = Provider.of<CatagoryController>(context).catagoryList;

    return Scaffold();
  }
}
