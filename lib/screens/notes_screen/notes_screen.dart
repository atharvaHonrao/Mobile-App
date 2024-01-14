import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool _isFilterVisible = false;
  FilePickerResult? selectedFiles;
  bool dialogVisible = false;

  void _toggleFilterVisibility() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  Future<void> _pickFiles() async {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: true,
    );

    if (results != null) {
      setState(() {
        selectedFiles = results;
      });
    } else {
      // User canceled the picker
    }
  }

  void deselectFile(PlatformFile file) {
    setState(() {
      selectedFiles!.files.remove(file);
    });
  }

  void openFile(String? filePath) {
    if (filePath != null) {
      OpenFile.open(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dialogVisible
          ? Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Dialog(
                    insetPadding: EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1.0,
                      ),
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: SizedBox(
                      height: 500.0,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Add Note',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: Theme.of(context).colorScheme.outline,
                              thickness: 1.0,
                              height: 0,
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                labelText: "Title",
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                labelText: "Description",
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Attachments',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Selected Files:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(
                              height: 96,
                              child: ListView.builder(
                                itemCount: selectedFiles?.files.length ?? 0,
                                itemBuilder: (context, index) {
                                  var file = selectedFiles!.files[index];
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 2.0),
                                    child: GestureDetector(
                                      onTap: () => openFile(file.path),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              file.name ?? '',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => deselectFile(file),
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _pickFiles();
                                },
                                child: Text('Attach'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 40,
                  right: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dialogVisible = false;
                          });
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            dialogVisible = false;
                          });
                        },
                        child: Icon(Icons.close, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : null,
      floatingActionButton: !dialogVisible
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  dialogVisible = true;
                });
              },
              tooltip: 'Add Notes',
              child: Icon(Icons.add, color: Colors.blue),
            )
          : null,
    );
  }
}
