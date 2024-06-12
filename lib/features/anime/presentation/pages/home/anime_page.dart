import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/features/anime/presentation/bloc/anime/remote/remote_anime_bloc.dart';
import 'package:my_its_anime_list/features/anime/presentation/bloc/anime/remote/remote_anime_state.dart';
import 'package:my_its_anime_list/features/anime/presentation/widgets/anime_tile.dart';

class AnimePage extends StatelessWidget {
  const AnimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: AppBar(
        title: const Text(
        'Anime',
        style: TextStyle(
        color: Colors.black,
          ),
        ),
      ),
    );
  }

  _buildBody(){
    return BlocBuilder<RemoteAnimeBloc, RemoteAnimeState>(
      builder: (_,state){
        if(state is RemoteAnimeLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is RemoteAnimeError){
          return const Center(child: Icon(Icons.refresh));
        }
        if(state is RemoteAnimeDone){
          return ListView.builder(itemBuilder: (context, index){
            return AnimeWidget(
              Anime: state.anime![index]
            );
            },
            itemCount: state.anime!.length,
          );
        }
        return const SizedBox();
      },
    );
  }
}
