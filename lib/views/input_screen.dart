import 'package:flutter/material.dart';
import 'package:mapapp/models/location_model.dart';
import 'package:mapapp/views/map_screen.dart';

class InputScreen extends StatefulWidget{
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _apellido = '';
  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de lugar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value){
                  _nombre = value!;
                },
                validator: (value){
                  if (value!.isEmpty){
                    return 'Por favor ingresar su nombre';
                  }
                  return null;
                } ,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apellido'),
                onSaved: (value){
                  _apellido = value!;
                },
                validator: (value){
                  if (value!.isEmpty){
                    return 'Por favor ingresar su apellido';
                  }
                  return null;
                } ,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                onSaved: (value){
                  _latitude = double.parse(value!);
                },
                validator: (value){
                  if (value!.isEmpty){
                    return 'Por favor ingresar la latitude';
                  }
                  return null;
                } ,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                onSaved: (value){
                  _longitude = double.parse(value!);
                },
                validator: (value){
                  if (value!.isEmpty){
                    return 'Por favor ingresar la longitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MapScreen(
                        location: LocationModel(
                          nombre: _nombre,
                          apellido: _apellido,
                          longitude: _longitude,
                          latitude: _latitude,
                        ),
                      )
                    ));
                  }
                },
                child: Text('Siguiente'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}