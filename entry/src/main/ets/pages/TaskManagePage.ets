import { Header } from '../component/Header';
import TaskStatistics from '../view/task/TaskStatistics';

@Entry
@Component
struct TaskManagePage {
  @State message: string = 'Hello World';
  @State totalTask: number = 0
  @State finishTask: number = 0

  build() {
    Column({ space: 10 }) {
      // 顶部导航
      Header()

      // 任务进度卡片
      TaskStatistics()

      // 任务列表

    }
    .width('100%')
  }
}