import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/network_info.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/auth_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/splash/widget/splash_painter.dart';

class SplashScreen extends StatefulWidget {
  final int? orderId;

  const SplashScreen({Key? key, this.orderId}) : super(key: key);
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    NetworkInfo.checkConnectivity(context);
    Provider.of<SplashProvider>(context, listen: false).initConfig().then((bool isSuccess) {
      if(isSuccess) {
        Provider.of<SplashProvider>(context, listen: false).initShippingTypeList(context,'');
        Timer(const Duration(seconds: 1), () {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            Provider.of<AuthProvider>(context, listen: false).updateToken(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashboardScreen()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const AuthScreen()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, children: [
      // SizedBox(
      //   width: MediaQuery.of(context).size.width,
      //   height: MediaQuery.of(context).size.height,
      //   child: CustomPaint(
      //     painter: SplashPainter(),
      //   ),
      // ),

      Center(
        child:SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(Images.whiteLogo,
                fit: BoxFit.fill)
        ),
      ),
    ],
    );
  }

}






// Scaffold(
// backgroundColor: Theme.of(context).hintColor,
// body: SizedBox(
// height: double.infinity,
// width: double.infinity,
// child: Image.asset(Images.whiteLogo,
// fit: BoxFit.fill)
// ),
//
// );