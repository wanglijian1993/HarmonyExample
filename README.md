# 鸿蒙基础练习

## Ability Kit
### 简介
AbilityKit是Harmony系统框架服务，通过AbilityKit的系统服务能力，开发者通过框架中的组件和服务快速开发自己想要的程序。
### 使用场景
<ul>
<li>
应用多Model开发：应用可通过不同类型的Module（HAP、HAR、HSP）来实现应用的功能开发。其中，HAP用于实现应用的功能和特性，HAR与HSP用于实现代码和资源的共享。
</li>
<li>
应用内的交互：应用内的不同组件之间可以相互跳转。比如，在支付宝应用中，通过入口UIAility组件启动收付款UIAbility组件
</li>
<li>
应用间的交互：当前应用可以启动其他应用，来完成某个任务或操作，比如，启动浏览器应用打开网站。
</li>
<li>
应用跨设备流转：通过引用的跨段前一和多端协同，获得更好的使用体验。比如，手机刷短视频可以迁移到平板上刷视频
</li>
</ul>

### 能力范围
手机端开发者很好理解就是移动端OS的基本能力
<ul>
<li>
应用程序的创建和销毁，应用生命周期的调度能力。
</li>
<li>
提供应用组件的主入口，应用组件的生命周期调度，组件间的交互能力
</li>
<li>
应用上下文切换，系统环境变化监听等能力
</li>
<li>
程序的流转，比较特殊的能力
</li>
<li>
提供程序访问控制能力，多包机制，共享包，应用心想配置等能力
</li>
</ul>

## Stage模型
Stage模型概念图
![img.png](img.png)
通过State模型概念图使用的是面向对象思想，Context是所有Stage模型的派生类。

### UiAbility组件
UiAbility组件是包含UI的应用组件，主要用于和用户的交互，比如通过返回按键返回到上一个界面，UIAbility组件的生命周期只包含创建/销毁/前台/后台等状态，与显示相关的状态通过WindowStaeg的事件暴漏给开发者。
#### Aibiity概述
Aiblity其实就是代表一个UI程序任务，可以在程序中配置一个或者多个。
#### UIAbility组件生命周期
UiAbility生命周期包括Create,Foreground,Background,Destory
##### OnCreate
Create状态为在应用加载过程中，UIAbility实例创建完成时触发，系统会调用onCreate()回调,可以在该回调中进行页面初始化操作，例如变量定义资源加载等，
##### Foreground
申请系统资源
##### Background
释放系统资源
##### Destory
Destroy状态在UIAbility实例销毁时触发。可以在onDestroy()回调中进行系统资源的释放、数据的保存等操作。
![img_1.png](img_1.png)
#### WindowStageCreate状态
UIAbility实例创建完成之后，在进入Foreground之前，系统会创建一个WindowStage。WindowStage创建完成后会进入onWindowStageCreate（）回调，
可以在该回调中设置UI回调，设置WindowStage的事件订阅。
![img_2.png](img_2.png)
事件回调
![img_3.png](img_3.png)

#### UIAbility组件基本用法 
指定UIAbility的启动页面，在UiAblity的派生类中，OnCreate方法创建完窗体后会生成WindowState对象，通过onWindowStateCreate回调方法中去loadContent具体UI组件
![img_4.png](img_4.png)
##### 获取UIAbility的上下文信息
UIAbility类拥有自身的上下文信息，该信息为UIAbilityContext类的实例，UIAbilityContext类拥有abilityInfo、currentHapModuleInfo等属性。通过UIAbilityContext可以获取UIAbility的相关配置信息，如包代码路径、Bundle名称、Ability名称和应用程序需要的环境状态等属性信息，以及可以获取操作UIAbility实例的方法（如startAbility()、connectServiceExtensionAbility()、terminateSelf()等）

#### Aiblity跳转
Aiblity代码跳转示例
`
const context = getContext() as common.UIAbilityContext
context.startAbilityForResult({
abilityName:'EntryAbility01',
bundleName:'com.harmony.myapplication',
})
`
#### 启动模式
##### singleton（单实例模式）
singleton单例模式，也是Ablity默认启动模式
每次调用startAbility()方法时，如果应用进程中该类型的UIAbility实例已经存在，则复用系统中的UIAbility实例。系统中只存在唯一一个该UIAbility实例，即在最近任务列表中只存在一个该类型的UIAbility实例。
##### multiton/standard（多实例模式）
multiton启动模式为多实例模式，每次调用startAbility()方法时，都会在应用进程中创建一个新的该类型UIAbility实例。即在最近任务列表中可以看到有多个该类型的UIAbility实例。这种情况下可以将UIAbility配置为multiton（多实例模式）。

##### specified（指定实例模式）
specified启动模式为指定实例模式，针对一些特殊场景使用（例如文档应用中每次新建文档希望都能新建一个文档实例，重复打开一个已保存的文档希望打开的都是同一个文档实例）。

### ExtensionAbility组件
ExtensionAbility组件是一种面向特定场景的应用组件。开发者并不直接从ExtensionAbility组件派生，而是需要使用ExtensionAbility组件的派生类。目前ExtensionAbility组件有用于卡片场景的FormExtensionAbility，用于输入法场景的InputMethodExtensionAbility，用于闲时任务场景的WorkSchedulerExtensionAbility等多种派生类，这些派生类都是基于特定场景提供的。例如，用户在桌面创建应用的卡片，需要应用开发者从FormExtensionAbility派生，实现其中的回调函数，并在配置文件中配置该能力。ExtensionAbility组件的派生类实例由用户触发创建，并由系统管理生命周期。在Stage模型上，三方应用开发者不能开发自定义服务，而需要根据自身的业务场景通过ExtensionAbility组件的派生类来实现。

### WindowStage
每个UIAbility实例都与一个WindowStage类实例绑定，该类起到了应用进程内窗口管理器的作用。
她包含一个主窗口。也就是说UIAbility实例通过WindowStage持有了一个主窗口，该主窗口为ArkUi提供了绘制区域。

### Context
Context及其派生类向开发者提供在运行期可以调用的各种资源和能力。

### AbilityStage
每个Entry类型Hap在运行期都有一个AbilityStage类实例，当HAP中的代码首次被加载到进程中的时候，系统会先创建AbilityStage实例。

## Stage模型应用组件
### 应用/组件级配置
图标和标签通常一起配置，可以分为应用图标、应用标签和入口图标、入口标签，分别对应app.json5配置文件和module.json5配置文件中的icon和label标签。
#### app.json
应用包的配置信息。
<ul>
<li>
bundleName标签:该标签用于标识应用的唯一性。
</li>
<li>
versionCode: 应用版本号数字类型
</li>
<li>
versionName：应用主次版本号
</li>
<li>
icon:应用图标
</li>
<li>
label:应用名称
</li>
</ul>

#### model.json5
model.json5对应EntryAbility的配置信息
#### 图标和标签配置

<ul>
<li>
skills:配置桌面图标连续启动
</li>
<li>
icon: UiAbility
</li>
<li>
icon: EntryAbility配置的应用图标
label:EntryAbility配置的标签
</li>
<li>
startWindowIcon:启动显示的标签
</li>
<li>
skills:entities中添加"entity.system.home"、actions中添加"ohos.want.action.home"。同一个应用有多个UIAbility配置上述字段时，桌面上会显示出多个图标.

</li>
</ul>
