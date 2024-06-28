import { ListView, RefreshController, RefreshDataSource } from '@abner/refresh'


@Entry
@Component
struct RefreshPage{


  controller: RefreshController = new RefreshController() //刷新控制器，声明全局变量
  dataSource: RefreshDataSource = new RefreshDataSource()//数据懒加载操作对象，执行数据增删改查
  @State array:Array<string>=["1111","2222","33333","444444","55555","666666","7777777","888888","99999","12344556"]

  aboutToAppear(): void {
    this.dataSource.initData(this.array)
  }

  build() {
    Column() {
      ListView({
        lazyDataSource: this.dataSource,
        itemLayout: (item, index) => this.itemLayout(item, index), //条目布局
        controller: this.controller, //控制器，负责关闭下拉和上拉
        onRefresh: () => {
          this.dataSource.deleteAll()
          this.dataSource.pushDataArray(this.array)
          //下拉刷新
            this.controller.finishRefresh() //关闭下拉刷新，在数据请求回后进行关闭
        },
        onLoadMore: () => {
          this.dataSource.pushDataArray(this.array)

          //上拉加载
          //数据懒加载使用：1、数组数据添加，this.dataSource.pushDataArray()，2、单个数据添加，this.dataSource.pushData()
            this.controller.finishLoadMore() //关闭上拉加载,在数据请求回后进行关闭
        }
      })
    }

  }
  /**
   * Author:AbnerMing
   * Describe:条目布局
   * @param item  数据对象
   * @param index  数据索引
   */
  @Builder
  itemLayout(item: Object, index: number): void {
    //条目视图，任意组件
    Column(){
      Text(item.toString())
        .height(60)
        .width('100%')
        .fontSize(22)
        .textAlign(TextAlign.Center)
    }
  }
}