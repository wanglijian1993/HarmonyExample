import AbilityStage from '@ohos.app.ability.AbilityStage';
import type Want from '@ohos.app.ability.Want';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { AbilityConstant } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class SpecifiedFirstAbility extends AbilityStage {
  onAcceptWant(want: Want): string {
    // 在被调用方的AbilityStage中，针对启动模式为specified的UIAbility返回一个UIAbility实例对应的一个Key值
    // 当前示例指的是module1 Module的SpecifiedAbility
    hilog.info(0x0000, 'testTag', '%{public}s', `onAcceptWant ${want.abilityName}---want.parameters:${want.parameters}`);

    if (want.abilityName === 'SpecifiedFirstAbility' || want.abilityName === 'SpecifiedSecondAbility') {
      // 返回的字符串Key标识为自定义拼接的字符串内容
      if (want.parameters) {
        return `SpecifiedAbilityInstance_${want.parameters.instanceKey}`;
      }
    }

    return '';
  }

  onCreate(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.on('windowStageEvent',(data)=>{

      let stageEventType: window.WindowStageEventType = data;
      switch (stageEventType){
        case window.WindowStageEventType.SHOWN: // 切到前台
          hilog.info(0x0000,'testTag','windowStage foreground.');
          break;
        case window.WindowStageEventType.ACTIVE: // 获焦状态
          hilog.info(0x0000,'testTag','windowStage active.');
          break;
        case window.WindowStageEventType.INACTIVE: // 失焦状态
          hilog.info(0x0000,'testTag','windowStage inactive.');
          break;
        case window.WindowStageEventType.HIDDEN: // 切到后台
          hilog.info(0x0000,'testTag','windowStage background.');
          break;
        default:
          break;
      }

    })
    windowStage.loadContent('pages/ability/Page_StartModel', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.error(0x0000, 'testTag', 'On new wang');

  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}