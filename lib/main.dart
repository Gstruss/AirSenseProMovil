import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    title: 'AirSensePro',
    theme: ThemeData(
      primarySwatch: Colors.green,
      hintColor: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: LoginPage(),
  ));
}

// -----------------------
// Página de Inicio de Sesión
// -----------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    // Aquí se validaría la autenticación si estuviera implementada
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('AirSensePro'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: _login,
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _goToRegister,
              child: Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    // Simula un registro exitoso y redirige a Home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre Completo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: _register,
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------
// Página principal (información sobre el aire y clima)
// -----------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AirSensePro - Bogotá'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Información de calidad del aire
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Calidad del Aire en Bogotá'),
                subtitle: Text('Datos sobre contaminantes del aire'),
                leading: Icon(Icons.air, color: Colors.green),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Redirigir a la página de detalles de calidad del aire
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AirQualityDetailPage()),
                  );
                },
              ),
            ),
            // Información meteorológica
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Pronóstico Meteorológico'),
                subtitle: Text('Datos sobre elementos del clima'),
                leading: Icon(Icons.wb_sunny, color: Colors.orange),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Redirigir a la página de detalles del pronóstico meteorológico
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherDetailPage()),
                  );
                },
              ),
            ),
            // Mapa interactivo de estaciones
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Mapa de Estaciones de Monitoreo'),
                subtitle: Text('Visualiza estaciones y niveles de AQI'),
                leading: Icon(Icons.map, color: Colors.blue),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AirMapPage()),
                  );
                },
              ),
            ),
            // Botón de logout
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Botón de logout rojo
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Redirigir al login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

class AirMapPage extends StatefulWidget {
  const AirMapPage({super.key});

  @override
  State<AirMapPage> createState() => _AirMapPageState();
}

class _AirMapPageState extends State<AirMapPage> {
  static const LatLng bogotaCenter = LatLng(4.69000, -74.10000);
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.setMapStyle("[]");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Calidad del Aire'),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: bogotaCenter,
          zoom: 11,
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
        myLocationEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}

// -----------------------
// Página de detalles sobre la calidad del aire
// -----------------------
class AirQualityDetailPage extends StatelessWidget {
  const AirQualityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contaminantes del Aire'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // PM2.5
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('PM2.5 (Partículas Finas)'),
                subtitle: Text(
                    'Se refiere a las partículas en suspensión en el aire que tienen un tamaño de 2.5 micrómetros o menos. Para que lo entiendas, estas partículas son mucho más pequeñas que un cabello humano; son tan pequeñas que pueden entrar en tus pulmones cuando respiras. Debido a su tamaño, el PM2.5 puede ser muy dañino para la salud. Puede causar problemas respiratorios, irritación en los ojos y en la garganta, e incluso afectar al corazón.'),
                leading: Icon(Icons.air, color: Colors.green),
              ),
            ),
            // Dióxido de nitrógeno (NO2)
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Dióxido de Nitrógeno (NO2)'),
                subtitle: Text(
                    'Es un gas contaminante que se forma principalmente a partir de la combustión de combustibles fósiles, como en vehículos y centrales eléctricas. Es un componente importante del smog y puede tener efectos negativos en la salud humana y el medio ambiente, contribuyendo a problemas respiratorios y a la formación de lluvia ácida.'),
                leading: Icon(Icons.device_thermostat, color: Colors.orange),
              ),
            ),
            // Ozono (O3)
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Ozono (O3)'),
                subtitle: Text(
                    'Es un gas que se encuentra en la atmósfera y tiene un papel dual. En la estratosfera, el ozono forma la capa de ozono, que protege la Tierra de la radiación ultravioleta del sol. Sin embargo, en la troposfera (donde respiramos), el ozono es un contaminante que se forma a partir de reacciones químicas entre contaminantes como óxidos de nitrógeno y compuestos orgánicos volátiles, especialmente en presencia de luz solar.'),
                leading: Icon(Icons.cloud, color: Colors.blue),
              ),
            ),
            // Monóxido de carbono (CO)
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Monóxido de Carbono (CO)'),
                subtitle: Text(
                    'Es un gas incoloro, inodoro y altamente tóxico que se produce principalmente por la combustión incompleta de combustibles fósiles, como gasolina, carbón, gas natural y madera. Se encuentra en emisiones de vehículos, chimeneas, estufas y procesos industriales. Su peligrosidad radica en que se une a la hemoglobina en la sangre con una afinidad mucho mayor que el oxígeno, lo que puede provocar intoxicación y, en casos severos, la muerte.'),
                leading: Icon(Icons.local_fire_department, color: Colors.red),
              ),
            ),
            // Información adicional sobre los efectos de la contaminación
            SizedBox(height: 20),
            Text(
              'Los agentes contaminantes mencionados pueden tener efectos graves en la salud, especialmente en personas con afecciones respiratorias o cardiovasculares. Es importante mantenerse informado y tomar precauciones durante los días de alta contaminación.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------
// Página de detalles sobre el pronóstico meteorológico
// -----------------------
class WeatherDetailPage extends StatelessWidget {
  const WeatherDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pronósticos Meteorológicos'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Temperatura
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Temperatura'),
                subtitle: Text('La temperatura en el aire es una medida de cuán caliente o frío está el aire en un lugar determinado. Se relaciona con la energía térmica de las moléculas en el aire: a mayor energía, mayor temperatura. Se mide en grados Celsius (°C)'),
                leading: Icon(Icons.thermostat, color: Colors.orange),
              ),
            ),
            // Humedad
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Humedad'),
                subtitle: Text('La humedad relativa es la cantidad de vapor de agua presente en el aire en comparación con la cantidad máxima que el aire puede contener a una temperatura específica. Se expresa como un porcentaje (%).'),
                leading: Icon(Icons.water_drop, color: Colors.blue),
              ),
            ),
            // Viento
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Viento'),
                subtitle: Text('El viento es el movimiento del aire en la atmósfera, que se genera principalmente por diferencias de presión atmosférica. Estas diferencias se producen debido al calentamiento desigual de la superficie terrestre por el sol. El viento se mide generalmente en metros por segundo (m/s).'),
                leading: Icon(Icons.air_outlined, color: Colors.green),
              ),
            ),
            // Pronóstico de lluvia
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Precipitación de lluvia'),
                subtitle: Text('La precipitación se refiere al agua que cae desde la atmósfera a la superficie de la Tierra en forma de lluvia, nieve, aguanieve o granizo. La forma más común de precipitación en climas templados es la lluvia. Se mide principalmente en centímetros (cm).'),
                leading: Icon(Icons.beach_access, color: Colors.blue),
              ),
            ),
            // Información adicional sobre el clima
            SizedBox(height: 20),
            Text(
              'Es importante mantenerse informado sobre las condiciones meteorológicas, ya que el clima puede afectar tanto la calidad del aire como nuestras actividades diarias.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}