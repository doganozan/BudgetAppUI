
import 'package:budgetappui/helpers/color_helper.dart';
import 'package:budgetappui/screens/category_screen.dart';
import 'package:budgetappui/widgets/bar_chart.dart';
import 'package:budgetappui/data/data.dart';
import 'package:budgetappui/models/category_model.dart';
import 'package:budgetappui/models/expense_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  _buildCategory(Category category,double totalAmountSpent){
    return GestureDetector(
      onTap: ()=>Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_)=>CategoryScreen(category: category,)
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0,2),
              blurRadius: 6.0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(category.name,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,fontFamily: 'Montserrat'),),
                Text('\$${(category.maxAmount-totalAmountSpent).toStringAsFixed(2)}/\$${category.maxAmount.toStringAsFixed(2)}',style: TextStyle(fontFamily: 'Montserrat',fontSize: 12.0,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 10.0),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double maxBarWidth = constraints.maxWidth;
            final double percent = (category.maxAmount - totalAmountSpent) /
                category.maxAmount;
            double barWidth = percent * maxBarWidth;

            if (barWidth < 0) {
              barWidth = 0;
            }
            return Stack(
              children: <Widget>[
                Container(
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                Container(
                  height: 20.0,
                  width: barWidth,
                  decoration: BoxDecoration(
                    color: getColor(context, percent),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ],
            );
          },
        ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            forceElevated: true,
            expandedHeight: 70.0,
            leading: IconButton(
              icon: Icon(Icons.menu),
              iconSize: 30.0,
              onPressed: (){},
            ),
            flexibleSpace:FlexibleSpaceBar(
              title: Text('Budget App',style: TextStyle(fontFamily: 'Montserrat'),),
              centerTitle: true,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                iconSize: 30.0,
                onPressed: (){} ,
              )
            ]

            ,),
          SliverList(
           delegate: SliverChildBuilderDelegate(
               (BuildContext context, int index){
                 if (index==0) {
                   return Container(
                     margin: EdgeInsets.all(2.0),
                     decoration: BoxDecoration(
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(color: Colors.black12,
                               offset: Offset(0, 2),
                               blurRadius: 6.0)
                         ],
                         borderRadius: BorderRadius.circular(10.0)
                     ),
                     child: BarChart(expenses: weeklySpending),
                   );
                 } else{
                   final Category category=categories[index-1];
                   double totalAmountSpend=0;

                   category.expenses.forEach((Expense expense){
                   totalAmountSpend+=expense.cost;
                   });
                   return _buildCategory(category,totalAmountSpend);
                 }
               },
             childCount: 1+categories.length,
           ),
          ),
        ],
      ),
    );
  }
}
