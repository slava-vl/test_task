import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/assets.gen.dart';

import '../../../core/ui_kit/ui_kit.dart';
import '../../home/data/model/payload.dart';
import '../../home/data/model/point.dart';
import 'widgets/map_container.dart';

class ObjectSchemePage extends StatelessWidget {
  final Payload item;
  const ObjectSchemePage({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: _getImageMap(
        'https://s3-alpha-sig.figma.com/img/3dff/c8e5/57a8622767f36d7847ad3284c566399d?Expires=1715558400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LKbA2Mneo7HE7g2v6FxZAwXBr9LgwtLmJaE11LHulN~Axq5bnecwn4o~KllojYtEvVccOmxnbCiDSCr3kldsRFroKUp3CcPGHENRKkm4IvD6aKR5nKM729rC8gUwoVX7Cnw2CwCt9xGZI3HAcIIQi4UTQreMZbxHxm1sAdmKbSOeltx2Hikuu4nbiHCGVCAau5ZODFWKs4hRr4zgAG3V14n7~Kjq4Uy4h4MA8Ck0b7-HvWARuVrYc70wdVgj3ksuxaot36Y66Qr0QATIpfWLstj7j9CSrFjLfYGyvFQMDzUJPiLI4ZWGiJbGuh8nulXpZ0V4--FVhSHkujFkMkdZkg__',
      ),
    );
  }

  Widget _getImageMap(String url) {
    return FutureBuilder(
        future: _calculateImageDimension(url),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const LoadingLayout();
          }
          if (snapShot.hasError) {
            return const ErrorLayout(message: 'error happened when download image');
          }
          return Center(
            child: MapContainer(
              onMarkerClicked: (_) {},
              size: (snapShot as AsyncSnapshot).data,
              markerWidgetBuilder: _getMarkerWidget,
              markers: _getMarker(item.points, (snapShot as AsyncSnapshot).data),
              child: Image(image: CachedNetworkImageProvider(url)),
            ),
          );
        });
  }

  Future<Size> _calculateImageDimension(String imageUrl) {
    final completer = Completer<Size>();
    final image = Image(image: CachedNetworkImageProvider(imageUrl));
    image.image.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener(
        (image, synchronousCall) {
          final myImage = image.image;
          final size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  List<MarkerModel<Point>> _getMarker(List<Point> points, Size size) =>
      points.map((point) => MarkerModel(point, Offset(point.x, point.y))).toList();

  Widget _getMarkerWidget(double scale, MarkerModel data) =>
      (data as MarkerModel<Point>).data.status == PointStatus.completed
          ? Assets.icons.completed.svg()
          : Assets.icons.incompleted.svg();
}
