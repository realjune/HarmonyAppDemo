import { webview } from '@kit.ArkWeb';
import JSBridge from '../common/util/JsBridge';
import { display } from '@kit.ArkUI';
import { promptAction } from '@kit.ArkUI';
import JsLogger from '../common/util/JsLogger';
import { CommonConstants } from '../common/constant/CommonConstant';

@Entry
@Component
struct WebLocalH5 {
  @StorageLink('isClick') isClick: boolean = false;
  @StorageLink('proportion') proportion: number = 0;
  @StorageLink('tel') phoneNumber: string = '';
  @State message: string = 'Hello World';
  webController: webview.WebviewController = new webview.WebviewController();
  private jsBridge: JSBridge = new JSBridge(this.webController);
  @State chargeTip: Resource = $r('app.string.recharge_button');

  aboutToAppear(): void {
    display.getAllDisplays((err, displayClass: display.Display[]) => {
      if (err.code) {
        JsLogger.error('WebLocalH5 Page', 'Failed to obtain all the display objects. Code: ' + JSON.stringify(err))
        return
      }
      this.proportion = displayClass[0].densityDPI / CommonConstants.COMMON_VALUE
    })
  }

  build() {
    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)


      Web({
        src: $rawfile('web/PhonePage.html'),
        controller: this.webController
      }).javaScriptAccess(true)
        .javaScriptProxy(this.jsBridge.javaScriptProxy)
        .height($r('app.float.web_height'))
        .onPageBegin(() => {
          this.jsBridge.initJsBridge()
        })


      Blank()

      Button(this.chargeTip)
        .width(CommonConstants.FULL_SIZE)
        .height($r('app.float.button_height'))
        .margin({ bottom: $r('app.float.button_margin_bottom') })
        .enabled(this.isClick)
        .onClick(() => {
          promptAction.showToast({
            message: this.phoneNumber === '' ? $r('app.string.phone_check') : $r('app.string.recharge_success')
          });
        })
    }
    .width(CommonConstants.FULL_SIZE)
    .height(CommonConstants.FULL_SIZE)
    .backgroundColor($r('app.color.page_color'))
    .padding({
      left: $r('app.float.margin_left_normal'),
      right: $r('app.float.margin_right_normal')
    })
  }
}