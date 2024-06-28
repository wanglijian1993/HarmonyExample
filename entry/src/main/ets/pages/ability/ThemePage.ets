import { Theme, ThemeControl } from '@ohos.arkui.theme'
import { gAppTheme } from '../../theme/AppColors';

//在页面build前执行ThemeControl
// ThemeControl.setDefaultTheme(gAppTheme)

@Entry
@Component
struct DisplayPage {
  @State menuItemColor: ResourceColor = $r('sys.color.background_primary')
  // onWillApplyTheme(theme: Theme) {
  //   // this.mTheme=theme
  // }

  build() {
    Column() {
      List({ space: 10 }) {
        ListItem() {
          Column({ space: '5vp' }) {
            Text('Color mode')
              .margin({ top: '5vp', left: '14fp' })
              .width('100%')
            Row() {
              Column() {
                Text('Light')
                  .fontSize('16fp')
                  .textAlign(TextAlign.Start)
                  .alignSelf(ItemAlign.Center)
                Radio({ group: 'light or dark', value: 'light' })
                  .checked(true)
              }
              .width('50%')

              Column() {
                Text('Dark')
                  .fontSize('16fp')
                  .textAlign(TextAlign.Start)
                  .alignSelf(ItemAlign.Center)
                Radio({ group: 'light or dark', value: 'dark' })
              }
              .width('50%')
            }
          }
          .width('100%')
          .height('90vp')
          .borderRadius('10vp')
          .backgroundColor(this.menuItemColor)
        }

        ListItem() {
          Column() {
            Text('Brightness')
              .width('100%')
              .margin({ top: '5vp', left: '14fp' })
            Slider({ value: 40, max: 100 })
          }
          .width('100%')
          .height('70vp')
          .borderRadius('10vp')
          .backgroundColor(this.menuItemColor)
        }

        ListItem() {
          Column() {
            Row() {
              Column({ space: '5vp' }) {
                Text('Touch sensitivity')
                  .fontSize('16fp')
                  .textAlign(TextAlign.Start)
                  .width('100%')
                Text('Increase the touch sensitivity of your screen' +
                  ' for use with screen protectors')
                  .fontSize('12fp')
                  .fontColor(Color.Blue)
                  .textAlign(TextAlign.Start)
                  .width('100%')
              }
              .alignSelf(ItemAlign.Center)
              .margin({ left: '14fp' })
              .width('75%')

              Toggle({ type: ToggleType.Switch, isOn: true })
                .margin({ right: '14fp' })
                .alignSelf(ItemAlign.Center)
                .width('25%')
            }
            .width('100%')
            .height('80vp')
          }
          .width('100%')
          .borderRadius('10vp')
          .backgroundColor(this.menuItemColor)
        }
      }

      Button("主题")
        .onClick(() => {
          // this.menuItemColor = $r("app.color.theme_color")
          ThemeControl.setDefaultTheme(gAppTheme)
        })

    }
    .padding('10vp')
    .backgroundColor('#dcdcdc')
    .width('100%')
    .height('100%')
  }

}