import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Office Food',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Food',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  String nombre = "";
  String pedido = "";
  double precio = 0;
  double cantidad = 0;
  String mensaje = "";
  bool validacion = false;
  double total = 0;
  bool delivery = false;
  double descuento = 0;
  double pagoTotal = 0;

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _tfNombres = TextEditingController();
  final _tfPedido = TextEditingController();
  final _tfPrecio = TextEditingController();
  final _tfCantidad = TextEditingController();

  void _calcularPromedio() {
    setState(() {
      widget.validacion = false;
      if (_tfPedido.text.toString() == "" ||
          _tfCantidad.text.toString() == "" ||
          _tfPrecio.text.toString() == "" ||
          _tfNombres.text.toString() == "") {
        widget.validacion = true;
        widget.mensaje = "Faltan Datos";
        return;
      }
      widget.cantidad = double.parse(_tfCantidad.text);
      widget.precio = double.parse(_tfPrecio.text);
      widget.nombre = _tfNombres.text;
      widget.pedido = _tfPedido.text;
      widget.total = widget.cantidad * widget.precio;
      if (widget.total > 500) {
        widget.descuento = widget.total * (5 / 100);
      }
      if (widget.delivery == true) {
        widget.pagoTotal = (widget.total - widget.descuento) + 20;
      } else {
        widget.pagoTotal = (widget.total - widget.descuento);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                  "Por Favor completar los datos y dale click en calcular"),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    TextField(
                        controller: _tfNombres,
                        decoration: InputDecoration(
                          hintText: "Nombre",
                          labelText: "Nombres",
                          errorText: _tfNombres.text.toString() == ""
                              ? widget.mensaje
                              : null,
                        )),
                    TextField(
                        controller: _tfPedido,
                        decoration: InputDecoration(
                          hintText: "Pedido",
                          labelText: "Pedido",
                          errorText: _tfPedido.text.toString() == ""
                              ? widget.mensaje
                              : null,
                        )),
                    TextField(
                        controller: _tfPrecio,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: "Precio",
                          labelText: "Precio",
                          errorText: _tfPrecio.text.toString() == ""
                              ? widget.mensaje
                              : null,
                        )),
                    TextField(
                        controller: _tfCantidad,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            hintText: "Cantidad",
                            labelText: "Cantidad",
                            errorText: _tfCantidad.text.toString() == ""
                                ? widget.mensaje
                                : null)),
                    Text("Total Bruto:  S/ " +
                        widget.total.toString() +
                        "   Descuento: S/ " +
                        widget.descuento.toString()),
                    Text("Delivery:"),
                    Switch.adaptive(
                        value: widget.delivery,
                        onChanged: (value) =>
                            setState(() => this.widget.delivery = value)),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: "TOTAL A PAGAR :S/ " +
                              widget.pagoTotal.toString()),
                    ),
                    RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        color: Colors.greenAccent,
                        child: Text(
                          "Calcular",
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: _calcularPromedio)
                  ],
                ))
          ],
        ));
  }
}
