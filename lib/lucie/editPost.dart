import 'dart:io';

import 'package:DaSell/lucie/user_details_state.dart';
import 'package:DaSell/lucie/widgets/ads_by_seller.dart';
import 'package:DaSell/screens/product_details/product_details_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../commons.dart';
import '../screens/product_details/widgets/widgets.dart';
import '../services/firebase/models/product_vo.dart';
import 'editPostState.dart';
import 'widgets/widgets.dart';

class EditPost extends StatefulWidget {
  final ResponseProductVo data;

  const EditPost({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  createState() => _EditPostState();
}

class _EditPostState extends EditPostState{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:ListView(
        children: [
          TextFormField(
            controller: TitleController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),
          TextFormField(
            controller: DescriptionController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),
          TextFormField(
            controller: PriceController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),
          TextFormField(
            controller: CategoryController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),

          InkWell(onTap: (){
            updateData();
          },child: Container(child: Text("click me"),))
        ],
      ),
    );
  }
}
