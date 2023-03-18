import 'package:expense_calculator/models/expense_item.dart';

import '../datetime/date_time_helper.dart';

class ExpenseData {
  // list of all the expenses
  List<ExpenseItem> overallExpenseList = [
    ExpenseItem(
        name: 'food', amount: '2', dateTime: DateTime.parse('12/09/2020'))
  ];

  //get expense list
  List<ExpenseItem> getExpenseList() {
    return overallExpenseList;
  }

  // add new Expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
  }

  //delete expenses
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
  }

  // get weekday (mon,tues) from a date  time object

  String getDayByName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get ste date for the start of the week (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get todays date
    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayByName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date(yyyymmdd) :amountTotal
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount = currentAmount + amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
