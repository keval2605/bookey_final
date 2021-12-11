import 'package:flutter/material.dart';
import 'error_widget.dart';
import 'loading_widget.dart';
import '../util/enum/api_request_status.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus apiRequestStatus;
  final Widget child;
  final Function reload;

  BodyBuilder({Key key, this.apiRequestStatus, this.child, this.reload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return LoadingWidget();
        break;
      case APIRequestStatus.unInitialized:
        return LoadingWidget();
        break;
      case APIRequestStatus.connectionError:
        return MyErrorWidget();
        break;
      case APIRequestStatus.error:
        return MyErrorWidget();
        break;
      case APIRequestStatus.loaded:
        return child;
        break;
      default:
        return LoadingWidget();
    }
  }
}
