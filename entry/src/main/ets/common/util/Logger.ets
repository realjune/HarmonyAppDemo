/**
 * 日志工具类，请严格按照日志level输出日志
 */
export class Logger {
  static VERBOSE_LEVEL: number = 2
  static DEBUG_LEVEL: number = 3
  static INFO_LEVEL: number = 4
  static WARN_LEVEL: number = 5
  static ERROR_LEVEL: number = 6
  static ASSERT_LEVEL: number = 7
  static RELEASE = false
  static LEVEL: number = Logger.RELEASE ? Logger.INFO_LEVEL : Logger.ASSERT_LEVEL
  static VERBOSE = Logger.LEVEL >= Logger.VERBOSE_LEVEL
  static DEBUG = Logger.LEVEL >= Logger.DEBUG_LEVEL
  static INFO = Logger.LEVEL >= Logger.INFO_LEVEL
  static WARN = Logger.LEVEL >= Logger.WARN_LEVEL
  static ERROR = Logger.LEVEL >= Logger.ERROR_LEVEL
  static ASSERT = Logger.LEVEL >= Logger.ASSERT_LEVEL

  static v(tag: string, message: string, ...args: (number | string | boolean)[]) {
    if (!Logger.VERBOSE) {
      return
    }
    console.log(tag + message, args)
  }

  static d(tag: string, message: string, ...args: (number | string | boolean)[]) {
    if (!Logger.DEBUG) {
      return
    }
    console.debug(tag + message, args)

  }

  static i(tag: string, message: string, ...args: (number | string | boolean)[]) {
    if (!Logger.INFO) {
      return
    }
    console.info(tag + message, args)
  }

  static w(tag: string, message: string, ...args: (number | string | boolean)[]) {
    if (!Logger.WARN) {
      return
    }
    console.warn(tag + message, args)
  }

  static e(tag: string, message: string, ...args: (number | string | boolean)[]) {
    if (!Logger.ERROR) {
      return
    }
    console.error(tag + message, args)
  }
}