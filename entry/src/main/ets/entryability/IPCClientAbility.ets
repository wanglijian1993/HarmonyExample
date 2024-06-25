import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import window from '@ohos.window';
import { rpc } from '@kit.IPCKit';
import { hilog } from '@kit.PerformanceAnalysisKit';


export default class IPCClientAbility extends UIAbility{

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {

  }
  onWindowStageCreate(windowStage: window.WindowStage): void {

  }

  onForeground(): void {

  }
  onBackground(): void {

  }


  onDestroy(): void | Promise<void> {

  }


}

// 使用期约
let option = new rpc.MessageOption();
let data = rpc.MessageSequence.create();
let reply = rpc.MessageSequence.create();
// 往data里写入参数
let proxy: rpc.IRemoteObject | undefined;
if (proxy != undefined) {
  proxy.sendMessageRequest(1, data, reply, option)
    .then((result: rpc.RequestResult) => {
      if (result.errCode != 0) {
        hilog.error(0x0000, 'testTag', 'sendMessageRequest failed, errCode: ' + result.errCode);
        return;
      }
      // 从result.reply里读取结果
    })
    .catch((e: Error) => {
      hilog.error(0x0000, 'testTag', 'sendMessageRequest got exception: ' + e);
    })
    .finally(() => {
      data.reclaim();
      reply.reclaim();
    })
}

// 使用回调函数
function sendRequestCallback(err: Error, result: rpc.RequestResult) {
  try {
    if (result.errCode != 0) {
      hilog.error(0x0000, 'testTag', 'sendMessageRequest failed, errCode: ' + result.errCode);
      return;
    }
    // 从result.reply里读取结果
  } finally {
    result.data.reclaim();
    result.reply.reclaim();
  }
}
let options = new rpc.MessageOption();
let datas = rpc.MessageSequence.create();
let replys = rpc.MessageSequence.create();
// 往data里写入参数
if (proxy != undefined) {
  proxy.sendMessageRequest(1, datas, replys, options, sendRequestCallback);
}