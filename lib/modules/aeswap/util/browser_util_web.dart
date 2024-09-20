/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:js_interop' as js;
import 'dart:js_interop_unsafe';

class BrowserUtil {
  bool isBraveBrowser() {
    return js.globalContext.getProperty('navigator'.toJS) != null &&
        (js.globalContext.getProperty('navigator'.toJS)! as js.JSObject)
                .getProperty('brave'.toJS) !=
            null;
  }

  bool isEdgeBrowser() {
    return js.globalContext.getProperty('navigator'.toJS) != null &&
        (js.globalContext.getProperty('navigator'.toJS)! as js.JSObject)
                .getProperty('userAgent'.toJS) !=
            null &&
        ((js.globalContext.getProperty('navigator'.toJS)! as js.JSObject)
                .getProperty('userAgent'.toJS)! as js.JSString)
            .toDart
            .contains('Edg/');
  }

  bool isInternetExplorerBrowser() {
    return js.globalContext.getProperty('navigator'.toJS) != null &&
        (js.globalContext.getProperty('navigator'.toJS)! as js.JSObject)
                .getProperty('userAgent'.toJS) !=
            null &&
        (((js.globalContext.getProperty('navigator'.toJS)! as js.JSObject)
                    .getProperty('userAgent'.toJS)! as js.JSString)
                .toDart
                .contains('MSIE ') ||
            ((js.globalContext.getProperty('navigator'.toJS)! as js.JSObject)
                    .getProperty('userAgent'.toJS)! as js.JSString)
                .toDart
                .contains('Trident/'));
  }
}
