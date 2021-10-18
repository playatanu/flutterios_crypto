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
    postService.getPost();

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
              future: postService.getPost(),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name =
                            (snapshot.data?[index]['name']).toString();
                        String price = double.parse(((snapshot.data?[index]
                                    ['price_usd'])
                                .toStringAsFixed(2)))
                            .toString();
                        String priceChange = (snapshot.data?[index]
                                ['volume_1hrs_usd'])
                            .toString();

                        String iscrypto = priceChange = (snapshot.data?[index]
                                ['type_is_crypto'])
                            .toString();

                        // ignore: prefer_const_constructors
                        return CustomListTile(
                          name: name,
                          price: price,
                          priceChange: priceChange,
                          iscrypto: iscrypto,
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text('error');
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
