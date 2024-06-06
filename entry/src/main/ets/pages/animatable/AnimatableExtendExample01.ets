

class Point{

  x:number
  y:number

  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }

  plus(rhs: Point): Point {
    return new Point(this.x + rhs.x, this.y + rhs.y)
  }
  subtract(rhs: Point): Point {
    return new Point(this.x - rhs.x, this.y - rhs.y)
  }
  multiply(scale: number): Point {
    return new Point(this.x * scale, this.y * scale)
  }
  equals(rhs: Point): boolean {
    return this.x === rhs.x && this.y === rhs.y
  }

}


class PointVector extends Array<Point> implements AnimatableArithmetic<PointVector>{

  constructor(value:Array<Point>) {
    super()
    value.forEach(p => this.push(p))
  }
  get(): Array<Object[]> {
    let result: Array<Object[]> = []
    this.forEach(p => result.push([p.x, p.y]))
    return result
  }

  plus(rhs: PointVector): PointVector {
    let result =new PointVector([])
    const len=Math.min(this.length,rhs.length)
    for(let i=0;i<len;i++){
      result.push((this as Array<Point>)[i].plus((rhs as Array<Point>)[i]))
    }
    return result
  }

  subtract(rhs: PointVector): PointVector {
    let result = new PointVector([])
    const len = Math.min(this.length, rhs.length)
    for (let i = 0; i < len; i++) {
      result.push((this as Array<Point>)[i].subtract((rhs as Array<Point>)[i]))
    }
    return result
  }
  multiply(scale: number): PointVector {
    let result = new PointVector([])
    for (let i = 0; i < this.length; i++) {
      result.push((this as Array<Point>)[i].multiply(scale))
    }
    return result
  }
  equals(rhs: PointVector): boolean {
    if (this.length != rhs.length) {
      return false
    }
    for (let i = 0; i < this.length; i++) {
      if (!(this as Array<Point>)[i].equals((rhs as Array<Point>)[i])) {
        return false
      }
    }
    return true
  }

}

@AnimatableExtend(Polyline) function animatablePoints(points:PointVector){
  .points(points.get())
}


@Entry
@Component
struct AnimatablePropertyExample {

  @State points: PointVector = new PointVector([
    new Point(50, Math.random() * 200),
    new Point(100, Math.random() * 200),
    new Point(150, Math.random() * 200),
    new Point(200, Math.random() * 200),
    new Point(250, Math.random() * 200),
  ])

  build() {
    Column(){
      Polyline()
        .animatablePoints(this.points)
        .animation({duration:1000,curve:"ease"})
        .size({height:220,width:300})
        .fill(Color.Green)
        .stroke(Color.Red)
        .backgroundColor(`#eeaacc`)

      Button("Play")
        .onClick(()=>{
          this.points=new PointVector([
            new Point(50, Math.random() * 200),
            new Point(100, Math.random() * 200),
            new Point(150, Math.random() * 200),
            new Point(200, Math.random() * 200),
            new Point(250, Math.random() * 200),
          ])
        })
    }
    .width("100%")
    .padding(10)

  }
}