import 'dart:io';
import 'package:alome/src/services/snackbar_service.dart';
import 'package:alome/src/core/constants/colors.dart';
import 'package:alome/src/core/constants/dimensions.dart';
import 'package:alome/src/core/utilities/validation_extension.dart';
import 'package:alome/src/features/authentication/models/app_user.dart';
import 'package:alome/src/features/authentication/notifiers/login_notifier.dart';
import 'package:alome/src/features/home/notifiers/home_notifier.dart';
import 'package:alome/src/widgets/app_buttons.dart';
import 'package:alome/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends ConsumerStatefulWidget {
  final AppUser user;
  const HomeView({Key? key, required this.user}) : super(key: key);
  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  void filePicker(ImageSource source) async {
    final selectImage = await _picker.pickImage(source: source);
    setState(() {
      image = selectImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final cardDetails = ref.watch(scanProvider).scanModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.light,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Scanning 😉',
          style: textTheme.headline2?.copyWith(
            color: AppColors.dark,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.small),
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey.shade100,
              child: Text(
                widget.user.userName[0].capitalize(),
              ),
            ),
          ),
          const Spacing.smallWidth(),
          IconButton(
            onPressed: () => ref.read(loginProvider.notifier).logoutUser(),
            icon: const Icon(Icons.logout),
            color: AppColors.dark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(Dimensions.big),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  height: 200,
                  width: width,
                  child: image == null
                      ? Center(
                          child: Text(
                            'Card would be shown here',
                            style: textTheme.headline6?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: 370,
                        ),
                ),
                const Spacing.mediumHeight(),
                SizedBox(
                  width: 100,
                  child: AppButton(
                    isLoading: ref.watch(scanProvider).isLoading,
                    label: 'Scan',
                    onPressed: () {
                      image == null
                          ? ref
                              .read(snackbarService)
                              .showErrorSnackBar('Please uplaod a card to scan')
                          : ref
                              .read(scanProvider.notifier)
                              .scanCard(imageFile: image!.path);
                    },
                  ),
                ),
                const Spacing.bigHeight(),
                cardDetails == null
                    ? Column()
                    : SizedBox(
                        height: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Scan Results',
                              style: textTheme.headline6?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text('Name: ${cardDetails.firstName} '),
                            Text('Name: ${cardDetails.lastName} '),
                            cardDetails.phones!.isEmpty
                                ? const Text('Phone: ')
                                : SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                        itemCount: cardDetails.phones!.length,
                                        itemBuilder: (context, index) => Text(
                                            'Phone: ${cardDetails.phones![index].number}')),
                                  ),
                            cardDetails.websites!.isEmpty
                                ? const Text('Website: ')
                                : SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        itemCount: cardDetails.websites!.length,
                                        itemBuilder: (context, index) => Text(
                                            'Website: ${cardDetails.websites![index].url}')),
                                  ),
                            cardDetails.emails!.isEmpty
                                ? const Text('Email: ')
                                : SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                        itemCount: cardDetails.emails!.length,
                                        itemBuilder: (context, index) => Text(
                                            'Email: ${cardDetails.emails![index].address}')),
                                  ),
                          ],
                        ),
                      )
              ],
            )),
      ),
      // body: Padding(
      //     padding: const EdgeInsets.all(Dimensions.big),
      //     child: forums.when(
      //       data: ((data) => data.isEmpty
      //           ? const EmptyList(
      //               text: 'No Forum yet, be the first to create a forum')
      //           : ListView.builder(
      //               physics: const BouncingScrollPhysics(),
      //               itemCount: data.length,
      //               itemBuilder: (context, index) => ForumTile(
      //                 forum: data[index],
      //               ),
      //             )),
      //       loading: () => const Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //       error: (_, __) => const ErrorList(),
      //     )),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22),
        backgroundColor: AppColors.deep,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          // FAB 1
          SpeedDialChild(
            child: const Icon(Icons.camera_alt_outlined),
            backgroundColor: AppColors.deep,
            onTap: () {
              filePicker(ImageSource.camera);
            },
            label: 'Camera',
            labelStyle: textTheme.headline6?.copyWith(color: AppColors.light),
            labelBackgroundColor: AppColors.deep,
          ),
          // FAB 2
          SpeedDialChild(
              child: const Icon(Icons.photo_library_outlined),
              backgroundColor: AppColors.deep,
              onTap: () {
                filePicker(ImageSource.gallery);
              },
              label: 'Gallery',
              labelStyle: textTheme.headline6?.copyWith(color: AppColors.light),
              labelBackgroundColor: AppColors.deep)
        ],
      ),
    );
  }
}
