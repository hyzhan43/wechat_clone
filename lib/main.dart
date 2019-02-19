import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart';
import 'package:flutter_wechat/home/home_screen.dart';

void main() => runApp(MaterialApp(
      title: '微信',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(AppColors.AppBarColor),
      ),
      home: HomeScreen(),
    ));
