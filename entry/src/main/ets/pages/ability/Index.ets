import { common, Want } from '@kit.AbilityKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit';

const TAG: string = '[Page_StartModel]';
const DOMAIN_NUMBER: number = 0xFF00;
function getInstance() : string {
  return 'KEY';
}

@Entry
@Component
struct Index{
  private KEY_NEW = 'KEY';

  build() {

    Column(){
      Text('页面1')
      Button('跳转二级页面')
        .onClick(()=>{
          // 打开目标Ability
         let context:common.UIAbilityContext=getContext(this) as common.UIAbilityContext;
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

  }


}