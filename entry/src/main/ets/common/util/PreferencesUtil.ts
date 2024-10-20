// 导入首选项模块
import preferences from '@ohos.data.preferences';
import { AsyncCallback, BusinessError } from '@kit.BasicServicesKit';
import { ValueType } from '@kit.ArkData';

class PreferencesUtil {
  prefMap: Map<string, preferences.Preferences> = new Map()

  /**
   * 加载Preference文件
   * @param context
   * @param name 文件名称
   */
  loadPreferenceAsync(context, name: string) {
    preferences.getPreferences(context, name)
      .then(pref => {
        this.prefMap.set(name, pref)
        console.log('testTag', `加载Preference[${name}]成功`)
      })
      .catch(reason => {
        console.log('testTag', `加载Preference[${name}失败`, JSON.stringify(reason))
      })
  }

  loadPreferenceCallback(context, name: string) {
    preferences.getPreferences(context, name, (err: BusinessError, pref: preferences.Preferences) => {
      if (err) {
        console.error("Failed to getToSync preferences. code =" + err.code + ", message =" + err.message);
        return;
      }
      this.prefMap.set(name, pref)
      console.info("Succeeded in getting preferences.");
    })
  }

  /**
   * 异步存储Preference
   * @param context  用于获取Preference
   * @param name Preference的文件名称
   * @param key 存储数据的key名
   * @param value 存储数据的value值
   */
  putPreferencePromise(context, name: string, key: string, value: string) {
    preferences.getPreferences(context, name)
      .then(pref => {
        this.prefMap.set(name, pref)
        console.log('testTag', `加载Preference[${name}]成功`)
        pref.putSync(key, value)
        pref.put(key, value, () => {
        })
        pref.flush(() => {

        })
        this.putPromise(pref, key, value);
      })
      .catch(reason => {
        console.log('testTag', `加载Preference[${name}失败`, JSON.stringify(reason))
      })
  }

  private putPromise(pref: preferences.Preferences, key: string, value: string) {
    pref.put(key, value).then(() => {
      console.log('testTag', `保存Preference[${key}=${value}]成功`)
    }).catch(reason => {
      console.log('testTag', `保存Preference[${key}=${value}]失败`, JSON.stringify(reason));
    });
  }

  private putCallback(pref: preferences.Preferences, key: string, value: string, callback: AsyncCallback<void>) {
    pref.put(key, value, (err: BusinessError) => {
      if (err) {
        console.error("Failed to putToSync value of 'startup'. code =" + err.code + ", message =" + err.message);
        callback?.apply(this, err)
      } else {
        console.info("Succeeded in putting value of 'startup'.");
        callback?.apply(this, null)
      }
    })
  }

  private getCallback(pref: preferences.Preferences, key: string, defaultValue: ValueType,
    callback: AsyncCallback<ValueType>) {
    pref.get(key, defaultValue, (err: BusinessError, val: preferences.ValueType) => {
      if (err) {
        console.error("Failed to getToSync value of 'startup'. code =" + err.code + ", message =" + err.message);
        callback?.apply(this, err)
      } else {
        console.info("Succeeded in getting value of 'startup'. val： " + val);
        callback?.apply(this, val)
      }
    })
  }

  put(name: string, key: string, value: ValueType) {
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preference[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      pref?.putSync(key, value)
      console.log('testTag', `存入Preference[${name}.${key}=${value}]成功`)
    } catch (e) {
      console.log('testTag', `存入Preference[${name}.${key}=${value}]失败`, JSON.stringify(e))
    }
  }

  get(name: string, key: string, defValue: ValueType) {
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preference[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      let value = pref?.get(key, defValue)
      console.log('testTag', `读取Preference[${name}.${key}=${value}]成功`)
      return value
    } catch (e) {
      console.log('testTag', `读取Preference[${name}.${key}=${defValue}]失败`, JSON.stringify(e))
    }
  }

  /**
   * 转同步方式加载Pereference文件
   * @param context
   * @param name 文件名称
   */
  async loadPreference(context, name: string) {
    try {
      let pref = await preferences.getPreferences(context, name)
      this.prefMap.set(name, pref)
      console.log('testTag', `加载Preference[${name}]成功`)
    } catch (e) {
      console.log('testTag', `加载Preference[${name}失败`, JSON.stringify(e))
    }
  }

  /**
   * 异步转同步-存储k-v
   * @param name 文件名
   * @param key key值
   * @param value value值
   */
  async putToSync(name: string, key: string, value: preferences.ValueType) {
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preference[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      await pref.put(key, value)
      await pref.flush()
      console.log('testTag', `保存Preference[${name}.${key}=${value}]成功`)
    } catch (e) {
      console.log('testTag', `保存Preference[${name}.${key}=${value}]失败`, JSON.stringify(e))
    }
  }

  /**
   *异步转同步读取k-v
   * @param name
   * @param key
   * @param defValue
   * @returns
   */
  async getToSync(name: string, key: string, defValue: preferences.ValueType) {
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preference[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      let value = await pref.get(key, defValue)
      console.log('testTag', `读取Preference[${name}.${key}=${value}]成功`)
      return value
    } catch (e) {
      console.log('testTag', `读取Preference[${name}.${key}=${defValue}]失败`, JSON.stringify(e))
    }
  }

  async deleteToSync(name: string, key: string) {
    try {
      let pref = this.prefMap.get(name)
      if (pref) {
        let value = await pref.delete(key)
        console.log('testTag', `删除Preference[${name}.${key}=${value}]成功`)
      } else {
        console.log('testTag', `Preference[${name}]尚未初始化！`)
      }
    } catch (e) {
      console.log('testTag', `删除Preference[${name}.${key}]失败`, JSON.stringify(e))
    }
  }

  delete(name: string, key: string) {
    try {
      let pref = this.prefMap.get(name)
      pref?.deleteSync('startup');
      if (pref) {
        console.log('testTag', `删除Preference[${name}.${key}]成功`)
      } else {
        console.log('testTag', `Preference[${name}]尚未初始化！`)
      }
    } catch (e) {
      console.log('testTag', `删除Preference[${name}.${key}]失败`, JSON.stringify(e))
    }
  }
}

const preferencesUtil = new PreferencesUtil()

export default preferencesUtil as PreferencesUtil