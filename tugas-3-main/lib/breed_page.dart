import 'package:flutter/material.dart';
import 'package:indraadhis_215410070/breed.dart';

class BreedPage extends StatelessWidget {
  final Breed breed;

  const BreedPage({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(breed.description),
            const SizedBox(height: 10),
            Text('Life Expectancy: ${breed.life.min} - ${breed.life.max} years'),
            Text('Male Weight: ${breed.maleWeight.min} - ${breed.maleWeight.max} kg'),
            Text('Female Weight: ${breed.femaleWeight.min} - ${breed.femaleWeight.max} kg'),
            Text('Hypoallergenic: ${breed.hypoallergenic ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
