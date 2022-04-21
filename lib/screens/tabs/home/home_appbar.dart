import 'package:DaSell/commons.dart';

import 'header_logo.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onFilterTap, onSortTap, onSearchTap;

  const HomeAppBar({
    Key? key,
    this.onFilterTap,
    this.onSortTap,
    this.onSearchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: HeaderLogo(),
      actions: [
        IconButton(
          icon: Icon(FontAwesomeIcons.funnelDollar, size: 19),
          onPressed: onFilterTap,
        ),
        IconButton(
          icon: Icon(
            Icons.sort_outlined,
          ),
          onPressed: onSortTap,
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.search, size: 19),
          onPressed: onSearchTap,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
