import 'package:app/res/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({required this.imageUrl, required this.size, Key? key}) : super(key: key);
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        imageBuilder: (context, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(color: Colors.blueGrey, shape: BoxShape.circle),
          child: Center(
            child: SpinKitRing(
              lineWidth: size / 20,
              color: Colors.lightBlue,
              size: size / 2,
            ),
          ),
        ),
        maxWidthDiskCache: 200,
        maxHeightDiskCache: 200,
      );
    } else {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: AssetImage(Assets.defaultProfileImage),
      );
    }
  }
}
