import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:treee/pages/mint_nft_page.dart';
import 'package:treee/services/functions.dart';
import 'package:treee/utils/constants.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? ethClient;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(alchemy_rpc_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Treee")
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Treee",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => MintTreeNFTPage(ethClient: ethClient!)));
              },
                child: Text("Mint Treee NFT"),
              ),
            )
          ],
        )

      )
    );

  }
}
