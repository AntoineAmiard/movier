import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_helper/services/http.service.dart';
import 'package:movie_helper/services/storage.service.dart';
import 'package:rxdart/rxdart.dart';

// class SearchBar extends StatefulWidget {
//   final Function callback;
//   final bool isFocused;

//   SearchBar({this.callback, this.isFocused});

//   @override
//   SearchBarState createState() => SearchBarState();
// }

// class SearchBarState extends State<SearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     print(widget.isFocused ? false : true);
//     return Material(
//       child: TextField(
//         enabled: widget.isFocused ? true : false,
//         autofocus: widget.isFocused ? true : false,
//         // onTap: () => widget.isFocused ? {} : onTap(context),
//         decoration: InputDecoration(
//           filled: true,
//           prefixIcon: Icon(Icons.search),
//           hintText: "Recherche",
//           fillColor: Theme.of(context).cardColor,
//           focusColor: Colors.grey,
//           // hoverColor: Colors.grey,
//           border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(15)),
//         ),
//       ),
//     );
//   }
// }
typedef void OnCompleteCallback(String value);

class SearchBar extends StatefulWidget {
  final double maxHeight;

  //Suggestiondrop Down properties
  final int suggestionsApiFetchDelay;
  final Function onValueChanged;
  final OnCompleteCallback onCompleteCallback;

  SearchBar({
    this.maxHeight = 200,
    this.suggestionsApiFetchDelay = 0,
    this.onValueChanged,
    this.onCompleteCallback,
  });
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final HttpService httpService = HttpService();

  ScrollController scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();
  TextEditingController controller = new TextEditingController();
  Storage storage = Storage();
  OverlayEntry _overlayEntry;
  LayerLink _layerLink = LayerLink();
  final suggestionsStreamController = new BehaviorSubject<List<String>>();
  List<String> suggestionShowList = List<String>();
  Timer _debounce;
  bool isSearching = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print("has focus");
        this.isSearching = true;
        print(this.isSearching);
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
      } else {
        this._overlayEntry.remove();
      }
    });
    controller.addListener(_onSearchChanged);
    _focusNode.requestFocus();
  }

  Future<List<String>> getSuggestionsMethod(String string) async {
    return await httpService.getSuggestions(string);
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce =
        Timer(Duration(milliseconds: widget.suggestionsApiFetchDelay), () {
      if (isSearching == true) {
        _getSuggestions(controller.text);
      }
    });
  }

  _getSuggestions(String data) async {
    if (data.length > 0 && data != null) {
      print('Getting suggestion');
      setState(() => isLoading = true);
      List<String> list = await getSuggestionsMethod(data);
      setState(() => isLoading = false);
      suggestionsStreamController.sink.add(list);
    }
  }

  OverlayEntry _createOverlayEntry() {
    TextTheme textStyle = Theme.of(context).textTheme;
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Card(
            margin: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4.0,
            child: StreamBuilder<Object>(
                stream: suggestionsStreamController.stream,
                builder: (context, suggestionData) {
                  if (suggestionData.hasData && controller.text.isNotEmpty) {
                    suggestionShowList = suggestionData.data;
                    return ConstrainedBox(
                      constraints: new BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
                      child: ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: suggestionShowList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              title: Text(suggestionShowList[index],
                                  style: textStyle.body1),
                              onTap: () {
                                isSearching = false;
                                this._focusNode.unfocus();
                                controller.text = suggestionShowList[index];
                                suggestionsStreamController.sink.add([]);
                                storage.storeSearch(controller.text);
                                widget.onCompleteCallback(controller.text);
                              },
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextField(
        controller: controller,
        focusNode: this._focusNode,
        autofocus: true,
        onChanged: (text) {
          if (text.trim().isNotEmpty) {
            (widget.onValueChanged != null)
                ? widget.onValueChanged(text)
                : () {};
            isSearching = true;
            scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          } else {
            isSearching = false;
            suggestionsStreamController.sink.add([]);
          }
        },
        onEditingComplete: () async {
          isSearching = false;
          this._focusNode.unfocus();
          suggestionsStreamController.sink.add([]);
          await storage.storeSearch(controller.text);
          print(await storage.loadSearch());
          widget.onCompleteCallback(controller.text);
        },
        decoration: InputDecoration(
          filled: true,

          prefixIcon: Icon(Icons.search),
          suffixIcon: !isLoading
              ? IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.clear),
                  iconSize: 15,
                  onPressed: () {
                    controller.text = "";
                    _onSearchChanged();
                  },
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),

          hintText: "Recherche",
          fillColor: Theme.of(context).cardColor,
          focusColor: Colors.grey,
          // hoverColor: Colors.grey,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    suggestionsStreamController.close();
    scrollController.dispose();
    controller.dispose();
    super.dispose();
  }
}
