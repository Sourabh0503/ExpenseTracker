import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid= Uuid();
enum Category{ food, travel , work , shopping } 

final formatter = DateFormat.yMd();

const categoryIcon={
  Category.food: Icons.lunch_dining_rounded,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.shopping: Icons.shop,
};

class ExpenseModel {
  late final String title;
  late final double amount;
  late final DateTime expDate;
  late final Category expType;

  ExpenseModel( 
      {required this.title,
      required this.amount,
      required this.expDate,
      required this.expType});

  String get formattedDate{
    return formatter.format(expDate);
  }
}

class Expenses{
  Expenses({required this.expList});
  List<ExpenseModel> expList;

  double categoryTotal(Category expType){
    double catSum=0;
    for(var exp in expList){
      if(exp.expType==expType){
        catSum+=exp.amount;
      }
    }
    return catSum;
  }

  double get totalExpense{
    double sum=0;
    for(var exp in expList){
      sum+=exp.amount;
    }
    return sum;
  }

}