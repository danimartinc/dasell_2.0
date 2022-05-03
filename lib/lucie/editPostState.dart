import '../commons.dart';

import 'dart:async';


import 'package:DaSell/lucie/PostModel.dart';
import 'package:DaSell/lucie/editPost.dart';
import '../services/firebase/models/product_vo.dart';

abstract class EditPostState extends State<EditPost> {

  UserVo? adUser;
  var auth;

  ResponseProductVo get data => widget.data;
  final _firebaseService = FirebaseService.get();
  int current = 0;


  final TitleController = TextEditingController();
  final DescriptionController = TextEditingController();
  final PriceController = TextEditingController();
  final CategoryController = TextEditingController();
  final SubcategoryController = TextEditingController();


  @override
  void initState() {
    _loadData();

    super.initState();
  }

  Future<void> _loadData() async {


    auth = FirebaseAuth.instance;



    adUser = await _firebaseService.getUser(data.uid!);
    PostModel postModel = await _firebaseService.getPostData(data.id.toString());

    print(postModel.toJson());

    String cat = "";
    postModel.categories?.forEach((element) {
      cat = cat + element + ',';
    });

    TitleController.text = postModel.title!;
    DescriptionController.text = postModel.description!;
    PriceController.text = postModel.price.toString();
    CategoryController.text = cat;
    //SubcategoryController = data.
  }

  Future<void> updateData() async{

    List<String> cat = [];

    cat = CategoryController.text.split(',').toList();

    Map<String,dynamic> postdata = {
      "title": TitleController.text,
      "description":DescriptionController.text,
      "price":double.parse(PriceController.text),
      "categories":cat
    };

    await _firebaseService.updatePostData(data.id.toString(),postdata);

    print(data);

    Navigator.pop(context);

  }


  bool get hasAdUser => adUser != null;

  String get textPublicationDate {
    return AppUtils.publicationDate(data.createdAt?.toDate());
  }

  String get textAdUserName {
    if (adUser == null) return '-';
    return data.isMe ? 'Ti' : (adUser?.name ?? 'alguien');
  }

  String get textDescription => data.description ?? '-';

  bool get hasAddress {
    return data.location?.address?.isNotEmpty == true;
  }

  String get textAddress {
    return data.location?.address ?? '-';
  }

  void onCategoryTap(String category) {
    trace("Abrir categoria: $category");
  }






}