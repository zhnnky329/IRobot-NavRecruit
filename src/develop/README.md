# Develop Workspace

考核自行实现和维护的 ROS 2 package 放在本目录。不要复制或修改第三方核心算法来完成作业。

## Task 1

从零创建：

```text
laser_safety_monitor/
```

仓库不提供该 package 的完整框架或标准答案。正式要求见群内分享的飞书文档。

## Task 2 起

建议创建并持续维护：

```text
nav_recruit_bringup/
├── launch/
│   ├── sensor.launch.py
│   ├── mapping.launch.py
│   ├── localization.launch.py
│   └── navigation.launch.py
├── config/
│   ├── sensor.yaml
│   ├── fast_lio.yaml
│   ├── amcl.yaml
│   └── nav2.yaml
├── maps/
└── rviz/
```

这是推荐的最终形态，不要求现在一次性创建所有文件。每周只新增当前任务真正需要并且已经验证的部分。

