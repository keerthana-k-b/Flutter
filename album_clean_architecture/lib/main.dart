import 'package:album_clean_architecture/features/album/data/datasources/album_remote_data_source.dart';
import 'package:album_clean_architecture/features/album/data/repositories/album_repository_impl.dart';
import 'package:album_clean_architecture/features/album/domain/usecases/get_albums.dart';
import 'package:album_clean_architecture/features/album/presentation/provider/album_provider.dart';
import 'package:album_clean_architecture/features/album/presentation/screens/album_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final dataSource = AlbumRemoteDataSource();
  final repository = AlbumRepositoryImpl(dataSource);
  final usecase = GetAlbums(repository);


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AlbumProvider(usecase),
          ),
        ],
        child: MyApp(),
      ),
  );
       
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AlbumScreen(),
    );
  }
}

