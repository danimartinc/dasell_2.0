import 'package:DaSell/commons.dart';
import 'package:DaSell/const/colors.dart';
import 'package:DaSell/data/categories.dart';
import 'package:DaSell/screens/tabs/home/widgets/ad_item_widget.dart';
import 'package:flutter/cupertino.dart';

import 'home_appbar.dart';
import 'home_state.dart';
import 'widgets/no_products.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = './home_screen';

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenState {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onFilterTap: onFilterTap,
        onSearchTap: onSearchTap,
        onSortTap: onSortTap,
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: onRefreshPullDown,
        header: WaterDropHeader(
          complete: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.done,
                color: Colors.grey,
              ),
              Container(
                width: 15.0,
              ),
              Text(
                'Publicaciones actualizadas',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 110,
              color: appBarColor,
              width: double.infinity,
              alignment: Alignment.center,
              child: FilterCategories(
                index: selectedCategoryIndex,
                categories: categories,
                onSelect: onCategorySelected,
              ),
            ),
            Expanded(child: getContent()),
          ],
        ),
      ),
    );
  }

  Widget getContent() {
    if (isLoading) {
      return CommonProgress();
    }
    if (currentProducts.isEmpty) {
      return NoProducts(
        category: selectedCategory,
        onAddTap: onAddTap,
      );
    }
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: currentProducts.length,
      itemBuilder: (context, i) {

        final vo = currentProducts[i];
        vo.tag = 'home_${ vo.id }';
        
        return AdItemWidget(
          data: vo,
          onTap: () => onItemTap(vo),
          onLikeTap: () => onItemLike(vo),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 2,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}

class FilterCategories extends StatelessWidget {
  
  final List<CategoryItemVo> categories;
  final int index;
  final ValueChanged<int> onSelect;

  const FilterCategories({
    Key? key,
    required this.categories,
    this.index = -1,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var i = 0;
    final items = categories.map((e) {
      var categoryId = i++;
      var selected = categoryId == index;
      return FilterCategoryItem(
        icon: e.icon,
        name: e.name,
        active: selected,
        onTap: () {
          onSelect(selected ? -1 : categoryId);
          // trace("Category tap; ", name);
        },
      );
    }).toList();
    return ListView(
      scrollDirection: Axis.horizontal,
      children: items,
      itemExtent: 90,
      cacheExtent: 10,
    );
  }
}

class FilterCategoryItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String name;
  final IconData icon;
  final bool active;

  const FilterCategoryItem({
    Key? key,
    this.onTap,
    this.active = false,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Icon(
                icon,
                size: 35,
                color: active ? Colors.grey : white,
              ),
            ),
            kGap6,
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.button!.copyWith(color: black),
              // TextStyle(color: white),
            ),
          ],
        ),
      ),
    );
  }
}
