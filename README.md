# Godot 3D HMI 配置器

基于 Godot 4 的3D产品配置器Demo。

## 功能特性

- 3D模型展示
- 材质/颜色切换
- 360度旋转查看
- 鼠标/触摸交互
- 产品配置预览

## 技术栈

- Godot 4.2+
- GDScript

## 项目结构

```
assets/
├── scripts/          # GDScript脚本
├── scenes/          # 场景文件
├── materials/       # 材质
└── models/          # 3D模型
project/
└── project.godot    # 项目配置
```

## 快速开始

1. 安装 Godot 4.2+
2. 克隆项目
3. 用 Godot 打开项目目录
4. 运行

## 核心脚本

### ProductConfigurator.gd
产品配置器核心逻辑。

### CameraController.gd
相机控制。

### ConfiguratorUI.gd
UI控制器。

---

*创建时间: 2026-03-17*
