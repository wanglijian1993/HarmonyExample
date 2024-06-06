// 在启动指定实例模式的UIAbility时，给每一个UIAbility实例配置一个独立的Key标识
// 例如在文档使用场景中，可以用文档路径作为Key标识
import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import Want from '@ohos.app.ability.Want';
import { BusinessError } from '@ohos.base';

const TAG: string = '[Page_StartModel]';
const DOMAIN_NUMBER: number = 0xFF00;

function getInstance() : string {
  return 'KEY';
}

@Entry
@Component
struct Page_StartModel {
  private KEY_NEW = 'KEY';
  build() {
    Row() {
      Column() {
        Button('SpecifiedButton01')
        .onClick(() => {
          let context:common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
          // context为调用方UIAbility的UIAbilityContext;
          let want: Want = {
            deviceId: '', // deviceId为空表示本设备
            bundleName: 'com.harmony.myapplication',
            abilityName: 'SpecifiedSecondAbility',
            moduleName: 'entry', // moduleName非必选
            parameters: { // 自定义信息
              instanceKey: this.KEY_NEW
            }
          };
          context.startAbility(want).then(() => {
            hilog.info(DOMAIN_NUMBER, TAG, 'Succeeded in starting SpecifiedAbility.');
          }).catch((err: BusinessError) => {
            hilog.error(DOMAIN_NUMBER, TAG, `Failed to start SpecifiedAbility. Code is ${err.code}, message is ${err.message}`);
          })
          this.KEY_NEW = this.KEY_NEW + 'a';
        })


        Button('SpecifiedButton02')
          .onClick(() => {
          let context:common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
          // context为调用方UIAbility的UIAbilityContext;
          let want: Want = {
            deviceId: '', // deviceId为空表示本设备
            bundleName: 'com.harmony.myapplication',
            abilityName: 'SpecifiedSecondAbility',
            moduleName: 'entry', // moduleName非必选
            parameters: { // 自定义信息
              instanceKey: getInstance()
            }
          };
          context.startAbility(want).then(() => {
            hilog.info(DOMAIN_NUMBER, TAG, 'Succeeded in starting SpecifiedAbility.');
          }).catch((err: BusinessError) => {
            hilog.error(DOMAIN_NUMBER, TAG, `Failed to start SpecifiedAbility. Code is ${err.code}, message is ${err.message}`);
          })
          this.KEY_NEW = this.KEY_NEW + 'a';
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}