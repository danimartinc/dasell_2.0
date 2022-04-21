import 'package:DaSell/commons.dart';

class FilterPriceDialog extends StatefulWidget {

  final Function(RangeValues rv) onRangeSelected;
  final RangeValues initialValue;

  const FilterPriceDialog({
    Key? key,
    required this.onRangeSelected,
    this.initialValue = const RangeValues(0, 2000),
  }) : super(key: key);

  @override
  _FilterPriceDialogState createState() => _FilterPriceDialogState();
}

class _FilterPriceDialogState extends State<FilterPriceDialog> {

  late RangeValues rv = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Precio',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          RangeSlider(
            key: ValueKey('price'),
            min: 0,
            max: 2000,
            values: rv,
            onChanged: (value) {
              rv = value;
              update();
            },
            divisions: 100,
            labels: RangeLabels(
              rv.start.toStringAsFixed(0),
              rv.end.toStringAsFixed(0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Aplicar'),
                onPressed: () {
                  widget.onRangeSelected(rv);
                  Navigator.of(context).pop();
                },
              ),
              Gap(10),
              ElevatedButton(
                child: Text('Reiniciar'),
                onPressed: () {
                  widget.onRangeSelected(RangeValues(0, 2000));
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
