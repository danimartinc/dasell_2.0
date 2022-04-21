import 'package:DaSell/screens/add/price_location/widgets/widgets.dart';

import '../../../commons.dart';
import 'price_and_location_state.dart';



class PriceAndLocationScreen extends StatefulWidget {

  static const routeName = './price_and_location_screen';

  @override
  createState() => _PriceAndLocationScreenState();
}

class _PriceAndLocationScreenState extends PriceLocationScreenState {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PriceLocationAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        PriceField(textController: textController, containerHeight: 80,),
                        mapUrl.isEmpty
                          ? Container()
                          : OptionalAddress(addressController: addressController),
                          kGap10,
                          WantDonateTitle(),
                          //DonateButon(onPressed: onDonatePressed),
                          IconButton(
                              icon: isDonate
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 40,
                                )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                    size: 40,
                                ),
                                onPressed: () {
                                
                                  textController.clear();
                                  FocusScope.of(context).unfocus();
                                  
                                  setState(() {
                                    if (isDonate) {
                                      containerHeight = 80;
                                    } else {
                                      containerHeight = 0;
                                    }
                                    isDonate = !isDonate;
                                  });
                                },
                            ),
                            kGap10,
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: mapUrl.isEmpty
                                  ? Text('Ninguna localización seleccionada')
                                  : Image.network(
                                    mapUrl,
                                    fit: BoxFit.cover,
                                  ),
                              ),
                            ),
                            kGap10,
                            ChooseLocationButton(getUserLocation: getUserLocation, openMapsScreen: openMapsScreen),
                      ],
                    ),
                  ),
                ],
              ),            
      ),
      bottomNavigationBar: BottomConfirmButton(checkInputs: checkInputs,)
    );
  }
}