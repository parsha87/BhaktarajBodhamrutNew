import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../auth/data/repository/auth_repository.dart';
import '../../bhajanplayer/bloc/bhajanplayer_bloc.dart';
import '../../bhajanplayer/data/repository/bhajan_player_repository.dart';
import '../../constants/app_theme.dart';
import '../../data/repository/app_repository.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/data/repository/home_repository.dart';
import '../../routes/app_routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepository(),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<BhajanRepository>(
          create: (context) => BhajanRepository(),
        ),
        // RepositoryProvider<CartRepository>(
        //   create: (context) => CartRepository(),
        // ),
        // RepositoryProvider<FavouriteRepository>(
        //   create: (context) => FavouriteRepository(),
        // ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
              appRepository: RepositoryProvider.of<AppRepository>(context),
            ),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              RepositoryProvider.of<HomeRepository>(context),
            ),
          ),
          BlocProvider<BhajanplayerBloc>(
            create: (context) => BhajanplayerBloc(
              bhajanRepository:
                  RepositoryProvider.of<BhajanRepository>(context),
            ),
          ),
          // BlocProvider<CartBloc>(
          //   create: (context) => CartBloc(
          //     cartRepository: RepositoryProvider.of<CartRepository>(context),
          //     appRepository: RepositoryProvider.of<AppRepository>(context),
          //   ),
          // ),
          // BlocProvider<FavouriteBloc>(
          //   create: (context) => FavouriteBloc(
          //     RepositoryProvider.of<FavouriteRepository>(context),
          //   ),
          // ),
        ],
        child: MaterialApp(
          theme: themeData,
          initialRoute: '/',
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
