import 'package:budgetappui/data/data.dart';
import 'package:budgetappui/models/expense_model.dart';

class Category {
  final String name;
  final double maxAmount;
  final List<Expense> expenses;

  Category({this.name, this.maxAmount, this.expenses});
}
