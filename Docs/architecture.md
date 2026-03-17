# Godot 3D HMI 配置器 - 架构文档

## 1. 项目概述

**项目名称**: godot-hmi-configurator  
**项目类型**: 3D产品配置器Demo

---

## 2. 技术架构

- **引擎**: Godot 4.2+
- **语言**: GDScript
- **渲染**: GL Compatibility

---

## 3. 核心模块

### ProductConfigurator
| 方法 | 说明 |
|------|------|
| next_material() | 切换下一材质 |
| previous_material() | 切换上一材质 |
| set_material() | 设置指定材质 |
| reset_view() | 重置视角 |

### CameraController
| 方法 | 说明 |
|------|------|
| focus_on_target() | 聚焦目标 |
| reset_camera() | 重置相机 |

---

## 4. 交互方式

- 鼠标左键拖动旋转
- 鼠标右键旋转相机
- 滚轮缩放
- 键盘左右键切换材质
- R键重置视角

---

*文档版本: v1.0.0*  
*最后更新: 2026-03-17*
