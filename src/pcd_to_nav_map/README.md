# pcd_to_nav_map

将 PCD 点云按高度过滤、体素降采样后栅格化，输出nav2需要的 `.pgm` 和 `.yaml`。可在 JSON 中配置地图分辨率、高度范围和点云旋转角度。

这是独立 CMake 工具，不是 ROS 2 package；目录中的 `COLCON_IGNORE` 会使 `colcon build` 跳过它。

## 构建

需要 CMake、C++17、PCL 和 nlohmann_json 开发库。从仓库根目录执行：

```bash
cmake -S src/pcd_to_nav_map -B build/pcd_to_nav_map
cmake --build build/pcd_to_nav_map -j2
```

生成的程序是 `build/pcd_to_nav_map/pcd_to_nav2_map`。

## 使用

先复制 `src/pcd_to_nav_map/config/config.json` 并修改 `output_prefix`：它必须指向**已存在目录**下的文件前缀，建议用绝对路径，例如 `/home/yourname/maps/map`。仓库中的示例值 `./src/bringup/map/map` 是旧路径，不要直接照用。

```bash
./build/pcd_to_nav_map/pcd_to_nav2_map /absolute/path/map.pcd /absolute/path/config.json
```

若 `output_prefix` 是 `/home/yourname/maps/map`，输出为 `map.pgm` 和 `map.yaml`，位于 `/home/yourname/maps/`。

当前实现只将点云落入的格子标记为占用，其余保持未知，不会自动填充空闲区域。生成后应检查地图是否符合定位与导航使用要求。



不会用就去求助ai。