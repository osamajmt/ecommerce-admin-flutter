import 'package:admin_app/constant/imageasset.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 70,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Image.asset(
        ImageAsset.LogoImageAsset,
        height: 125,
        width: 125,
      ),
    );
  }
}

