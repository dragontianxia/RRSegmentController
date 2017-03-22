# RRSegmentController

写在前面：
这其实是一个很常见的切换菜单功能，以前的项目中只是需要切换两个列表。
现在很多APP中都有类似功能，其实主要还是scrollView之间的关联。
单独写出来，也是对之前功能的一个重温，也想之后有需求，可以直接拿来用。

//MARK - Version 1.0, Build 1
* 实现功能
1. 导航栏；
2. 内容滑动切换；
3. 导航栏的动画。

* 注意事项
1. 如果内容列表有滑动操作，考虑禁止RRsegmentController中的ScrollViewDelegate；
2. 点击导航栏，会判断内容列表是否显示滑动动画，避免出现多屏chuachuachua的效果。
