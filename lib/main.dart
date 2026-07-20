import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_project/data/helper/hive_helper.dart';
import 'package:hive_project/ui/cubits/crocery_cubit.dart';
import 'package:hive_project/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CroceryCubit(),
        child: HomePage(),
      ),
    );
  }
}
