import relationalStore from '@ohos.data.relationalStore';
import TaskInfo from '../viewmodel/TaskInfo';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { call } from '@kit.TelephonyKit';
import { Logger } from '../common/util/Logger';

class TaskModel {
  private rdbStore!: relationalStore.RdbStore
  private tableName: string = 'TASK'
  static TAG: string = 'TaskModel'

  /**
   * 初始化数据表
   */
  initTaskDb(context: Context) {
    // 1. 配置数据库
    const config: relationalStore.StoreConfig = {
      name: 'myApp.db', // 数据库名称
      securityLevel: relationalStore.SecurityLevel.S1 // 安全级别，取值[S1，S4]
    }

    // 2. 初始化SQL语句
    const sql = `CREATE TABLE IF NOT EXISTS TASK{
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NAME TEXT NOT NULL,
    FINISHED bit
    )`

    // 3. 获取rdb
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        Logger.w(TaskModel.TAG, '获取rdbStore失败');
        return
      }
      // 执行SQL
      rdbStore.executeSql(sql)
      Logger.i(TaskModel.TAG, '创建task表成功')
      // 保存rdbStore
      this.rdbStore = rdbStore
    })
    // 保存rdbStore
  }

  /**
   * 查询任务表
   */
  async getTaskList() {
    // 1. 构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    // 2. 查询
    let result = await this.rdbStore.querySync(predicates, ['ID', 'NAME', 'FINISHED'])
    // 3. 解析查询结果
    // 3.1. 定义一个数组， 组装最终的查询结果
    let tasks: TaskInfo[] = []
    // 3.2 便利封装
    while (!result.isAtLastRow) {
      // 3.3 指针移动下一行
      result.goToNextRow()
      // 3.4 获取数据
      let id = result.getLong(result.getColumnIndex('ID'))
      let name = result.getString(result.getColumnIndex('NAME'))
      let finished = result.getLong(result.getColumnIndex('FINISHED'))
      // 3.5 封装到数组
      tasks.push(new TaskInfo(id, name, !!finished))
    }
    console.log(TaskModel.TAG, '查询到数据：', JSON.stringify(tasks))
    return tasks
  }

  /**
   * 添加一个新的任务
   */
  addTaskCallback(name: string, callback: AsyncCallback<number>) {
    this.rdbStore.insert(this.tableName, { name, finished: false }, (number) => {
      Logger.i(TaskModel.TAG, `addTask ${this.tableName}: ${name}`)
      if (number) {

      }
      // callback?.apply(this, number)
    })
  }

  addTask(name: string) {
    return this.rdbStore.insert(this.tableName, { name, finished: false })
  }

  /**
   * 根据ID更新任务状态
   * @param id
   * @param finished
   */
  updateTaskStatusCallback(id: number, finished: boolean) {
    // 1. 要更新的数据
    let data: relationalStore.ValuesBucket = { finished }
    // 2. 更新的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 3. 更新操作
    this.rdbStore.update(data, predicates, (number) => {
      Logger.i(TaskModel.TAG, `update ${id} to ${finished} number:${number}}`)
    })
    // return this.rdbStore.update(data,predicates)
  }

  updateTaskStatus(id: number, finished: boolean) {
    let data: relationalStore.ValuesBucket = { finished }
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    return this.rdbStore.update(data, predicates)
  }

  /**
   * 根据id删除任务
   * @param id
   * @returns
   */
  deleteTaskById(id: number, callback: AsyncCallback<number>) {
    // 1. 删除的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 2. 删除操作
    return this.rdbStore.delete(predicates, (result) => {
      console.log(TaskModel.TAG, `delete ${id} number:${result}}`)
    })
  }

  deleteTask(id: number) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    return this.rdbStore.delete(predicates)
  }
}

let taskModel = new TaskModel()

export default taskModel as TaskModel