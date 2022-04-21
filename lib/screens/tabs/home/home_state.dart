import 'package:DaSell/commons.dart';
import 'package:DaSell/data/categories.dart';
import 'package:DaSell/screens/home/search.dart';
import 'package:DaSell/screens/product_details/product_details.dart';
import 'package:DaSell/screens/tabs/home/widgets/sort_dialog.dart';
import 'package:DaSell/services/firebase/models/product_vo.dart';
import 'package:DaSell/widgets/home/filter.dart';
import 'package:location/location.dart';

abstract class HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver {
  final refreshController = RefreshController(initialRefresh: false);

  // no va mas esto.
  // var cats = Categories.storedCategories;

  /// improvisado para sacar el modelo de categorias.
  final categories = Categories.homeCategories;

  /// index de la categoria seleccionada.
  int selectedCategoryIndex = -1;

  /// atajo para tomar el Category model actual del index.
  CategoryItemVo? get selectedCategory {
    if (selectedCategoryIndex >= 0) {
      return categories[selectedCategoryIndex];
    }
    return null;
  }

  void onCategorySelected(int index) {
    selectedCategoryIndex = index;

    /// request data?
    // filterByCategory();
    applyFilters();
    update();
  }

  void applyFilters() {
    /// clean category name just in case, if it exists...
    /// if its null shows all.
    var categoryName = selectedCategory?.name.trim().toLowerCase();
    currentProducts = _allProducts.where(
      (product) {
        return product.showInFilter(
          category: categoryName,
          priceStart: priceRange.start,
          priceEnd: priceRange.end,
        );
      },
    ).toList();
  }

  // void filterByCategory(String? filterCategory) {
  //   if (filterCategory == null) {
  //     currentProducts = List.from(_allProducts);
  //     update();
  //     return;
  //   }
  //   filterCategory = filterCategory.trim().toLowerCase();
  //   trace(filterCategory);
  //   currentProducts = _allProducts.where((element) {
  //     var mainCategory = '';
  //     final list = element.categories;
  //     if (list?.isNotEmpty == true) {
  //       mainCategory = list!.first.trim().toLowerCase();
  //     }
  //     if (mainCategory == filterCategory) {
  //       return true;
  //     }
  //     return false;
  //   }).toList();
  //   update();
  // }

  final uid = FirebaseAuth.instance.currentUser!.uid;

  List<dynamic> documents = [];
  List<AdModel?> prods = [];
  var priceRange = RangeValues(0, 2000);
  final _service = FirebaseService.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _service.updateUserToken();
    _service.setUserOnline(true);
    _loadData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //Online
      _service.setUserOnline(true);
    } else if (state == AppLifecycleState.inactive) {
      //Offline
      _service.setUserOnline(false);
    }
    super.didChangeAppLifecycleState(state);
  }

  void onPriceRangeChanged(RangeValues rv) {
    priceRange = rv;

    /// apply filters.
    applyFilters();
    update();
  }

  void onFilterTap() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: FilterPriceDialog(
            onRangeSelected: onPriceRangeChanged,
            initialValue: priceRange,
          ),
        );
      },
    );
  }

  void onSearchTap() {
    showSearch(
      context: context,
      delegate: Search(
        data: _allProducts,
        onItemTap: onItemTap,
        onItemLike: onItemLike,
      ),
    );

    // void onItemTap(ResponseProductVo vo) {
    //   context.push(ProductDetails(data: vo,));
    //   // Navigator.of(context).pushNamed(
    //   //   ProductDetailScreen.routeName,
    //   //   arguments: {
    //   //     'docs': vo,
    //   //     'isMe': vo.isMe,
    //   //   },
    //   // );
    // }
    //
    // void onItemLike(ResponseProductVo vo) {
    //   FirebaseService.get().setLikeProduct(vo.id!, !vo.getFav());
    // }
  }

  void onSortTap() {
    showDialog(
      context: context,
      builder: (context) => SortDialog(onSelect: onSortSelected),
    );
  }

  void onSortSelected(int option) {
    if (option == 1) {
      /// cercanos
      sortByClosest();
    } else {
      /// recientes
      sortByNewest();
    }
  }

  void sortByNewest() {
    currentProducts.sort((a, b) {
      return a.createdAt!.compareTo(b.createdAt!);
    });
    update();
  }

  void sortByClosest() async {
    final location = Location();
    final locData = await location.getLocation();
    print('locations is ${locData.latitude},${locData.longitude}');
    final adProvider = Provider.of<AdProvider>(context, listen: false);
    for (int i = 0; i < currentProducts.length; i++) {
      final vo = currentProducts[i];
      vo.fromLoc = adProvider.getDistanceFromCoordinates2(
        vo.location!.latitude!,
        vo.location!.longitude!,
        locData.latitude!,
        locData.longitude!,
      );
    }
    currentProducts.sort((m1, m2) => m1.fromLoc.compareTo(m2.fromLoc));
    update();
  }

  List<ResponseProductVo> _allProducts = [];
  List<ResponseProductVo> currentProducts = [];
  bool isLoading = false;

  Future<void> _loadData() async {
    currentProducts.clear();
    _allProducts.clear();
    isLoading = true;
    update();
    final products = await _service.getProducts();
    if (products == null) {
      trace('Error cargando productos.');
    } else {
      _allProducts.addAll(products);
    }
    currentProducts = List.from(_allProducts);
    isLoading = false;
    update();
  }

  Future<void> onRefreshPullDown() async {
    await Future.delayed(Duration(milliseconds: 100));
    await _loadData();
    refreshController.refreshCompleted();
  }

  void onItemTap(ResponseProductVo vo) {
    context.push(ProductDetails(
      data: vo,
    ));
    // Navigator.of(context).pushNamed(
    //   ProductDetailScreen.routeName,
    //   arguments: {
    //     'docs': vo,
    //     'isMe': vo.isMe,
    //   },
    // );
  }

  void onItemLike(ResponseProductVo vo) {
    vo.toggleLike();
  }

  void onAddTap() {
    Provider.of<MenuProvider>(context, listen: false).setIndex(2);
  }
}
