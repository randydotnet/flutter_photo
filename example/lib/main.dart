import 'package:flutter/material.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pick Image Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Pick Image Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentSelected = "";

  void _pickImage() async {
    List<ImageEntity> imgList = await PhotoPicker.pickImage(
      context: context, // BuildContext requied

      /// The following are optional parameters.
      themeColor: Colors.green, // the title color and bottom color
      padding: 1.0, // item padding
      dividerColor: Colors.deepOrange, // divider color
      disableColor: Colors.grey.shade300, // the check box disable color
      itemRadio: 0.88, // the content item radio
      maxSelected: 8, // max picker image count
      provider: I18nProvider.chinese, // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
      rowCount: 5,  // item row count
      textColor: Colors.white, // text color
      thumbSize: 150, // preview thumb size , default is 64
      sortDelegate: SortDelegate.common, // default is common ,or you make custom delegate to sort your gallery
      checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(), // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox
    );

    if (imgList == null) {
      currentSelected = "not select item";
    } else {
      List<String> r = [];
      for (var e in imgList) {
        var file = await e.file;
        r.add(file.absolute.path);
      }
      currentSelected = r.join("\n\n");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Text(
            '$currentSelected',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'pickImage',
        child: new Icon(Icons.add),
      ),
    );
  }
}
