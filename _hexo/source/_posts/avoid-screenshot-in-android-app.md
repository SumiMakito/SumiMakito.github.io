title: 防止Android应用内截图
date: 2015-11-23 15:59:41
tags:
- Android
- 窗口管理
- 开发安全
---
很多时候，用户需要在我们的应用中输入类似于身份证号、密码、银行卡号等敏感信息，此时如果在后台不怀好意的应用程序对这些敏感页面进行截图，将导致用户的个人信息泄露。
Android为我们提供了一种可以防止Activity被截图的方案来保护用户的隐私。
<!-- more -->
在 <code>setContentView</code> 前向窗口添加一个 <code>FLAG_SECURE</code> 的 <code>FLAG</code> 。
### 0x00 代码
```java
public class TestActivity extends Activity {
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    getWindow().addFlags(WindowManager.LayoutParams.FLAG_SECURE);
    setContentView(R.layout.main);
  }
}
```
### 0x01 实机测试
![直接截图](http://internal-static.keep.moe/blog.keep.moe/20151123_avoid-screenshot-in-android-app/00.00.png)
无法通过物理组合键截图
![通过ADB截图](http://internal-static.keep.moe/blog.keep.moe/20151123_avoid-screenshot-in-android-app/00.01.png)
![通过Dump View Hierarchy截图](http://internal-static.keep.moe/blog.keep.moe/20151123_avoid-screenshot-in-android-app/00.02.png)
![通过Dump View Hierarchy截图](http://internal-static.keep.moe/blog.keep.moe/20151123_avoid-screenshot-in-android-app/00.03.png)
无法使用开发工具截图
![通过Shell强行截图](http://internal-static.keep.moe/blog.keep.moe/20151123_avoid-screenshot-in-android-app/00.04.png)
通过Shell强行截图成功 但输出的截图文件除StatusBar含有不规则的像素外几乎为全透明

### 0x02 结语
Android使用 <code>FLAG_SECURE</code> 限制了SurfaceFlinger的功能，也用它将图形缓存区标记为不可截图，从而一定程度上的保证了屏幕区域的安全，正常开发的情况下推荐使用。

当然，如果你的用户安装了Xposed框架，别费尽心思了。Forget it~ :D
