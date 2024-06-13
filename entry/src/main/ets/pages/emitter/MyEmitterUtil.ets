import Emitter from '@ohos.events.emitter';

/**
 * `MyEmitterUtil` 是一个针对 HarmonyOS 的事件驱动编程封装类，主要用于组件间的通信和数据传递。
 *
 * 使用要求：
 *   - API 版本：api 11

 * 示例用法：
 * 1. 父组件绑定、解绑、向子组件发送事件：
 *    ```typescript
 *    aboutToAppear() {
 *      this.myEmitterUtil.onFather((eventData: EmitterData) => {
 *        console.info('父组件监听结果: ', JSON.stringify(eventData));
 *        // 判断事件类型并执行相应操作...
 *      });
 *    }
 *
 *    aboutToDisappear() {
 *      this.myEmitterUtil.offFather();
 *    }
 *
 *    // 向子组件发送事件
 *    this.myEmitterUtil.emitChild(MyEmitterUtil.UPDATE_DETAIL, "携带的测试数据");
 *    ```
 *
 * 2. 子组件绑定、解绑、向父组件发送事件：
 *    ```typescript
 *    aboutToAppear() {
 *      this.myEmitterUtil.onChild((eventData: EmitterData) => {
 *        console.info('子组件监听结果: ', JSON.stringify(eventData));
 *        // 判断事件类型并执行相应操作...
 *      });
 *    }
 *
 *    aboutToDisappear() {
 *      this.myEmitterUtil.offChild();
 *    }
 *
 *    // 向父组件发送事件
 *    this.myEmitterUtil.emitFather(MyEmitterUtil.UPDATE_LIST, "测试");
 *    this.myEmitterUtil.emitFather(MyEmitterUtil.UPDATE_LIST_2, "测试2");
 *    ```
 *
 * 参考文档：
 *   - 请查阅 HarmonyOS 开发文档了解详细信息。
 */

export class MyEmitterUtil {
  private static EVENT_ID_COUNTER: number = 0; // 自动递增，生成唯一的事件ID

  private readonly eventIdFather: number;
  private readonly eventIdChild: number;

  constructor() {
    this.eventIdFather = MyEmitterUtil.EVENT_ID_COUNTER++;
    this.eventIdChild = MyEmitterUtil.EVENT_ID_COUNTER++;
    console.info(`事件ID（父组件）: ${this.eventIdFather}`);
    console.info(`事件ID（子组件）: ${this.eventIdChild}`);
  }

  // 定义业务状态标识常量
  static readonly UPDATE_LIST = "UPDATE_LIST";
  static readonly UPDATE_LIST_2 = "UPDATE_LIST_2";
  static readonly UPDATE_DETAIL = "UPDATE_DETAIL";
  /**
   * 在组件的`aboutToAppear`生命周期钩子中调用，监听父组件事件
   * @param callback 事件回调函数，接受一个`EmitterData`对象作为参数
   */
  onFather(callback: (eventData: EmitterData) => void) {
    Emitter.on({ eventId: this.eventIdFather }, (event) => {
      if (event.data) {
        callback(new EmitterData(event.data.flag, event.data.data));
      }
    });
  }

  /**
   * 在组件的`aboutToDisappear`生命周期钩子中调用，解除父组件事件监听
   */
  offFather() {
    Emitter.off(this.eventIdFather);
  }

  /**
   * 在组件的`aboutToAppear`生命周期钩子中调用，监听子组件事件
   * @param callback 事件回调函数，接受一个`EmitterData`对象作为参数
   */
  onChild(callback: (eventData: EmitterData) => void) {
    Emitter.on({ eventId: this.eventIdChild }, (event) => {
      if (event.data) {
        callback(new EmitterData(event.data.flag, event.data.data));
      }
    });
  }

  /**
   * 在组件的`aboutToDisappear`生命周期钩子中调用，解除子组件事件监听
   */
  offChild() {
    Emitter.off(this.eventIdChild);
  }

  /**
   * 向父组件发送事件
   * @param flag 事件类型标识
   * @param data 事件携带的数据
   */
  emitFather(flag: string, data: string) {
    Emitter.emit(
      { eventId: this.eventIdFather, priority: Emitter.EventPriority.IMMEDIATE },
      { data: { flag, data } }
    );
  }

  /**
   * 向子组件发送事件
   * @param flag 事件类型标识
   * @param data 事件携带的数据
   */
    emitChild(flag: string, data: string) {
    Emitter.emit(
      { eventId: this.eventIdChild, priority: Emitter.EventPriority.IMMEDIATE },
      { data: { flag, data } }
    );
  }
}

/**
 * 用于封装事件数据的类
 */
export class EmitterData {

  flag: string = "";
  data: string = "";

  constructor(flag: string, data: string) {
    this.flag = flag;
    this.data = data;
  }
}

