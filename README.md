在学习开源中国ios 源码的过程中，发现其实现view controller paging的方法利用table view:
－ 设置table view 的tranform 将其旋转90度，并设置pagingEnable
－ 为作为容器的view controller 添加child view controller（提供内容）
－ 将内容显示在table view中。

因为ios 由一个UIPageViewController，因此想到利用它来实现。
