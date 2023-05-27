import 'package:flutter/material.dart';
import 'package:hua_culture/entity/photo_entity.dart';
import 'package:hua_culture/public/config.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewerWithGrid extends StatelessWidget {
  final List<PhotoEntity> photos;

  const PhotoViewerWithGrid({
    Key key,
    @required this.photos
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,//解决listview嵌套报错
        physics: NeverScrollableScrollPhysics(),//禁用滑动事件
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: photos.length == 1 ? 2 : 3,//横轴元素个数
            mainAxisSpacing: 8,//纵轴间距
            crossAxisSpacing: 8,//横轴间距
            childAspectRatio: 1.0,//子组件宽高长度比
          ),
        itemCount: photos == null ? 0 : photos.length,////////
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Image.network(globalUrl + photos[index].url, fit: BoxFit.cover,),
            onTap: (){
              Navigator.of(context).push(
                new FadeRoute(//渐入渐出路由
                  page: GalleryPhotoViewWrapper(
                    galleryItems: photos,
                    initialIndex: index,
                  ),
                )
              );
            },
          );
        }
      )
    );
  }
}

//渐入渐出路由
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page}): super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>page,transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) =>FadeTransition(
    opacity: animation,
    child: child,
  ),
  );
}


class GalleryPhotoViewWrapper extends StatefulWidget {
  final int initialIndex;
  final List galleryItems;

  GalleryPhotoViewWrapper({
    Key key,
    this.initialIndex,
    @required this.galleryItems,
  }) : super(key: key);

  @override
  _GalleryPhotoViewWrapperState createState() => _GalleryPhotoViewWrapperState();
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;
  
  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height,),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollDirection: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
              itemCount: widget.galleryItems.length,
              backgroundDecoration: BoxDecoration(color: Colors.black),
              pageController: PageController(initialPage: currentIndex),
              onPageChanged: onPageChanged,
              builder: (BuildContext context, int index) {
                PhotoEntity photoEntity = widget.galleryItems[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(globalUrl + photoEntity.url),
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes: PhotoViewHeroAttributes(tag: photoEntity.groupID + 1),
                );
              },
            ),
            Positioned(//图片index显示
              top: MediaQuery.of(context).padding.top+15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("${currentIndex+1}/${widget.galleryItems.length}",style: TextStyle(color: Colors.white,fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}