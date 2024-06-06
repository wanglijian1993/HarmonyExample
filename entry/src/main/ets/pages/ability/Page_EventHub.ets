import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Page_EventHub {

  private context = getContext(this) as common.UIAbilityContext;

  eventHubFunc() : void {
    // 不带参数触发自定义“event1”事件
    this.context.eventHub.emit('event1');
    // 带1个参数触发自定义“event1”事件
    this.context.eventHub.emit('event1', 1);
    // 带2个参数触发自定义“event1”事件
    this.context.eventHub.emit('event1', 2, 'test');
    // 开发者可以根据实际的业务场景设计事件传递的参数
  }

  build() {
    Column() {
      Text('app.string.EventHubFuncA')
        .onClick(() => {
          this.eventHubFunc();
        })
    }
  }
}