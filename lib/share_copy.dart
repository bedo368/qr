import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';

class CopyShareWidget extends StatelessWidget {
  final String data;

  const CopyShareWidget({
    super.key,
    required this.data,
  });

  void shareData(BuildContext context) {
    Share.share(data);
  }

  void copyData(BuildContext context) {
    FlutterClipboard.copy(data).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('the result is now copied'),
      ));
    });
  }

  shareContent({required String data, required BuildContext context}) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      data,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => shareContent(context: context, data: data),
            icon: const Icon(Icons.share),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () => copyData(context),
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
    );
  }
}
