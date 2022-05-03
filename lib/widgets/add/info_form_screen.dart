import '../../commons.dart';
import 'info_form_state.dart';


//Widgets
import 'widgets/widgets.dart';

class ProductInfoForm extends StatefulWidget {

  @override
  createState() => _ProductInfoFormState();
}

class _ProductInfoFormState extends InfoFormScreenState {

  @override
  Widget build(BuildContext context) {
    
    //final index = ModalRoute.of(context)!.settings.arguments as int?;

    final data = ModalRoute.of(context)!.settings.arguments as Map<String?, dynamic>;
    final indexCategory = data["indexCategory"];
    //final indexFurther  = data["indexFurther"];
  
    //final cats  = Categories.categories[indexCategory!];
    
    return ListView(
      children: [
        Form(
          key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InfoFormHeader(),
                    kGap20,
                    //TitleFormField(),
                    TextFormField(
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
                        ChangeCategory(),
                        ChangeSubcategory(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Divider(),
                        ),
                      ],
                    ),
                    Divider(),                    
                    //MakeShipmentsSwitch(),

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
            NextScreenButton(onPressed: trySubmit, ),
      ],
    );
  }
}
