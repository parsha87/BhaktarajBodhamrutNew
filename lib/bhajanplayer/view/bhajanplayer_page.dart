import 'package:bodhamrut/bhajanplayer/bhajanplayer.dart';
import 'package:bodhamrut/home/data/models/bhajans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/colors.dart';

class BhajanPlayerPage extends StatefulWidget {
  const BhajanPlayerPage({super.key});

  @override
  State<BhajanPlayerPage> createState() => _BhajanPlayerPageState();
}

class _BhajanPlayerPageState extends State<BhajanPlayerPage> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return RepositoryProvider(
      create: (context) => BhajanRepository(),
      child: BlocProvider(
        create: (context) => BhajanplayerBloc(
            bhajanRepository: RepositoryProvider.of<BhajanRepository>(context))
          ..add(GetBhajanFromIdEvent(data.values.first.id)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<BhajanplayerBloc, BhajanplayerState>(
            builder: (context, state) {
              if (state is BhajanplayerLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is BhajanPlayerSuccess) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top,
                  ),
                  child:Text(state.bhajan.displayName)  
               );
              }
              if (state is BhajanViewError) {
                return const Center(
                  child: Text('Error'),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
