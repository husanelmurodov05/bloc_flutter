
import 'package:bloc_flutter/bloc/pizza_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/pizza_model.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PizzaBloc()..add(LoadPizzaCounter()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Pizza Bloc',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("The Pizza Bloc"),
      ),
      body: Center(
          child: BlocBuilder<PizzaBloc, PizzaState>(builder: (context, state) {
        if (state is PizzaInitial) {
          return const CircularProgressIndicator(
            color: Colors.orange,
          );
        }
        if (state is PizzaLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${state.pizzas.length}',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      for (int index = 0; index < state.pizzas.length; index++)
                        Positioned(
                           // left: random.nextInt(250).toDouble(),
                           //top: random.nextInt(400).toDouble(),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: state.pizzas[index].image,
                            ))
                    ]),
              )
            ],
          );
        } else {
          return Text("Something went wrong!");
        }
      })),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[0]));
            },
            child: Icon(Icons.local_pizza_outlined),
            backgroundColor: Colors.orange[800],
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[0]));
            },
            child: Icon(Icons.remove),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.orange[500],
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[1]));
            },
            child: Icon(Icons.local_pizza),
          ),
            SizedBox( 
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.orange[500],
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[1]));
            },
            child: Icon(Icons.remove),
          ),

        ],
      ),
    );
  }
}
