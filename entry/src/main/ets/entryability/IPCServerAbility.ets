import { AbilityConstant, common, UIAbility, Want } from '@kit.AbilityKit'
import window from '@ohos.window'
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { rpc } from '@kit.IPCKit';


export default class IPCAbility extends UIAbility{


  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.connectRPC()

  }


  onWindowStageCreate(windowStage: window.WindowStage): void {


     windowStage.loadContent('',(err) =>{

     })


  }

  onForeground(): void {

  }
  onBackground(): void {

  }

  onDestroy(): void | Promise<void> {

  }
  connectRPC(){
    let proxy: rpc.IRemoteObject | undefined;
    let connect: common.ConnectOptions = {
      onConnect: (elementName, remoteProxy) => {
        hilog.info(0x0000, 'testTag', 'RpcClient: js onConnect called.');
        proxy = remoteProxy;
      },
      onDisconnect: (elementName) => {
        hilog.info(0x0000, 'testTag', 'RpcClient: onDisconnect');
      },
      onFailed: () => {
        hilog.info(0x0000, 'testTag', 'RpcClient: onFailed');
      }
    };
    let want: Want = {
      bundleName: "com.ohos.server",
      abilityName: "com.ohos.server.EntryAbility",
    };
    // 建立连接后返回的Id需要保存下来，在解绑服务时需要作为参数传入
    let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext; // UIAbilityContext
    // 建立连接后返回的Id需要保存下来，在解绑服务时需要作为参数传入
    let connectionId = context.connectServiceExtensionAbility(want, connect);
  }

}


class Stub extends rpc.RemoteObject {
  constructor(descriptor: string) {
    super(descriptor);
  }
  onRemoteMessageRequest(code: number, data: rpc.MessageSequence, reply: rpc.MessageSequence, option: rpc.MessageOption): boolean | Promise<boolean> {
    // 根据code处理客户端的请求
    return true;
  }

  onConnect(want: Want) {
    const robj: rpc.RemoteObject = new Stub("rpcTestAbility");
    return robj;
  }
}
