import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DocumentPage extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const DocumentPage(
      {Key? key, required this.files, required this.onOpenedFile})
      : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doc'),
      ),
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemCount: widget.files.length,
          itemBuilder: (context, index) {
            final file = widget.files[index];
            // var color = files[index].extension;
            return buildFiles(file);
          },
        ),
      ),
    );
  }

  Widget buildFiles(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${mb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    final color = Colors.blue;
    return InkWell(
      onTap:()=> widget.onOpenedFile(file),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                '.$extension',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            file.name,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          Text(
            fileSize,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  // MaterialColor? getColor(String extension) {
  //   switch (extension) {
  //     case 'xlsx':
  //       {
  //         return Colors.amber;
  //       }
       

  //     case 'pdf':
  //       {
  //         return Colors.blue;
  //       }
  //     case 'docx':
  //       {
  //         return Colors.orange;
  //       }
  //     default:
  //       {
  //         return Colors.grey;
  //       }
       
  //   }
  // }
}
