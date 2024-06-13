import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction, window } from '@kit.ArkUI';
import { emitter } from '@kit.BasicServicesKit';

const DOMAIN_NUMBER: number = 0xFF00;
const TAG: string = '[EmiiterEntryAbility]';

export default class EmiiterEntryAbility extends UIAbility {



  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

  }

  eventFunc(argOne: Context, argTwo: Context): void {
    hilog.info(DOMAIN_NUMBER, TAG, '1. ' + `${argOne}, ${argTwo}`);
    return;
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

    windowStage.loadContent('pages/emitter/EmitterPage', (err) => {
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
