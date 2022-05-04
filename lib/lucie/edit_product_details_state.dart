import '../commons.dart';

import 'dart:async';


import 'package:DaSell/models/edit_product.dart';
import 'package:DaSell/lucie/edit_product_details.dart';
import '../services/firebase/models/product_vo.dart';

abstract class EditPostState extends State<EditProductDetails> {

  UserVo? adUser;
  var auth;

  ResponseProductVo get data => widget.data;
  final _firebaseService = FirebaseService.get();
  int current = 0;


  final TextEditingController TitleController = TextEditingController();
  final DescriptionController = TextEditingController();
  final PriceController = TextEditingController();
  final CategoryController = TextEditingController();
  final SubcategoryController = TextEditingController();

  final double? containerHeight = 80;



  @override
  void initState() {
    _loadData();

    super.initState();
  }

  Future<void> _loadData() async {


    auth = FirebaseAuth.instance;



    adUser = await _firebaseService.getUser(data.uid!);
    EditProduct postModel = await _firebaseService.getPostData(data.id.toString());

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
      "description": DescriptionController.text,
      "price": double.parse(PriceController.text),
      "categories": cat
    };

    await _firebaseService.updatePostData( data.id.toString(), postdata );

    print(data);

    Navigator.pop(context);

  }


  bool get hasAdUser => adUser != null;

  String get textPublicationDate {
    return AppUtils.publicationDate(data.createdAt?.toDate());
  }

  String get textAdUserName {
    if (adUser == null) return '-';
    return data.isMe ? 'Ti' : (adUser?.name ?? 'Alguien');
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


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String title      = '';
  String desc       = '';
  String prevValue = '';

  Map<String?, String?> sliderValueMap = {
    '0': 'Lo ha dado todo',
    '25': 'En condiciones aceptables',
    '50': 'En buen estado',
    '75': 'Como nuevo',
    '100': 'Nuevo',
  };

  double? sliderValue = 50.0;
  //var textController = TextEditingController();
  var counterText = 0;
  var isLogin = true;
  bool makeShipments = true;

  void trySubmit() {

    final isValidate = formKey.currentState!.validate();
    
    //to remove soft keyboard after submitting
    FocusScope.of(context).unfocus();
    
    if (isValidate) {

      formKey.currentState!.save();

      Provider.of<AdProvider>(
        context,
        listen: false,
      ).addTitleAndStuff(
        title,
        desc,
        sliderValueMap[ sliderValue!.toInt().toString() ],
        makeShipments
      );

      //Navigator.of(context).pushReplacementNamed( AddingImagesScreen.routeName );
    }
  }

  Widget counter(
    BuildContext context, {
    int? currentLength,
    int? maxLength,
    required bool isFocused,
  }) {

    return Text(
      '$currentLength / $maxLength',
      style: TextStyle(
        color: Colors.grey,
      ),
      semanticsLabel: 'character count',
    );
  }

  void onSwitchShipmentsChanged( value ) {

    setState(() {
      makeShipments = value;
    });
                      
  }

  String? titleValidator( String? value ) {

    if ( value!.length > 8 ) {
      return null;
    } else {
      return 'El título debe contener más de 8 caracteres';
    }

  }

  String? onDescriptionChanged( String? value ) {

    if ( prevValue.length > value!.length) {
      setState(() {
        counterText--;
      });
    } else {
      setState(() {
        counterText++;
      });
    }
    
    prevValue = value;
    return null;

  }






}