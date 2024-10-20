import { Header } from '../component/Header'

@Observed
class Task {
  static id: number = 1
  // 任务名称
  name: string = `任务${Task.id++}`
  // 任务是否完成的状态
  finished: boolean = false
}

/**
 * 任务统计信息
 */
class StatInfo {
  totalTask: number = 0
  finishTask: number = 0
}

/**
 * 卡片样式封装
 */
@Styles function card() {
  .width('95%')
  .padding(24)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

/**
 * 任务完成样式封装
 */
@Extend(Text) function finishedTask() {
  .decoration({ type: TextDecorationType.LineThrough })
  .fontColor('#B1B1B1')
}

@Entry
@Component
struct TaskManager {
  @Provide stat: StatInfo = new StatInfo()

  build() {
    Column({ space: 10 }) {
      // 标题
      Header({ title: 'Provide' })

      // 任务进度卡片
      TaskInfo()

      // 2. 任务列表
      TaskList()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F2')
  }
}

@Component
struct TaskInfo {
  @Consume stat: StatInfo

  build() {
    Row() {
      Text('任务进度：')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)

      Stack() {
        Progress({ value: this.stat.finishTask, total: this.stat.totalTask, type: ProgressType.Ring })
          .width(100)
        Text(`${this.stat.finishTask} / ${this.stat.totalTask}`).fontSize(24).fontColor('#36D')
      }
    }
    .card().margin({ top: 20, bottom: 10 })
    .justifyContent(FlexAlign.SpaceEvenly) // ???
  }
}

@Component
struct TaskList {
  @Consume stat: StatInfo
  // 任务数组
  @State task: Task[] = []

  handleTaskChanged(): void {
    // 总任务数
    this.stat.totalTask = this.task.length;
    // 已完成任务数
    this.stat.finishTask = this.task.filter(item => item.finished).length
    console.log('add onClick totalTask:' + this.stat.totalTask + ', finished:' + this.stat.finishTask)
  }

  build() {
    Column() {

      // 新增任务按钮
      Button('新增任务').width(200).onClick(() => {
        // 1. 新增任务数据
        this.task.push(new Task())
        this.handleTaskChanged()
      })

      // 任务列表
      List({ space: 10 }) {
        ForEach(this.task, (item: Task, index) => {
          ListItem() {
            TaskItem({ item: item, onTaskChange: this.handleTaskChanged.bind(this) })
          }
          .swipeAction({ end: this.DeleteButton(index) })
        })
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }
  }

  @Builder
  DeleteButton(index: number) {
    Button() {
      Image($r('app.media.ic_public_delete_filled'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      this.task.splice(index, 1)
      this.handleTaskChanged()
    })
  }
}

@Component
struct TaskItem {
  @ObjectLink item: Task
  onTaskChange?: () => void

  build() {
    Row() {
      if (this.item.finished) {
        Text(this.item.name)
          .finishedTask()
      } else {
        Text(this.item.name)
          .fontSize(20)
      }
      Checkbox().select(this.item.finished).onChange((select) => {
        this.item.finished = select
        this.onTaskChange!()
      })
    }.card()
    .justifyContent(FlexAlign.SpaceBetween) // 对齐方式
  }
}