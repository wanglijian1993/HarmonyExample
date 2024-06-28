import { curves } from '@kit.ArkUI';


@AnimatableExtend(Text)
function animableFontSize(size:number){
  .fontSize(size)
}



@Entry
@Component
struct AnimatablePropertyExample  {
@State fontSize:number=20
  @State isPresent: boolean = true;
  // 出现时会是所有转场效果的出现效果叠加，消失时会是所有消失转场效果的叠加
  // 用于说明各个effect跟随的动画参数
  private effect: object =
    TransitionEffect.OPACITY // 创建了透明度转场效果，这里没有调用animation接口，会跟随animateTo的动画参数
      // 通过combine方法，添加缩放转场效果，并指定了springMotion(0.6, 1.2)曲线
      .combine(TransitionEffect.scale({ x: 0, y: 0 }).animation({ curve: curves.springMotion(0.6, 1.2) }))
        // 添加旋转转场效果，这里的动画参数会跟随上面的TransitionEffect，也就是springMotion(0.6, 1.2)
      .combine(TransitionEffect.rotate({ angle: 90 }))
        // 添加平移转场效果，动画参数会跟随其之上带animation的TransitionEffect，也就是springMotion(0.6, 1.2)
      .combine(TransitionEffect.translate({ x: 150, y: 150 })
        // 添加move转场效果，并指定了springMotion曲线
        .combine(TransitionEffect.move(TransitionEdge.END)).animation({curve: curves.springMotion()}))
        // 添加非对称的转场效果，由于这里没有设置animation，会跟随上面的TransitionEffect的animation效果，也就是springMotion
      .combine(TransitionEffect.asymmetric(TransitionEffect.scale({ x: 0, y: 0 }), TransitionEffect.rotate({ angle: 90 })));
  build() {

    Column(){

      Text("Animatable")
        .animableFontSize(this.fontSize)
        .animation({duration:1000,curve:'ease'})
        .width(300)
        .height(140)
        .textAlign(TextAlign.Center)
        .onClick(()=>{
          this.fontSize = this.fontSize == 20 ? 30 : 20;
        })

      Text('test')
        .transition(this.effect)
        .onClick(()=>{
          // 方式一：将控制变量放到animateTo闭包内，未通过animation接口定义动画参数的TransitionEffect将跟随animateTo的动画参数
          animateTo({ curve: curves.springMotion() }, () => {
            this.isPresent = false;
          })
        })

      if (this.isPresent) {
        Text('test')
          .transition(this.effect)
      }
    }
    .width('100%')
    .height('100%')

  }



}