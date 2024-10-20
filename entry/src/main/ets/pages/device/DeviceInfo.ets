import deviceInfo from '@ohos.deviceInfo';
import router from '@ohos.router';

@Entry
@Component
struct DeviceInfo {
  @State message: string = 'Hello World';
  private scrollerForScroll: Scroller = new Scroller()

  build() {
    Column({ space: 10 }) {
      Blank().height(30)

      Text('Hello ' + deviceInfo.osFullName + ' !')
        .fontSize('20fp')
        .fontWeight(400)
        .align(Alignment.Center)

      Scroll(this.scrollerForScroll) {
        Text(' deviceType: ' + deviceInfo.deviceType +
          '\n manufacture: ' + deviceInfo.manufacture +
          '\n brand: ' + deviceInfo.brand +
          '\n marketName: ' + deviceInfo.marketName +
          '\n productSeries: ' + deviceInfo.productSeries +
          '\n productModel: ' + deviceInfo.productModel +
          '\n softwareModel: ' + deviceInfo.softwareModel +
          '\n hardwareModel: ' + deviceInfo.hardwareModel +
          //'\n hardwareProfile: '+ deviceInfo.hardwareProfile +
          //  '\n serial: '+ deviceInfo.serial +
          '\n bootloaderVersion: ' + deviceInfo.bootloaderVersion +
          '\n abiList: ' + deviceInfo.abiList +
          '\n securityPatchTag: ' + deviceInfo.securityPatchTag +
          '\n displayVersion: ' + deviceInfo.displayVersion +
          '\n incrementalVersion: ' + deviceInfo.incrementalVersion +
          '\n osReleaseType: ' + deviceInfo.osReleaseType +
          '\n osFullName: ' + deviceInfo.osFullName +
          '\n majorVersion: ' + deviceInfo.majorVersion +
          ' seniorVersion: ' + deviceInfo.seniorVersion +
          '\n featureVersion: ' + deviceInfo.featureVersion +
          ' buildVersion: ' + deviceInfo.buildVersion +
          '\n sdkApiVersion: ' + deviceInfo.sdkApiVersion +
          ' firstApiVersion: ' + deviceInfo.firstApiVersion +
          '\n versionId: ' + deviceInfo.versionId +
          '\n buildRootHash: ' + deviceInfo.buildRootHash +
          //    '\n udid: '+ deviceInfo.udid +
          '\n distributionOSName: ' + deviceInfo.distributionOSName +
          '\n distributionOSVersion: ' + deviceInfo.distributionOSVersion +
          '\n distributionOSApiVersion: ' + deviceInfo.distributionOSApiVersion +
          '\n distributionOSReleaseType: ' + deviceInfo.distributionOSReleaseType +
          '\n buildType: ' + deviceInfo.buildType +
          '\n buildUser: ' + deviceInfo.buildUser +
          '\n buildHost: ' + deviceInfo.buildHost +
          '\n buildTime: ' + deviceInfo.buildTime)
          .width('80%')
          .align(Alignment.Center)
        //.height(520)
      }
      .scrollable(ScrollDirection.Vertical)
      .height(450)

      Column({ space: 10 }) {
        Button('back')
          .fontSize('16fp')
          .fontWeight(500)
          .onClick(() => {
            router.back()
          })
          .width('53.6%')
          .height(40)
          .backgroundColor(Color.Green)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
  }
}