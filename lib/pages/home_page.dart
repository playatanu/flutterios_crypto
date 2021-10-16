import 'package:flutter/material.dart';
import 'package:flutterios_crypto/pages/setting_page.dart';
import 'package:flutterios_crypto/utilities/api.dart';
import 'package:flutterios_crypto/widgets/list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String _chosenValue = 'USD';
var items = ['USD', 'EURO', 'INR'];

class _HomePageState extends State<HomePage> {
  ApiService postService = ApiService();
  @override
  void initState() {
    postService.getPost(_chosenValue);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingPage()),
                );
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          FutureBuilder(
              future: postService.getPost(_chosenValue),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name =
                            (snapshot.data?[index]['asset']).toString();
                        String price =
                            (snapshot.data?[index]['rate']).toString();

                        // ignore: prefer_const_constructors
                        return CustomListTile(
                          name: name,
                          price: price,
                          image:
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/BTC_Logo.svg/1200px-BTC_Logo.svg.png',
                        );
                      });
                } else if (snapshot.hasError) {
                  return ListView(
                    children: [
                      CustomListTile(
                        name: 'Bitcoins',
                        price: "112",
                        image:
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/BTC_Logo.svg/1200px-BTC_Logo.svg.png',
                      ),
                      CustomListTile(
                        name: 'Erhereum',
                        price: "112",
                        image:
                            'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Ethereum-ETH-icon.png',
                      ),
                      CustomListTile(
                        name: 'Litecoin',
                        price: "112",
                        image:
                            'https://upload.wikimedia.org/wikipedia/commons/e/e3/Litecoin_Logo.jpg',
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          DropdownButton<String>(
            value: _chosenValue,
            items: items.map(buildMenuItem).toList(),
            onChanged: (String? value) => setState(() {
              _chosenValue = value!;
            }),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}
