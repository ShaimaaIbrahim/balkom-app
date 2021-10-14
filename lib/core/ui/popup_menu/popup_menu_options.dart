// import 'package:ojos_app/core/res/global_color.dart';
// import 'package:flutter/material.dart';
//
// // Layer above PopupMenu class(core/ui/popup_menu/popup_menu.dart)
// //In the event of an error in the file mentioned above, the modification is made only once here.
// class PopupMenuOptions {
//   final BuildContext context;
//   final List<PopupMenuEntry<dynamic>> items;
//   var positions;
//
//   PopupMenuOptions(
//       {required this.context, required this.positions, required this.items});
//
//   void show() {
//     final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();
//     showMenu(
//       color: globalColor.black,
//       context: context,
//       shape: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           borderSide: BorderSide(color: globalColor.basic2)),
//       position: RelativeRect.fromRect(
//           positions & Size(10, 10), // smaller rect, the touch area
//           Offset.zero & overlay.size // Bigger rect, the entire screen
//           ),
//       items: items,
//     );
//   }
//
// //  menuItemAddToFav(
// //      {String titleFav,
// //      String titleUnFav,
// //      bool isFav,
// //    required  CancelToken cancelToken,
// //      String id,
// //      //to select if subject or topic or path
// //      String entityType,
// //      void Function(bool newState) onUpdateState}) {
// //
// //    return PopupMenuItem(
// //      height: ScreenUtil().setHeight(40),
// //      child: ActionButton(
// //        initialState: isFav,
// //        onStateChanged: (state) {
// //          if (onUpdateState != null) {
// //            onUpdateState(state);
// //          }
// //        },
// //        handler: (bool state) {
// //          return AddRemoveFav(locator<CoreRepository>())(
// //            AddRemoveFavParams(
// //              cancelToken: cancelToken,
// //              data: AddRemoveFavRequest(
// //                  id: id,
// //                  process: state ? REMOVE_FAV : ADD_FAV,
// //                  entity: entityType),
// //            ),
// //          );
// //        },
// //        builder: (required BuildContext context,  bool state) {
// //          return Container(
// //            height: ScreenUtil().setHeight(40),
// //            child: Row(
// //              crossAxisAlignment: CrossAxisAlignment.center,
// //              children: <Widget>[
// //                Icon(
// //                  state
// //                      ? MaterialIcons.favorite
// //                      : MaterialIcons.favorite_border,
// //                  color: globalColor.secondaryColor,
// //                  size: IconSize.normal,
// //                ),
// //                SizedBox(
// //                  width: 4,
// //                ),
// //                Container(
// //                  child: Text(state ? titleUnFav : titleFav,
// //                      style: textStyle.smallTextSecondry),
// //                ),
// //              ],
// //            ),
// //          );
// //        },
// //      ),
// //    );
// //  }
// }
