import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visual_search/features/classifier/presentation/pages/visual_search_page.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../products/presentation/cubit/product_cubit.dart';
import '../cubit/classifier_cubit.dart';
import '../cubit/classifier_state.dart';

Future<void> requestGalleryPermission() async {
  if (Platform.isAndroid) {
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
      // Permission granted
    } else {
      // Open app settings or show dialog
      openAppSettings();
    }
  }
}

void showVisualSearchDialog(
  BuildContext context,
) {
  String categoryDropdownValue = 'Select';
  List<String> category = [
    'Select',
    'Jeans',
    'Skirt',
    'Tshirt',
    'Trousers',
    'Jacket',
  ];
  String patternDropdownValue = 'Select';
  List<String> pattern = [
    'Select',
    'Solid',
    'Striped',
    'Floral',
    'Graphics',
  ];
  String colorDropdownValue = 'Select';
  List<String> color = [
    'Select',
    'Red',
    'Green',
    'Blue',
    'Yellow    ',
    'Black',
  ];
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  context.read<ProductCubit>().getProducts();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppPallete.buttonBlueColor,
                  ),
                )),
            BlocBuilder<ClassifierCubit, ClassifierState>(
              builder: (context, state) {
                if (state is ClassifierSuccess) {
                  return TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VisualSearchPage(
                            categoryName:
                                state.predictions.$1.label.split(" ").last,
                            color: state.predictions.$2.label.split(" ").last,
                            pattern: state.predictions.$3.label.split(" ").last,
                          ),
                        ));
                      },
                      child: Text("Search",
                          style: TextStyle(
                            color: AppPallete.buttonBlueColor,
                          )));
                }
                if (state is ClassifierTextSearch) {
                  return TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VisualSearchPage(
                            categoryName: categoryDropdownValue,
                            color: colorDropdownValue.trim(),
                            pattern: patternDropdownValue,
                          ),
                        ));
                      },
                      child: Text("Search",
                          style: TextStyle(
                            color: AppPallete.buttonBlueColor,
                          )));
                }
                return TextButton(onPressed: null, child: Text("Search"));
              },
            ),
          ],
          title: Text("Search"),
          content: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<ClassifierCubit, ClassifierState>(
                builder: (context, state) {
                  if (state is ClassifierLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppPallete.buttonBlueColor,
                    ));
                  } else if (state is ClassifierSuccess) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(color: Colors.black, width: 5),
                                  image: DecorationImage(
                                    image: FileImage(state.imageFile),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<ClassifierCubit>()
                                        .removeImage();
                                  },
                                  icon: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.cancel,
                                      color: AppPallete.buttonBlueColor,
                                      size: 33,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        // Text(state.predictions.$1.label.split(" ").last),
                        // Text(state.predictions.$2.label.split(" ").last),
                        // Text(state.predictions.$3.label.split(" ").last),
                      ],
                    );
                  } else if (state is ClassifierError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Column(
                      children: [
                        StatefulBuilder(builder: (context, setState) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Category:"),
                                  DropdownButton(
                                    value: categoryDropdownValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: category.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        categoryDropdownValue = newValue!;
                                      });
                                      if (newValue != "Select") {
                                        context
                                            .read<ClassifierCubit>()
                                            .textSearch();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pattern:"),
                                  DropdownButton(
                                    value: patternDropdownValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: pattern.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: categoryDropdownValue == "Select"
                                        ? null
                                        : (String? newValue) {
                                            setState(() {
                                              if (newValue != "Solid") {
                                                colorDropdownValue = "Select";
                                              }

                                              patternDropdownValue = newValue!;
                                            });
                                          },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Color:"),
                                  DropdownButton(
                                    value: colorDropdownValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: color.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (patternDropdownValue != "Solid")
                                        ? null
                                        : (String? newValue) {
                                            setState(() {
                                              colorDropdownValue = newValue!;
                                            });
                                          },
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                        InkWell(
                          onTap: () async {
                            await requestGalleryPermission();
                            final picker = ImagePicker();
                            final picked = await picker.pickImage(
                                source: ImageSource.gallery);

                            if (picked != null) {
                              // ignore: use_build_context_synchronously
                              context
                                  .read<ClassifierCubit>()
                                  .classify(File(picked.path));
                            }
                          },
                          child: DottedBorder(
                            color: AppPallete.buttonBlueColor,
                            borderType: BorderType.RRect,
                            strokeWidth: 2,
                            radius: Radius.circular(5),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppPallete.borderColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                spacing: 5,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/Image.svg",
                                    height: 24,
                                    color: AppPallete.buttonBlueColor,
                                  ),
                                  Text(
                                    'Select Image for visual search',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppPallete.buttonBlueColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        );
      });
}



// StatefulBuilder(builder: (context, setState) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 selectedImage == null
//                     ? InkWell(
//                         onTap: () async {
//                           final ImagePicker picker = ImagePicker();
//                           final XFile? image = await picker.pickImage(
//                               source: ImageSource.gallery);
//                           selectedImage = image;
//                           setState(() {});
//                         },
//                         child: DottedBorder(
//                           color: Colors.white,
//                           borderType: BorderType.RRect,
//                           radius: Radius.circular(5),
//                           child: Container(
//                             padding: EdgeInsets.all(10),
//                             margin: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                                 color: Colors.white10,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Row(
//                               spacing: 5,
//                               children: [
//                                 Icon(Icons.image),
//                                 Text(
//                                   'Select Image',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     : SizedBox(
//                         height: 100,
//                         child: Image.file(
//                           File(selectedImage!.path),
//                           fit: BoxFit.fitHeight,
//                         ))
//               ],
//             );
//           })