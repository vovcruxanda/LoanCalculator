import 'package:flutter/material.dart';

void main() { //main entry point of the application
  runApp(const MyApp()); //it takes a widget that give us the UI and logic for the app
}//when the app is started the main function is the first thing that gets executed

class MyApp extends StatelessWidget { // extends is a keyword that says that class MyApp is stateless
  const MyApp({super.key}); //This is a constant app called MyApp, and it might have a special name tag (key) to help identify it.

  //Stateless widgets are like a picture. Once it's created, it doesn't change or update.
  //Stateful widgets are more like a smartphone app. They can change their appearance or behavior based on user interaction or data changes.

  @override
  Widget build(BuildContext context) { // the method that create my user interface
    return const MaterialApp( //MaterialApp is a widget that sets up the basic structure of the app
      home: LoanCalculator(), //This tells the MaterialApp to show the LoanCalculator widget as the main screen when the app starts
    );
  }
}

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({super.key});

  @override
  LoanCalculatorState createState() => LoanCalculatorState();
}

class LoanCalculatorState extends State<LoanCalculator> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _percentController = TextEditingController();
  double _months = 1;
  double _monthlyPayment = 0.0;

  final TextStyle _labelStyle = const TextStyle( //defines a constant variable for the style of text used next.
    fontSize: 16,
    fontFamily: 'Arial',
  );



  void _calculatePayment() {
    final double amount = double.tryParse(_amountController.text) ?? 0;
    final double percent = double.tryParse(_percentController.text) ?? 0;

    if (amount > 0 && percent > 0) {
      setState(() {
        _monthlyPayment = (amount * (percent / 100)) / _months;
      });
    }
  }

  @override
  Widget build(BuildContext context) { // it is a widget tree that is rendered on the screen
    return Scaffold( // it provides the basic structure of the page(AppBar at the top and body for the main content)
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Loan Calculator',
          style: TextStyle(fontSize: 40, fontFamily: 'Arial',  fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //Column - arrange the child vertically one below other
          //Row - arrange the child horizontally side by side
          //Stack - places widgets on top of each other, like stacking layers
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter amount', style: _labelStyle),
            TextField( //for text input
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),
            Text('Enter number of months', style: _labelStyle),
            SliderTheme( // the style for the line and button to set the months
              data: const SliderThemeData(
                activeTrackColor: Color.fromRGBO(14, 34, 200, 1.0),
                inactiveTrackColor: Colors.grey,
                thumbColor: Color.fromRGBO(14, 34, 200, 1.0), // Thumb (the circle that is dragged)
                valueIndicatorColor: Color.fromRGBO(14, 34, 200, 1.0),
                trackHeight: 6.0, // Adjusts the thickness of the slider
              ),
              child: Slider(
                value: _months,
                min: 1,
                max: 60,
                divisions: 59,
                label: '${_months.round()} months',
                onChanged: (value) {
                  setState(() {
                    _months = value;
                  });
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1'), // Min value
                  Text('60 months'), // Max value
                ],
              ),
            ),
            Text('Enter % per month', style: _labelStyle),
            TextField(
              controller: _percentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Percent',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)), // Set the radius for rounding
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                height: 150, // Set a fixed height for the card container
                width: 500, // Set a fixed width for the card container
                decoration: BoxDecoration(
                  color: Colors.grey[100], // Outer card background color
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Top section (Text label) full width
                    Expanded( // widget for the child to take up all available space in the parent
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ), // Only top corners are rounded
                          color: Color.fromARGB(241,242,246,255), // Top rectangular color
                        ),
                        child: const Text(
                          'You will pay the approximate amount monthly:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    // Bottom section (Number) full width
                    Container(
                      width: double.infinity, // Take the full width of the parent
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ), // Only bottom corners are rounded
                        color: Color.fromARGB(255,255,255,255), // Bottom rectangular color
                      ),
                      child: Text(
                        '${_monthlyPayment.toStringAsFixed(2)}€',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Arial',
                          color: Color.fromARGB(255, 9, 81, 223),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _calculatePayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 190, vertical: 15), // Adjust padding as needed
                  backgroundColor: const Color.fromRGBO(14, 34, 200, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
