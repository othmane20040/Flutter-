import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Buttons'),
        ),
        body: PhoneApp(),
      ),
    );
  }
}

class PhoneApp extends StatefulWidget {
  @override
  _PhoneAppState createState() => _PhoneAppState();
}

class _PhoneAppState extends State<PhoneApp> {
  String displayedNumber = '';
  String? selectedImage;

  void updateDisplayedNumber(String value) {
    setState(() {
      displayedNumber = value;
      selectedImage = 'assets/images/$displayedNumber.png';
    });
  }

  void displayImage() {
    setState(() {
      if (displayedNumber.isNotEmpty) {
        selectedImage = 'assets/images/$displayedNumber.png';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageScreen(selectedImage!),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 16.0),
          alignment: Alignment.topCenter,
          child: Text(
            displayedNumber,
            style: TextStyle(fontSize: 48.0),
          ),
        ),
        PhoneButtonGrid(updateDisplayedNumber),
        SizedBox(height: 10.0),
        SizedBox(
          width: 80.0,
          height: 80.0,
          child: CustomIconButton(
            onPressed: displayImage,
            icon: Icons.image,
          ),
        ),
      ],
    );
  }
}

class PhoneButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;

  PhoneButtonGrid(this.onButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhoneButton('1', onButtonPressed, Colors.blue), // Bouton bleu
                SizedBox(width: 16.0),
                PhoneButton('2', onButtonPressed, Colors.green), // Bouton vert
                SizedBox(width: 16.0),
                PhoneButton('3', onButtonPressed, Colors.red), // Bouton rouge
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhoneButton('4', onButtonPressed, Colors.orange), // Bouton orange
                SizedBox(width: 16.0),
                PhoneButton('5', onButtonPressed, Colors.purple), // Bouton violet
                SizedBox(width: 16.0),
                PhoneButton('6', onButtonPressed, Colors.yellow), // Bouton jaune
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhoneButton('7', onButtonPressed, Colors.cyan), // Bouton cyan
                SizedBox(width: 16.0),
                PhoneButton('8', onButtonPressed, Colors.teal), // Bouton teal
                SizedBox(width: 16.0),
                PhoneButton('9', onButtonPressed, Colors.indigo), // Bouton indigo
              ],
            ),
            SizedBox(height: 10.0),
            SizedBox(
              width: 80.0,
              height: 80.0,
              child: PhoneButton('0', onButtonPressed, Colors.grey), // Bouton gris
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneButton extends StatefulWidget {
  final String text;
  final Function(String) onPressed;
  final Color color; // Couleur du bouton

  PhoneButton(this.text, this.onPressed, this.color);

  @override
  _PhoneButtonState createState() => _PhoneButtonState();
}

class _PhoneButtonState extends State<PhoneButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isHovered ? widget.color.withOpacity(0.8) : widget.color,
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            widget.onPressed(widget.text);
          },
          onHover: (bool hover) {
            setState(() {
              isHovered = hover;
            });
          },
          child: Text(
            widget.text,
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomIconButton({
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 32.0,
          ),
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imagePath;

  ImageScreen(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
