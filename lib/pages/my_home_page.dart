import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // list of images assets
  List<String> diceImagesPath = [
    'lib/images/1.png',
    'lib/images/2.png',
    'lib/images/3.png',
    'lib/images/4.png',
    'lib/images/5.png',
    'lib/images/6.png',
  ];

  // random number
  int? randomNumber;

  // list of historic results
  List<int> historicDices = [];

  // number of rolls
  int rollCount = 0;

  // total points getted
  int totalPoints = 0;

  // average points getted
  double averagePoints = 0;

  // generate random number between 0-5 and add to historic.
  void rollTheDice() {
    // add a roll count
    rollCount++;

    // random number to roll the dice
    randomNumber = Random().nextInt(6) + 1;

    // total points updated
    totalPoints += randomNumber!;

    // average points updated
    averagePoints = totalPoints / rollCount;

    // add to historic
    historicDices.add(randomNumber!);
  }

  // get % of roll
  double getPercentageOf(int rollNumber) {
    // get how many ocurrences are
    int numberOfOccurrences =
        historicDices.where((element) => element == rollNumber).length;

    // return 0.0 if we didn't start the rolling
    if (historicDices.isEmpty) return 0.0;

    // get % based on the total amount
    double percentage = (numberOfOccurrences * 100) / historicDices.length;

    return percentage;
  }

  // restart values
  void restart() {
    randomNumber = null;
    historicDices = [];
    rollCount = 0;
    totalPoints = 0;
    averagePoints = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              restart();
            });
          },
          child: const Icon(Icons.refresh),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Text(
                  'What will you get?',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 42.0),
                SizedBox(
                  height: 100,
                  // get image from the list based on the number
                  child: randomNumber != null
                      ? Image.asset(diceImagesPath[randomNumber! - 1])
                      : null,
                ),
                const SizedBox(height: 42.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      rollTheDice();
                    });
                  },
                  child: const Text(
                    'Roll the dice',
                    style: TextStyle(fontSize: 36.0),
                  ),
                ),
                const SizedBox(height: 25.0),
                Text(
                  'Previous roll',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.primary),
                ),
                // image shown based on the previous index in historic
                SizedBox(
                  height: 42.0,
                  child: rollCount > 1
                      ? Image.asset(
                          diceImagesPath[historicDices[rollCount - 2] - 1])
                      : Container(),
                ),
                const SizedBox(height: 45.0),
                SizedBox(
                  height: 150.0,
                  child: Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Statistics',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Roll amount: $rollCount',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    Text(
                                      'Total points: $totalPoints',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    Text(
                                      'Average: ${averagePoints.toStringAsFixed(1)}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CombinationDicePercentage(
                                            imageNumber: 1,
                                            percentageNumber:
                                                getPercentageOf(1),
                                          ),
                                          CombinationDicePercentage(
                                            imageNumber: 2,
                                            percentageNumber:
                                                getPercentageOf(2),
                                          ),
                                          CombinationDicePercentage(
                                            imageNumber: 3,
                                            percentageNumber:
                                                getPercentageOf(3),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CombinationDicePercentage(
                                            imageNumber: 4,
                                            percentageNumber:
                                                getPercentageOf(4),
                                          ),
                                          CombinationDicePercentage(
                                            imageNumber: 5,
                                            percentageNumber:
                                                getPercentageOf(5),
                                          ),
                                          CombinationDicePercentage(
                                            imageNumber: 6,
                                            percentageNumber:
                                                getPercentageOf(6),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CombinationDicePercentage extends StatelessWidget {
  final int imageNumber;
  final double percentageNumber;
  const CombinationDicePercentage({
    super.key,
    required this.imageNumber,
    required this.percentageNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 35.0,
              child: Image.asset('lib/images/$imageNumber.png'),
            ),
            RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.primary),
                  children: [
                    TextSpan(text: percentageNumber.toStringAsFixed(1)),
                    const TextSpan(text: '%', style: TextStyle(fontSize: 16.0)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
