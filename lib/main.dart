import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet"; // Initial pet name
  int happinessLevel = 50; // Initial happiness level
  int hungerLevel = 50; // Initial hunger level

  @override
  void initState() {
    super.initState();
    // Automatically increase hunger every 30 seconds
    Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel = (hungerLevel + 5).clamp(0, 100);
        _updateHappiness();
      });
    });
  }

  // Function to play with the pet and increase happiness
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
    });
  }

  // Function to feed the pet and decrease hunger
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
    });
  }

  // Function to update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
    _checkGameOver();
  }

  // Function to increase hunger slightly when playing
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    _checkGameOver();
  }

  // Function to check if the game is over
  void _checkGameOver() {
    if (happinessLevel <= 10 && hungerLevel >= 100) {
      _showGameOverDialog();
    }
  }

  // Show a dialog when the game is over
  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Your pet is unhappy and too hungry!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Get the pet's color based on its happiness level
  Color _getPetColor() {
    if (happinessLevel > 70) {
      return Colors.green; // Happy
    } else if (happinessLevel >= 30) {
      return Colors.yellow; // Neutral
    } else {
      return Colors.red; // Unhappy
    }
  }

  // Get the pet's mood based on its happiness level
  String _getPetMood() {
    if (happinessLevel > 70) {
      return "😊 Happy";
    } else if (happinessLevel >= 30) {
      return "😐 Neutral";
    } else {
      return "😞 Unhappy";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text field to customize the pet name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    petName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter your pet\'s name',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Display the pet's name
            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            // Display the pet's happiness level
            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            // Display the pet's hunger level
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            // Display the pet's mood
            Text(
              'Mood: ${_getPetMood()}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 32.0),
            // Dynamic pet color
            Container(
              height: 100,
              width: 100,
              color: _getPetColor(),
            ),
            SizedBox(height: 32.0),
            // Play with the pet button
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            // Feed the pet button
            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
