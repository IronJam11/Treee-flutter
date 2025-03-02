// import 'package:walletconnect_dart/walletconnect_dart.dart';
// import 'package:url_launcher/url_launcher.dart';

// class WalletService {
//   late WalletConnect connector;
//   late SessionStatus session;

//   WalletService() {
//     connector = WalletConnect(
//       bridge: 'https://bridge.walletconnect.org',
//       clientMeta: const PeerMeta(
//         name: 'MetaMask Flutter App',
//         description: 'A Flutter app connected to MetaMask',
//         url: 'https://walletconnect.org',
//         icons: [
//           'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png'
//         ],
//       ),
//     );

//     connector.on('connect', (session) => print('Connected: $session'));
//     connector.on('session_update', (payload) => print('Session updated: $payload'));
//     connector.on('disconnect', (session) => print('Disconnected: $session'));
//   }

//   Future<void> connect() async {
//     if (!connector.connected) {
//       try {
//         session = await connector.createSession(
//           chainId: 1,
//           onDisplayUri: (uri) async {
//             if (await canLaunch(uri)) {
//               await launch(uri);
//             } else {
//               throw 'Could not launch $uri';
//             }
//           },
//         );
//         print('Connected to account: ${session.accounts[0]}');
//       } catch (e) {
//         print('Error connecting to wallet: $e');
//       }
//     }
//   }
// }
