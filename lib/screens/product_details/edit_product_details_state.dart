import 'dart:async';


import 'package:DaSell/models/edit_product.dart';

import '../../commons.dart';
import '../../data/categories.dart';
import '../../services/firebase/models/product_vo.dart';
import 'edit_product_details.dart';


abstract class EditProductState extends State<EditProductDetails> {

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

 
   /// consumir esto en el HOME.
  List<CategoryItemVo> homeCategories = categories.map((e) {
    final name = e['category'] as String;
    final icon = e['icon'] as IconData;
    return CategoryItemVo(name, icon);
  }).toList(growable: false);

  List<String> getsubCategories( String? category ){
    if(category==null) return [];
    return categories[categories.indexWhere((map) => map['category'] == category)]['further'];
  }
  

  static const List<Map<String, dynamic>> categories = [
    {
      'category': 'Coches',
      'further': [
        'Automóvil',
        'Furgoneta',
        'Pick-Up',
        'SUV',
        'Crossover',
        'Todoterreno',
        'Monovolumén',
        'Compacto',
        'Otros'
      ],
      'icon': FontAwesomeIcons.car,
    },
    {
      'category': 'Motos',
      'further': [
        'Ciclomotores',
        'Scooters y maxiscooters',
        'Triciclos y cuatriciclos',
        'Naked',
        'Trail',
        'Deportivas',
        'Sport Turismo',
        'Gran Turismo',
        'Clásicas',
        'Eléctricas',
        'Competición',
      ],
      'icon': FontAwesomeIcons.motorcycle,
    },
    {
      'category': 'Moda y accesorios',
      'further': [
        'Abrigos/Parkas',
        'Cazadoras',
        'Sobrecamisas',
        'Chalecos',
        'Trajes',
        'Blazers',
        'Jerséis y Cardigans',
        'Chaquetas',
        'Vestidos y monos',
        'Deportiva',
        'Sudaderas',
        'Camisas y blusas',
        'Camisetas',
        'Polos',
        'Pantalones',
        'Jeans',
        'Faldas',
        'Zapatos',
        'Bolsos/Mochilas',
        'Accesorios',
        'Perfumes',
        'Zapatos',
        'Pijamas',
        'Calcetines',
        'Ropa interior',
      ],
      'icon': FontAwesomeIcons.tshirt,
    },
    {
      'category': 'Motor y accesorios',
      'further': [
        'GPS y electrónica',
        'Herramientas',
        'Repuestos de coches y furgonetas',
        'Repuestos de motos y cuatriciclos',
        'Otros',
      ],
      'icon': FontAwesomeIcons.cogs,
    },
    {
      'category': 'Inmobiliaria',
      'further': [
        'Alquiler',
        'Venta',
      ],
      'icon': FontAwesomeIcons.houseUser,
    },
    {
      'category': 'TV, Audio y Foto',
      'further': [
        'Auriculares y cascos',
        'Cámaras de vigilancia',
        'Cámaras y fotografía',
        'Drones',
        'Pilas y cargadores',
        'Proyectores y accesorios',
        'Reproductores',
        'Televisión y accesorios',
        'Vídeo y accesorios',
        'Otros',
      ],
      'icon': FontAwesomeIcons.tv,
    },
    {
      'category': 'Móviles y Telefonía',
      'further': [
        'Auriculares',
        'Cargadores',
        'Cables',
        'Baterías',
        'Cámaras',
        'Smartwatches',
        'Tablets',
        'Teléfonos antiguos',
        'Teléfonos móviles',
        'Otros',
      ],
      'icon': FontAwesomeIcons.mobileAlt,
    },
    {
      'category': 'Informática y Electrónica',
      'further': [
        'Cables',
        'Cargadores',
        'Baterías',
        'Impresoras',
        'Cartuchos',
        'Monitores',
        'Ordenadores',
        'Componentes y recambios',
        'Ordenadores portátiles',
        'Ratones',
        'Teclados',
        'Realidad virtual y aumentada',
        'Software',
        'Otros',
      ],
      'icon': FontAwesomeIcons.laptop,
    },
    {
      'category': 'Deporte y Ocio',
      'further': [
        'Baloncesto',
        'Balonmano',
        'Bicicletas estáticas y elípticas',
        'Fitness, running y yoga',
        'Fútbol',
        'Golf',
        'Juegos recreativos y de mesa',
        'Manualidades',
        'Montaña y esquí',
        'Natación y accesorios piscina',
        'Patinetes y patinaje',
        'Rugby',
        'Tenis y pádel',
        'Vóley',
        'Otros deportes',
        'Otros',
      ],
      'icon': FontAwesomeIcons.running,
    },
    {
      'category': 'Bicicletas',
      'further': [
        'Bombas e infladores',
        'Electrónica para bicicletas',
        'Luces',
        'Portabicicletas',
        'Rodillos',
        'Bicicletas infantiles',
        'Bicicletas ciudad',
        'Bicicletas de carretera',
        'Bicicletas eléctricas',
        'Bicicletas plegables',
        'Fixies',
        'MTB',
        'Monociclos',
        'Triciclos',
        'Cuadros',
        'Herramientas',
        'Neumáticos y cámaras',
        'Piezas',
        'Recambios',
        'Ruedas',
        'Sillín',
        'Alforjas',
        'Cascos',
        'Gafas ciclismo y solares',
        'Ropa ciclismo',
        'Zapatillas y cubrezapatillas',
        'Otros',
      ],
      'icon': FontAwesomeIcons.biking,
    },
    {
      'category': 'Consolas y Videojuegos',
      'further': [
        'Accesorios de consolas',
        'Consolas',
        'Manuales y guías',
        'Merchandising de videojuegos',
        'Recambios de consolas',
        'Videojuegos',
        'Otros',
      ],
      'icon': FontAwesomeIcons.gamepad,
    },
    {
      'category': 'Hogar y Jardín',
      'further': [
        'Armarios',
        'Baúles',
        'Cestas y contenedores para la colada',
        'Estanterías',
        'Accesorios de mascotas',
        'Juegos de baño',
        'Muebles de baño y espejos',
        'Radiadores de baño',
        'Toallas de baño y alfombras',
        'Cuberterías',
        'Utensilios',
        'Vajillas',
        'Almohadas y cojines',
        'Colchones',
        'Ropa de cama',
        'Adornos y decoración',
        'Alfombras',
        'Cortinas y estores',
        'Obras de arte',
        'Apliques',
        'Lámparas de mesa',
        'Lámparas de pie',
        'Lámparas de techo',
        'Barbacoas',
        'Iluminación exterior',
        'Jardinería y huertos',
        'Mobiliario exterior',
        'Jardinería y huertos',
        'Piscina, sauna y spa',
        'Antigüedades',
        'Habitaciones infantiles',
        'Muebles de dormitorio',
        'Muebles oficina',
        'Muebles áreas comunes',
        'Otros',
      ],
      'icon': FontAwesomeIcons.couch,
    },
    {
      'category': 'Electrodomésticos',
      'further': [
        'Climatización',
        'Electrodomésticos de cocina',
        'Lavandería y plancha',
        'Pequeños electrodomésticos',
        'Piezas y recambios',
        'Vitrocerámica',
        'Otros',
      ],
      'icon': FontAwesomeIcons.plug,
    },
    {
      'category': 'Cine, Libros y Música',
      'further': [
        'CDs Música',
        'CDs idiomas',
        'Discos de vinilo',
        'Cómics y novelas gráficas',
        'Cables',
        'Compresores y ecualizadores',
        'Dispositivos de grabación',
        'Mesas de mezclas y DJ',
        'Micrófonos y accesorios',
        'Instrumentos de cuerda',
        'Instrumentos de viento',
        'Bajos',
        'Guitarras',
        'Percusión',
        'Teclados',
        'Libros antiguos',
        'Libros escolares y de texto',
        'Libros infantiles y juveniles',
        'Libros prácticos y de referencia',
        'Literatura y narrativa',
        'Partituras y libretos',
        'Cintas de VHS',
        'Colecciones de películas y series',
        'DVDs y Blu-ray',
        'LaserDiscs',
        'Otros formatos',
        'Pósters y merchandising',
        'Revistas',
        'Tocadiscos',
        'Otros',
      ],
      'icon': FontAwesomeIcons.book,
    },
    {
      'category': 'Niños y Bebés',
      'further': [
        'Accesorios de baño',
        'Baberos y paños',
        'Batidoras y mezcladoras',
        'Biberones y calientabiberones',
        'Chupetes',
        'Utensilios y cubertería',
        'Lactancia',
        'Libros para madres y padres',
        'Mochilas',
        'Porta meriendas',
        'Uniformes',
        'Camas infantiles',
        'Cunas',
        'Iluminación infantil',
        'Ropa de cama infantil',
        'Ropa de cuna',
        'Sacos de dormir',
        'Disfraces infantiles',
        'Juegos de mesa',
        'Juguetes',
        'Peluches',
        'Mobilario infantil',
        'Ropa infantil',
        'Arneses de seguridad',
        'Monitores para bebés',
        'Pegatinas para el coche',
        'Puertas de seguridad y parques',
        'Termómetros para bebés',
        'Cochecitos',
        'Portabebés',
        'Sillas de coche',
        'Sillas de paseo',
        'Andadores',
        'Correpasillos',
        'Tronas',
        'Otros',
      ],
      'icon': FontAwesomeIcons.child,
    },
    {
      'category': 'Coleccionismo',
      'further': [
        'Antigüedades',
        'Artesanías y decoración',
        'Artículos de escritorio',
        'Banderas',
        'Coches y motocicletas',
        'Coleccionismo deportivo',
        'Coleccionismo militar',
        'Filatelia y sellos',
        'Imanes',
        'Llaveros',
        'Monedas y billetes',
        'Muñecos',
        'Naipes',
        'Postales y suvenires',
        'Relojes',
        'Otros',
      ],
      'icon': FontAwesomeIcons.addressBook,
    },
    {
      'category': 'Materiales de construcción',
      'further': [
        'Balcones',
        'Bañeras',
        'Duchas',
        'Inodoros',
        'Lavabos',
        'Cocinas',
        'Electricidad e iluminación',
        'Escaleras y andamios',
        'Ferretería',
        'Herramientas',
        'Herramientas eléctricas',
        'Maquinaria',
        'Madera y otros materiales',
        'Baldosas y azulejos',
        'Parquet',
        'Barnices',
        'Pinturas',
        'Cristales',
        'Puertas',
        'Puertas correderas',
        'Ventanas',
        'Otros',
      ],
      'icon': FontAwesomeIcons.hammer,
    },
    {
      'category': 'Industria y Agricultura',
      'further': [
        'Herramientas agrícolas',
        'Insumos agrícolas',
        'Maquinaria',
        'Repuestos',
        'Tractores',
        'Vehículos',
        'Equipamiento industrial',
        'Herramientas',
        'Insumos industriales',
        'Repuestos de herramientas',
        'Repuestos de maquinaria',
        'Otros',
      ],
      'icon': FontAwesomeIcons.industry,
    },
    {
      'category': 'Empleo',
      'further': [
        'Busco empleo',
        'Ofertas de empleo',
      ],
      'icon': FontAwesomeIcons.briefcase,
    },
    {
      'category': 'Servicios',
      'further': [
        'Clases de idiomas',
        'Personal trainers',
        'Tutores y soporte escolar',
        'Cuidadores de ancianos',
        'Niñeras',
        'Mensajería',
        'Mudanzas',
        'Transporte',
        'Reparaciones',
        'Servicios de limpieza',
        'Albañil',
        'Electricista',
        'Terapia y crecimiento personal',
        'Otros',
      ],
      'icon': FontAwesomeIcons.wrench,
    },
    {
      'category': 'Otros',
      'further': [
        'Religioso',
        'Espiritual',
      ],
      'icon': FontAwesomeIcons.ellipsisH,
    },
  ];
  
}