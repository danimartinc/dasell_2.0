import '../../commons.dart';
import '../../services/firebase/models/product_vo.dart';
import 'edit_product_details_state.dart';


class EditProductDetails extends StatefulWidget {
  
  final ResponseProductVo data;

  const EditProductDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  createState() => _EditProductDetails();
}

class _EditProductDetails extends EditProductState {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Editar publicación'),
      ),
      body: ListView(
      children: [
        Form(
          key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //InfoFormHeader(),
                    kGap20,
                    TextFormField(
                      controller: TitleController,
                      key: ValueKey('title'),
                      validator: (value) {
                        if ( value!.length > 8 ) {
                          return null;
                        } else {
                          return 'El título debe contener más de 8 caracteres';
                        }
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onSaved: (newValue) {
                        title = newValue!;
                      },
                    ),
                    kGap30,
                    //DescriptionFormField( onChanged: onDescriptionChanged,),    
                    TextFormField(
                      controller: DescriptionController,
                      key: ValueKey('desc'),
                      onChanged: (value) {
                        if ( prevValue.length > value.length) {
                          setState(() {
                            counterText--;
                          });
                        } else {
                          setState(() {
                            counterText++;
                          });
                        }
                         prevValue = value;
                      },
                      validator: (value) {
                        if (value!.length > 15) {
                          return null;
                        } else {
                          return 'La descripción debe contener al menos 20 caracteres';
                        }
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        counterText: '$counterText/600',
                        labelText: 'Descripción',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onSaved: (newValue) {
                        desc = newValue!;
                      },
                      maxLength: 600,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //ChangeCategory(),
                       // ChangeSubcategory(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Divider(),
                        ),
                      ],
                    ),
                    Divider(),                    

                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: containerHeight,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: PriceController,
                        decoration: InputDecoration(
                          suffix: Text(
                            '€',
                            style: TextStyle(fontSize: 20),
                          ),
                          labelText: 'Precio',
                          labelStyle: TextStyle(
                            fontSize: 20, 
                            fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),

                    SwitchListTile.adaptive(
                      title: Text(
                        'Hago envíos',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      subtitle: Text(
                        'Enviar te permite tener opción a vender más artículos. Dispones de servicio de recogida a domicilio',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      activeColor: Theme.of(context).primaryColor,
                      value: makeShipments,
                      onChanged: ( value ) {
                        setState(() {
                          makeShipments = value;
                        });
                      },
                    ),
                    kGap25,
                    Text(
                      'Indica el estado del producto',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                    Slider.adaptive(
                      value: sliderValue!,
                      min: 0,
                      max: 100,
                      divisions: 4,
                      label: sliderValueMap[ sliderValue!.toInt().toString() ],
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),    

          TextFormField(
            controller: CategoryController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),

          InkWell(
            onTap: (){},
            child: Container(
              child:  Padding(
                padding: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: Theme.of(context).primaryColor,
                  ),  
                  //shape: StadiumBorder(),
                  child: Container(
                    width: 150,
                    height: 55,
                    child: Center(
                      child: Text('Actualizar publicación',),
                      //child: Text( this.text , style: TextStyle( color: Colors.white, fontSize: 17 )),
                    ),
                  ),
                  // Icons.arrow_forward, 
                  onPressed: (){
                    updateData();
                  },
                ),
              ),
            ),
          ),
      ],
      ),
  );
  }
}
