import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.name,
    required this.price,
    required this.iscrypto,
    required this.priceChange,
  }) : super(key: key);
  final String name, price, iscrypto, priceChange;

  @override
  Widget build(BuildContext context) {
    return (iscrypto == '0')
        ? const SizedBox()
        : ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(name[0]),
            ),
            title: Text(name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              //ignore: prefer_const_literals_to_create_immutables,
              children: [
                Text(price),
                const Text(
                  '1 hour, -1.23%',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
  }
}
