import 'package:flutter/material.dart';
import 'package:graineasy/di/locator.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:provider/provider.dart';


class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;
  BaseView({@required this.builder, this.onModelReady});
  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>>
      {
  T model = locator<T>();
  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    return ChangeNotifierProvider<T>(
      builder: (context) {
        if (model is BaseModel) {
          (model as BaseModel).context = context;
        }
        return model;
      },
      child: Consumer<T>(builder: widget.builder),

    );

  }
}
