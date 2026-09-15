# Task 1

相关要求自行看[Task1飞书文档](https://w0ybodqyg7f.feishu.cn/wiki/OihSwtXqtiayJok0XCRc5Qprn5b)

提供相关练习数据集：


| 项目      | 内容                          |
| ------- | --------------------------- |
| Topic   | `/scan`                     |
| 消息类型    | `sensor_msgs/msg/LaserScan` |
| 帧数 / 频率 | 40 帧 / 5 Hz                 |
| 时长      | 约 8 秒                       |
| 激光束     | 181 束，约 -90° 至 +90°，每束间隔 1° |
| Frame   | `laser_frame`               |
| 数据内容    | 背景距离、前方障碍距离变化、少量 NaN/Inf    |


bag自然回放结束后没有新 scan，可用于检查自己的超时行为；使用 `--loop` 时则不会出现这一段停播时间。

## 下载

练习数据集戳[这里](https://drive.google.com/drive/folders/1mcY693bo-YwhWNIF0OMhMs1prb5tehpd)

下载文件名固定为 `public_scan.zip`。将下载的 ZIP 解压后放在本目录.

解压后应得到：

```text
tasks/task1/data/public_scan/
                ├── metadata.yaml
                └── public_scan_0.db3
```

## 使用

仍从仓库根目录执行：

```bash
ros2 bag info ./tasks/task1/data/public_scan
ros2 bag play ./tasks/task1/data/public_scan
```

重复练习可在最后一行加 `--loop`，验证 scan timeout 时不要加,建议另开终端启动自己写的节点。