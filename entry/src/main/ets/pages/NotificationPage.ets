import { image } from '@kit.ImageKit';
import { Header } from '../component/Header';
import { notificationManager } from '@kit.NotificationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import DownloadCard from '../view/notification/DownloadCard';

@Entry
@Component
struct NotificationPage {
  idx: number = 100
  pixcel!: PixelMap

  async aboutToAppear() {
    let rm = getContext(this).resourceManager
    let file = await rm.getMediaContent($r('app.media.watchGT4'))
    image.createImageSource(file.buffer).createPixelMap()
      .then(value => this.pixcel = value)
      .catch((reason: string) => console.log('testTag', '加载图片异常', JSON.stringify(reason)))
  }

  build() {
    Column({ space: 20 }) {
      Header({ title: '通知功能' })

      Button('normalText')
        .onClick(() => this.publishNormalTextNotification())
      Button(`发送longText通知`)
        .onClick(() => this.publishLongTextNotification())
      Button(`发送multiLine通知`)
        .onClick(() => this.publishMultiLineNotification())
      Button(`发送Picture通知`)
        .onClick(() => this.publishPictureNotification())

      // 下载功能卡片
      DownloadCard()

    }
    .width('100%')
    .height('100%')
    .padding(5)
    .backgroundColor('#f1f2f3')
  }

  /**
   * 普通文本类型通知由标题、文本内容和附加信息三个字段组成，其中标题和文本内容是必填字段
   */
  publishNormalTextNotification() {
    let request: notificationManager.NotificationRequest = {
      id: this.idx++,
      content: {
        // contentType: notify.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: 'test_title ' + this.idx,
          text: 'test_text',
          additionalText: 'test_additionalText',
        }
      },
      showDeliveryTime: true,
      deliveryTime: new Date().getTime(),
      groupName: 'wechat',
      notificationSlotType: notificationManager.SlotType.SOCIAL_COMMUNICATION
    }
    this.publish(request)
  }

  publishLongTextNotification() {
    let request: notificationManager.NotificationRequest = {
      id: this.idx++,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
        longText: {
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          longText: '通知中的长文本，我很长，我很长，我很长，我很长，我很长，我很长，我很长',
          briefText: '通知概要和总结',
          expandedTitle: '通知展开时的标题' + this.idx
        }
      }
    }
    this.publish(request)
  }

  publishMultiLineNotification() {
    let request: notificationManager.NotificationRequest = {
      id: this.idx++,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
        multiLine: {
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          briefText: '通知概要和总结',
          longTitle: '展开时的标题，我很宽，我很宽，我很宽',
          lines: [
            '第一行',
            '第二行',
            '第三行',
            '第四行',
          ]
        }
      }
    }
    this.publish(request)
  }

  publishPictureNotification() {
    let request: notificationManager.NotificationRequest = {
      id: this.idx++,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: {
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          briefText: '通知概要和总结',
          expandedTitle: '展开后标题' + this.idx,
          picture: this.pixcel
        }
      }
    }
    this.publish(request)
  }

  /**
   * 发布通知。使用callback异步回调
   * @param request
   */
  private publish(request: notificationManager.NotificationRequest) {
    // notify.publish(request)
    //   .then(() => console.log('notify test', '发送通知成功'))
    //   .then(reason => console.log('notify test', '发送通知失败', JSON.stringify(reason)))

    //publish回调
    let publishCallback = (err: BusinessError): void => {
      if (err) {
        console.error(`publish failed, code is ${err.code}, message is ${err.message}`);
      } else {
        console.info("publish success");
      }
    }
    notificationManager.publish(request, publishCallback);
  }
}