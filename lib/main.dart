import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:stock_app/bloc/product_bloc/product_bloc.dart';
import 'package:stock_app/bloc/stock_bloc/stock_bloc.dart';
import 'package:stock_app/provider/tab_provider.dart';
import 'package:stock_app/repository/auth_repository.dart';
import 'package:stock_app/repository/product_repository.dart';
import 'package:stock_app/repository/stock_entry_repository.dart';
import 'package:stock_app/screens/login_screen.dart';
import 'package:stock_app/screens/dashboard.dart';
import 'package:stock_app/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TabProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRepository()),
        ),
        BlocProvider(
          create: (context) => StockBloc(StockEntryRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: provider.themeData,
        home: FirebaseAuth.instance.currentUser != null
            ? const Dashboard()
            : const LoginScreen(),
      ),
    );
  }
}
