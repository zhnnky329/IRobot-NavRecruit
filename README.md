# IRobot 导航方向 2027 招新大考核

本仓库用于西安电子科技大学 IRobot 战队算法组导航方向最终大考核，使用时将该仓库fork到自己账号下，以IRobot-NavRecruit-自己名字 命名（如IRobot-NavRecruit-pgd）

本次考核要求在真实机器人平台上完成一套完整的基础导航系统。请在理解现有系统的基础上，独立完成实机数据采集、建图、地图整理、AMCL 定位和 Nav2 自主到点导航，使机器人能够使用自己建立的地图稳定定位并自主导航。

```text
实机数据采集
    ↓
   建图
    ↓
生成并整理导航地图
    ↓
AMCL 定位
    ↓
Nav2 自主到点导航
```



最终提交fork后你自己的仓库链接。仓库至少包含：

- 实际使用的代码与配置；
- Launch 文件和 YAML 配置；
- 自己生成的导航地图；
- README；
- 实机导航视频；
- 有意义的 Git Commit History。

提交仓库的 README 至少需要说明：

- 完整系统流程；
- 建图方法；
- 定位与导航启动方式；
- 主要 Topic 与 TF；
- 自己修改过的主要配置；
- 一次实际问题排查过程；
- AI 使用情况，包括 AI 提供的帮助以及本人如何验证相关结果。

请持续提交能够体现开发过程的 Commit。不要在考核结束时把全部内容一次性提交，也不要提交无法解释或没有实机验证的代码。

## 仓库结构

```text
IRobot-NavRecruit/
├── scripts/
│   └── check_environment.sh     #环境检查脚本
└── src/
    ├── FAST_LIO/
    ├── develop/
    ├── livox_ros_driver2_humble/
    ├── livox_to_scan/
    └── pcd_to_nav_map/
```

各目录用途如下：


| 目录                              | 用途                | 说明                                  |
| ------------------------------- | ----------------- | ----------------------------------- |
| `src/FAST_LIO/`                 | 指定的 FAST-LIO 程序   | 默认不要修改核心算法；确需修改时必须说明原因              |
| `src/livox_ros_driver2_humble/` | Livox MID360 驱动   | 根据实机网络和传感器配置使用                      |
| `src/livox_to_scan/`            | 点云转换为二维 LaserScan | 可根据实际 Topic、Frame 和裁剪范围配置           |
| `src/pcd_to_nav_map/`           | PCD 转导航地图工具       | 独立 CMake 工程，已通过 `COLCON_IGNORE` 排除  |
| `src/develop/`                  | 考核开发区             | 自己编写的代码、Launch、YAML、地图和 RViz 配置放在这里 |


请勿提交 `build/`、`install/`、`log/`、IDE 配置、Python 缓存、大型 rosbag 或无关文件。大型视频、rosbag 和 PCD 建议通过指定方式提供，并在 README 中给出链接和说明。

## 环境与构建

推荐环境为 Ubuntu 22.04、ROS 2 Humble 和 x86-64 计算机。