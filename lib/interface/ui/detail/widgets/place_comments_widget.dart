import 'package:DaSell/commons.dart';
import 'package:DaSell/interface/models/place.dart';

class PlaceCommentsWidget extends StatelessWidget {
  const PlaceCommentsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0),
            Colors.white,
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      for (var i = 0; i < 3; i++)
                        Align(
                          widthFactor: .7,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  TravelUser.users[i].urlPhoto,
                                ),
                              ),
                            ),
                          ),
                        ),
                      kGap10,
                      const Text(
                        'Comments',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kGap10,
                      const Text(
                        '120',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kGap10,
                    ],
                  ),
                ),
              ),
            ),
          ),
          kGap20,
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
