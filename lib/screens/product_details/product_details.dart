import 'package:DaSell/commons.dart';
import 'package:DaSell/services/firebase/models/product_vo.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';

import 'product_details_state.dart';
import 'widgets/action_button.dart';
import 'widgets/image_slider.dart';
import 'widgets/widgets.dart';

class ProductDetails extends StatefulWidget {
  
  final ResponseProductVo data;
  final double scrollOffset;

  static const routeName = './products_details';

  const ProductDetails({
    Key? key,
    required this.data,  
    this.scrollOffset = 0.0,
  }) : super(key: key);

  @override
  createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ProductDetailsState {

  ScrollController? _scrollController;
  double scrollOffset = 0.0;

  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          scrollOffset = _scrollController!.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _customAppBar(),
      body: getContent(),
      floatingActionButton: Visibility(
        visible: hasChat,
        child: FittedBox(
          child: FloatingActionButton.extended(
            heroTag: 'FromChat',
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            elevation: 15,
            label: Text(''),
            icon: Icon(FontAwesomeIcons.comments),
            onPressed: onChatTap,
          ),
        ),
      ),
    );
  }
  
  Widget getContent() {

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
       SliverPadding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
        sliver: SliverList(
        delegate: SliverChildListDelegate([
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: data.tag!,
                    child: ProductImageSlider(
                      images: data.images!,
                      onChanged: onImageChanged,
                    ),
                  ),
                  SliderDots(images: data.images!, current: current),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Gap(15),
                    Text(
                      data.textDetailsPrice,
                      style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                    ),
                    Gap(5),
                    Text(
                      data.textTitle,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.boxOpen),
                        Gap(30),
                        Text(
                          data.textShipment,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: data.getHasShipment()
                                ? Colors.pink[200]
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                    kDivider1,
                    ProductCategoryButtons(
                      categories: data.categories ?? [],
                      onCategoryTap: onCategoryTap,
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 170,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.menu_book_outlined),
                                Gap(20),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    data.textEstadoArticulo,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 170,
                            decoration:
                                BoxDecoration(color: Theme.of(context).cardColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on_outlined),
                                Gap(10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: !hasLocation
                                      ? CommonProgress()
                                      : Text(
                                          locationText,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 170,
                            decoration: BoxDecoration(color: Theme.of(context).cardColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today),
                                Gap(10),
                                Text(
                                  'Fecha de publicación',
                                  style: TextStyle(fontFamily: 'Poppins'),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  textPublicationDate,
                                  style: TextStyle(fontFamily: 'Poppins'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    kGap25,
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //TODO: ANAND, From this widget, which indicates which user has published the product, 
                      //in the form "Product published by", make this widget selectable in the same way as 
                      //I indicated in the first screenshot I sent you. 
                      //In this widget you have to add the average rating that has received by the rest of the users by means of a stars rating.
                      child: Row(
                        children: [
                          if (!hasAdUser) CommonProgress(),
                          if (hasAdUser)
                            ProductUserAvatar(imageUrl: adUser?.profilePicture),
                          Gap(25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Producto publicado por ',
                                style:
                                    TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                              ),
                              if (!hasAdUser) CommonProgress(),
                              if (hasAdUser)
                                Text(
                                  textAdUserName,
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Poppins'),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                    kGap20,
                    //Description
                    AutoSizeText(
                      textDescription,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                      minFontSize: 18,
                      maxLines: 4,
                    ),
                    Gap(25),
                    if (hasAddress)
                      Column(
                        children: [
                          Row(children: [
                            Icon(FontAwesomeIcons.mapMarkedAlt, size: 30),
                            Gap(15),
                            Expanded(
                              child: AutoSizeText(
                                textAddress,
                                style:
                                    TextStyle(fontFamily: 'Poppins', fontSize: 18),
                                minFontSize: 18,
                                maxLines: 4,
                              ),
                            )
                          ]),
                        ],
                      ),
                    kGap20,
                    //Map
                    GestureDetector(
                      onTap: onMapTap,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Center(
                          child: mapUrl.isEmpty
                              ? Text('No hay ubicación')
                              : Image.network(mapUrl, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Gap(70),
                  ],
                ),
              ),
            ],
          ),
        ],
        ),
      ),
       )
      ]
    );
  }

PreferredSizeWidget? _customAppBar() {

  final Size screenSize = MediaQuery.of(context).size;
  final color = Color.lerp( Colors.indigo.shade800, Colors.white, (scrollOffset / 230).clamp(0, 1).toDouble());

  return PreferredSize(
    preferredSize: Size(screenSize.width, kToolbarHeight ),    
    child: AppBar(
      elevation: 0.0,
      leading: BackButton(color: color ),
      backgroundColor: Colors.indigo.shade800.withOpacity((scrollOffset / 230).clamp(0, 1).toDouble()),
      actions: [          
        if(data.isMe)
        ActionButtonMoreOptions(onDelete: onDeleteTap, onSell: onSellTap, iconColor: color,),
      ],
    ),      
  );    
}
}



