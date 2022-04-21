import 'package:flutter/cupertino.dart';
import 'package:DaSell/interface/models/place.dart';
import 'package:DaSell/interface/ui/detail/place_detail_screen.dart';


import '../../../commons.dart';
import 'widgets/place_card.dart';
import 'widgets/travel_navigation_bar.dart';




class FeedScreen extends StatelessWidget {

  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     final menuProviderIndex = Provider.of<MenuProvider>(context).index;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        leading: IconButton(
          icon: const Icon( CupertinoIcons.search ), 
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon( CupertinoIcons.star ), 
            onPressed: () {},
          ),       
        ],
      ),
      body: ListView.builder(
        itemCount: TravelPlace.places.length,
        itemExtent: 350,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, kToolbarHeight + 20),
        itemBuilder: ( context, index ) {

          final place = TravelPlace.places[index];
          
           return Hero(
            tag: place.id,
            child: Material(
              child: PlaceCard(
                place: place,
                onPressed: () async {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) => FadeTransition(
                        opacity: animation,
                        child: PlaceDetailScreen(
                          place: place,
                          screenHeight: MediaQuery.of(context).size.height,
                 ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ), 
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.location_on),
      ),
      bottomNavigationBar: TravelNavigationBar(
        onTap: (index) {},
        items: [
          TravelNavigationBarItem(
            icon: CupertinoIcons.chat_bubble,
            selectedIcon: CupertinoIcons.chat_bubble_fill, 
            label: 'sdsfdfsddfsdfs',
          ),
          TravelNavigationBarItem(
            icon: CupertinoIcons.square_split_2x2,
            selectedIcon: CupertinoIcons.square_split_2x2_fill, 
            label: 'wfwfwefwefwewfwfwe',
          ),
             TravelNavigationBarItem(
            icon: CupertinoIcons.square_split_2x2,
            selectedIcon: CupertinoIcons.square_split_2x2_fill, 
            label: 'wfwfwefwefwewfwfwe',
          ),
             TravelNavigationBarItem(
            icon: CupertinoIcons.square_split_2x2,
            selectedIcon: CupertinoIcons.square_split_2x2_fill, 
            label: 'wfwfwefwefwewfwfwe',
          ),
               TravelNavigationBarItem(
            icon: CupertinoIcons.square_split_2x2,
            selectedIcon: CupertinoIcons.square_split_2x2_fill, 
            label: 'wfwfwefwefwewfwfwe',
          ),
          

        ],
        currentIndex: menuProviderIndex
      ),
    );
  }
}
