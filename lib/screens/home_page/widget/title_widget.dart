import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Bill # C12H4F55',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Counter: 01',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'CASH Cash: 0.00',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Card: 0.00',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '30-Jan-2024',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '09:02 PM',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),],
    );
  }
}
