class Task {
  static id: number = 1
  name: string = `任务${Task.id++}`
  finished: boolean = false
}

@Styles function card() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

@Extend(Text) function finishedTask() {
  .decoration({ type: TextDecorationType.LineThrough })
  .fontColor('#B1B1B1')
}

@Entry
@Component
struct TaskManager {
  @State message: string = 'Hello World'
  @State totalTask: number = 0
  @State finishedTask: number = 0
  @State task: Task[] = []

  handleTaskChanged(): void {
    this.totalTask = this.task.length;
    this.finishedTask = this.task.filter(item => item.finished).length
    console.log('add onClick totalTask:' + this.totalTask + ', finished:' + this.finishedTask)
  }

  build() {
    Column({ space: 10 }) {
      // 任务进度卡片
      Row() {
        Text('任务进度：')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Stack() {
          Progress({ value: this.finishedTask, total: this.totalTask, type: ProgressType.Ring }).width(100)
          Row() {
            Text(this.finishedTask + ' / ').fontSize(24).fontColor('#36D')
            Text(this.totalTask.toString()).fontSize(24).fontColor('#36D')
          }
        }
      }
      .card().margin({ top: 20, bottom: 10 }).justifyContent(FlexAlign.SpaceEvenly)

      // 新增任务按钮
      Button('新增任务').width(200).onClick(() => {
        // 1. 新增任务数据
        this.task.push(new Task())
        // this.handleTaskChanged()
        this.totalTask = this.task.length;
        console.log('add onClick totalTask:' + this.totalTask + ', finished:' + this.finishedTask)
      })

      // 任务列表
      List() {
        ForEach(this.task, (item: Task, index) => {
          ListItem() {
            Row() {
              Text(item.name).fontSize(20)
              Checkbox().select(item.finished).onChange((select) => {
                item.finished = select
                // this.handleTaskChanged()

                this.totalTask = this.task.length;
                this.finishedTask = this.task.filter(item => item.finished).length
                console.log('select onChange totalTask:' + this.totalTask + ', finished:' + this.finishedTask)
              })
            }.card()
            .justifyContent(FlexAlign.SpaceBetween) // 对齐方式
          }
        }
        )
      }
      .width('100%')
      .layoutWeight(1)
      .height('100%')
      .backgroundColor('#F1F1F1')
    }
  }
}