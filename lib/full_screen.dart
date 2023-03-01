import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';


class FullScreen extends StatefulWidget {
  final String imageUrl;
   FullScreen({super.key,required this.imageUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {


  // Future<void> setWallPaper() async{
  //   int location = WallpaperManager.HOME_SCREEN;
  //   var file = DefaultCacheManager().getSingleFile(widget.imageUrl);
  //   final bool result = await WallpaperManager.setWallpaperFromFile(file.toString(), location);

  // }

   Future<void> setWallpaper() async {
    try {
      // String url = "https://source.unsplash.com/random";
      int location = WallpaperManager
          .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
            Expanded(child: Container(
              child: Image.network(widget.imageUrl),
            )),
            InkWell(
            onTap: (){
              setWallpaper();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              child: const Center(child: Text('Set WallPaper')),
            ),
          ),
          ],

        )
      ),
    );
  }
}