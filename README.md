# Loan Calculator App - Flutter

This is a simple **Loan Calculator** application built using the Flutter framework. It allows users to input the loan amount, interest percentage, and loan duration to calculate the monthly payment.

## Code Overview

### `main.dart`

#### Imports
```dart
import 'package:flutter/material.dart';
```
The app is built using Flutter, and this import brings in the necessary widgets and tools from the Flutter framework.

#### `main()` Function
```dart
void main() {
  runApp(const MyApp());
}
```
The `main()` function is the entry point of the Flutter application. It calls `runApp()` which renders the `MyApp` widget to the screen.

#### `MyApp` Class
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoanCalculator(),
    );
  }
}
```
The `MyApp` class is a **stateless widget** that represents the structure of the app. It returns a `MaterialApp` widget, which is the root of the app. The `LoanCalculator` widget is set as the home screen.

#### `LoanCalculator` Class
```dart
class LoanCalculator extends StatefulWidget {
  const LoanCalculator({super.key});

  @override
  LoanCalculatorState createState() => LoanCalculatorState();
}
```
This class defines a **stateful widget**. A stateful widget can change its appearance or behavior based on user interaction. It links to its associated `LoanCalculatorState`, which handles the app's logic and UI updates.

#### `LoanCalculatorState` Class
```dart
class LoanCalculatorState extends State<LoanCalculator> {
```
This is the state class where all the logic and UI for the loan calculator are managed.

##### Variables
- `_amountController` and `_percentController`: Controllers for text fields where the user inputs the loan amount and the interest rate.
- `_months`: Stores the number of months selected by the user.
- `_monthlyPayment`: Stores the result of the loan calculation.

##### `_calculatePayment()` Method
```dart
void _calculatePayment() {
  final double amount = double.tryParse(_amountController.text) ?? 0;
  final double percent = double.tryParse(_percentController.text) ?? 0;

  if (amount > 0 && percent > 0) {
    setState(() {
      _monthlyPayment = (amount * (percent / 100)) / _months;
    });
  }
}
```
This method calculates the monthly payment based on the user inputs: loan amount, interest rate, and number of months. It uses `setState()` to update the UI when the calculation is performed.

#### Building the UI
```dart
@override
Widget build(BuildContext context) {
```
This method builds the UI for the loan calculator. It uses a `Scaffold` widget to create a structured layout with an `AppBar` at the top and a body containing the main content.

##### Key UI Elements:
- **TextFields**: For user input of the loan amount and interest rate.
- **Slider**: To select the number of months.
- **Card**: Displays the calculated monthly payment in a styled container.
- **ElevatedButton**: Triggers the payment calculation.

```dart
TextField(
  controller: _amountController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    labelText: 'Amount',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
  ),
),
```
The text fields allow the user to input the loan amount and interest rate, using controllers for capturing text.

```dart
Slider(
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
```
The slider allows users to choose the loan duration in months, from 1 to 60. As the user slides, the displayed label updates.

```dart
ElevatedButton(
  onPressed: _calculatePayment,
  child: Text('Calculate'),
),
```
The button, when pressed, runs the `_calculatePayment()` method to compute the monthly payment.

##### Monthly Payment Display
The calculated monthly payment is shown in a styled `Container` with a card-like appearance.
