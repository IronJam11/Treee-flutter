import 'package:flutter/material.dart';
import 'package:treee/services/treee_functions.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';

const WALLET_ADDRESS = "0x3592638Dbe19AF5005A847CC0881876c87B50D29";

class NFTPage extends StatefulWidget {
  final Web3Client ethClient;

  NFTPage({required this.ethClient});

  @override
  _NFTPageState createState() => _NFTPageState();
}

class _NFTPageState extends State<NFTPage> {
  Future<List<Map<String, dynamic>>> fetchNFTs() async {
    return await getAllNFTs(widget.ethClient);
  }

  Future<bool> isVerified(int tokenId, String verifier) async {
    final result = await ask(
        "isVerified",
        [BigInt.from(tokenId), EthereumAddress.fromHex(verifier)],
        widget.ethClient);
    return result[0];
  }

  Future<void> verifyNFT(int tokenId) async {
    await ask("verify", [BigInt.from(tokenId)], widget.ethClient);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NFT Collection")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNFTs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error fetching NFTs"));
          }
          final nfts = snapshot.data ?? [];

          return ListView.builder(
            itemCount: nfts.length,
            itemBuilder: (context, index) {
              final nft = nfts[index]; // Use directly, no need to decode again
              return FutureBuilder<bool>(
                future: isVerified(int.parse(nft["tokenId"].toString()), WALLET_ADDRESS),
                builder: (context, verifySnapshot) {
                  bool isVerified = verifySnapshot.data ?? false;
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(nft["imageUri"]),
                        ListTile(
                          title: Text("Tree NFT #${nft["tokenId"]}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Species: ${nft["species"]}"),
                              Text(
                                  "Location: ${nft["latitude"]}, ${nft["longitude"]}"),
                              Text(
                                  "Planted: ${DateTime.fromMillisecondsSinceEpoch(int.parse(nft["planting"].toString()) * 1000)}"),
                              Text(
                                  "Death: ${nft["death"] == "115792089237316195423570985008687907853269984665640564039457584007913129639935" ? "Alive" : DateTime.fromMillisecondsSinceEpoch(int.parse(nft["death"].toString()) * 1000).toString()}"),
                              Text("Verifiers: ${nft["verifiers"]}"),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isVerified
                              ? null
                              : () => verifyNFT(
                                  int.parse(nft["tokenId"].toString())),
                          child: Text(isVerified ? "Verified" : "Verify"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
