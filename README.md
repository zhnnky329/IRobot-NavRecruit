# IRobot Navigation Recruitment 2027

西安电子科技大学 IRobot 战队算法组导航方向2027招新仓库。

```text
Task 1  ROS2 C++
   ↓
Task 2  MID360 / TF
   ↓
Task 3  FAST-LIO
   ↓
Task 4  Mapping / AMCL
   ↓
Task 5  Nav2
   ↓
Final   Full Navigation Stack
```

前五个 Task 会逐步搭建同一套导航系统。请保留并持续完善自己的代码、配置、Launch 与运行记录，不要把每周任务做成互不相关的临时工程。且所有考核相关代码请在`src/develop/`下进行开发。

## 任务导航


| Task                                                  | Topic          | 
| ----------------------------------------------------- | -------------- | 
| [Task 1](tasks/task1/README.md)                       | ROS2 C++       | 
| [Task 2](tasks/task2/README.md)            | Sensor / TF    | 
| [Task 3](tasks/task3/README.md)             | FAST-LIO       | 
| [Task 4](tasks/task04/README.md) | Mapping / AMCL | 
| [Task 5](tasks/task5/README.md)                 | Nav2           |
| [Final_task](tasks/final_task/README.md)                   | Integration    |



## 开始之前

- [环境准备](docs/environment.md)
- [AI 使用指南](docs/ai_agent_guide.md)
- [Git 指南](docs/git_guide.md)
- [开发规范](docs/development_rules.md)
- [当前已发布 Task](tasks/task01_ros2_cpp/README.md)

克隆仓库后先检查环境：

```bash
git clone https://github.com/zhnnky329/IRobot-NavRecruit.git
cd IRobot-NavRecruit
./scripts/check_environment.sh
colcon list
```
正常情况下，`colcon list` 会发现 `fast_lio`、`livox_ros_driver2` 与 `livox_to_scan`，以及在 `develop/` 中创建的 package

## 源码区域

现有目录暂不移动，以避免破坏第三方代码、路径和已有改动：


| 目录 | 类型 | 构建方式 | 是否应修改 |
|---|---|---|---|
| `FAST_LIO/` | fastlio里程计 | `ament_cmake` / `colcon` | 默认不修改核心算法 |
| `livox_ros_driver2_humble/` | livox mid360驱动 | `ament_cmake_auto` / `colcon` | 默认不修改核心功能 |
| `livox_to_scan/` | livox点云转scan工具 | `ament_cmake` / `colcon` | 可配置使用；修改须说明原因 |
| `pcd_to_nav_map/` | pcd转换为nav2所需格式map工具 | CMake，已由 `COLCON_IGNORE` 排除 | 可配置使用；不是 ROS package |
| `develop/` | 考核开发代码入口 | `ament_cmake` / `colcon` | 是 |

Task 1 请从零创建 `src/laser_safety_monitor`；Task 2 起建议持续维护 `src/nav_recruit_bringup`。