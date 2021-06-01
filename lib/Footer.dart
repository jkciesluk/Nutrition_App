import 'dart:ui';

import 'package:flutter/material.dart';
import 'DailyNeeds.dart';



class Footer extends StatelessWidget {

  Widget _buildField(String name, int max, int currentDailyNeeds, Color progressColor) {
    final bool _overflow = currentDailyNeeds > max;
    final double _progress = currentDailyNeeds / max;
    final double _overflowSize = _progress - 1.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$name'),
        Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: _overflow ? 40 : 40 * _progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                ),
                Container(
                  height: 10,
                  width: !_overflow ? 0 : _overflowSize >= 1.0 ? 40 : 40 * _overflowSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.red,
                  ),
                )
              ],
            ),
          Text('$currentDailyNeeds / $max'),
        
      ],
    );

  } 
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
    child: Container(
      padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          _buildField('Calories', totalDailyNeeds.kcal, currentDailyNeeds.kcal, Colors.blue),        
          _buildField('Protein', totalDailyNeeds.protein, currentDailyNeeds.protein, Colors.green),        
          _buildField('Fat', totalDailyNeeds.fat, currentDailyNeeds.fat, Colors.orange),        
          _buildField('Carbs', totalDailyNeeds.carbs, currentDailyNeeds.carbs, Colors.yellow),        
          

          ],
        ),
    ));
  }
}

