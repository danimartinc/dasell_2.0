import 'package:flutter/cupertino.dart';
import 'package:DaSell/interface/extensions/text_theme_x.dart';
import 'package:DaSell/interface/models/place.dart';
import 'package:DaSell/interface/ui/widgets/gradient_status_tag.dart';

import '../../../../commons.dart';

//Extensions


//Models



class PlaceCard extends StatelessWidget {

  final TravelPlace place;
  final VoidCallback onPressed;

  const PlaceCard({
    Key? key,
    required this.place,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final statusTag = place.statusTag;

    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(place.imagesUrl.first),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.black26,
              BlendMode.darken,
            ),
          ),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage( place.user.urlPhoto ),
              ),
              kGap10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 
                    place.user.name, 
                    style: context.bodyText1.copyWith(
                      color: Colors.white
                    ),  
                  ),         
                  Text( 
                    'yesterday at 9:10 p.m', 
                    style: context.bodyText1.copyWith(
                      color: Colors.white70
                    ),  
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz, 
                  color: Colors.white,
                ),
                onPressed: () {
                  }, 
              )
            ],
          ),
          const Spacer(),
          Text(
            place.name,
            style: context.headline2,
          ),
          kGap10,
          GradientStatusTag(statusTag: statusTag),
          const Spacer(),
          Row(
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  shape: const StadiumBorder(),
                ),
                icon: const Icon( CupertinoIcons.heart ),
                label: Text( place.likes.toString() ),
                onPressed: () {}, 
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  shape: const StadiumBorder(),
                ),
                icon:  const Icon( CupertinoIcons.reply ),
                label: Text( place.shared.toString() ),
                onPressed: () {}, 
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}