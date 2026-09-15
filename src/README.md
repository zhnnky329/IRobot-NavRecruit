# Source Layout

现有 package 不按类别移动。`colcon` 可以递归发现 package，但移动第三方快照会制造大量路径变更，并增加相对路径、嵌套子模块和未提交适配代码的风险。类别以本文件为准。

| 目录 | 类型 | 构建方式 | 学生是否应修改 |
|---|---|---|---|
| `FAST_LIO/` | fastlio里程计 | `ament_cmake` / `colcon` | 默认不修改核心算法 |
| `livox_ros_driver2_humble/` | livox mid360驱动 | `ament_cmake_auto` / `colcon` | 默认不修改核心功能 |
| `livox_to_scan/` | livox点云转scan工具 | `ament_cmake` / `colcon` | 可配置使用；修改须说明原因 |
| `pcd_to_nav_map/` | pcd转换为nav2所需格式map工具 | CMake，已由 `COLCON_IGNORE` 排除 | 可配置使用；不是 ROS package |
| `develop/` | 考核开发代码入口 | `ament_cmake` / `colcon` | 是 |

## ROS 2 workspace

```bash
source /opt/ros/humble/setup.bash
colcon list
colcon build --symlink-install
source install/setup.bash
```

正常情况下，`colcon list` 会发现 `fast_lio`、`livox_ros_driver2` 与 `livox_to_scan`，以及你在 `student/` 中创建的 package。

## pcd_to_nav_map

该目录没有 `package.xml`，不是 ROS 2 package。独立构建示例：

```bash
cmake -S src/pcd_to_nav_map -B build/pcd_to_nav_map_standalone
cmake --build build/pcd_to_nav_map_standalone
./build/pcd_to_nav_map_standalone/pcd_to_nav2_map <输入.pcd> <配置.json>
```

现有示例配置包含旧开发机路径，使用前必须复制到学生自己的 package 并改为可复现路径；本轮没有擅自改变既有工具接口。

## 已知第三方约束

- FAST-LIO 中保留上游文档、算法实现和 ikd-Tree 文件，不进行统一格式化；
- Livox Driver 随附的 SDK 动态库当前为 x86-64；Driver 的 CMake 仍要求先把兼容架构的 Livox-SDK2 安装到系统；
- 第三方示例 launch 中可能存在上游默认的绝对 LVX 路径，队内 bringup 不应依赖这些默认值。
