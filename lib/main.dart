import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos/network/network_cubit.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (context) => NetworkCubit(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NetworkCubit>(context).yukla();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vazifa"),
      ),
      body: BlocBuilder<NetworkCubit, NetworkState>(
        builder: (context, state) {
          if (state is NetworkInitial) {
            return SizedBox();
          } else if (state is NetworkLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NetworkSuccess) {
            return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.list[index].title ?? ""),
                  );
                });
          } else if (state is NetworkError) {
            return Center(
              child: Text(state.message.toString()),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
