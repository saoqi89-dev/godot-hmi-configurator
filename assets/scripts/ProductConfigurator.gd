extends Node3D
class_name ProductConfigurator

## 产品模型节点
@export var product_model: Node3D

## 材质数组
@export var materials: Array[Material]

## 材质名称
@export var material_names: Array[String] = ["默认白色", "炫酷黑色", "科技蓝色", "活力橙色", "奢华金色"]

## 旋转速度
@export var rotate_speed: float = 50.0

## 是否自动旋转
var auto_rotate: bool = true
var is_dragging: bool = false
var last_mouse_pos: Vector2 = Vector2.ZERO
var current_material_index: int = 0

func _ready() -> void:
    apply_material(0)

func _process(delta: float) -> void:
    if auto_rotate and not is_dragging:
        product_model.rotate_y(rotate_speed * delta)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            is_dragging = event.pressed
            last_mouse_pos = event.position
            if event.pressed:
                auto_rotate = false
            else:
                # 3秒后恢复自动旋转
                await get_tree().create_timer(3.0).timeout
                auto_rotate = true
        
        if event.button_index == MOUSE_BUTTON_WHEEL_UP:
            move_camera(-0.5)
        elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            move_camera(0.5)
    
    if event is InputEventMouseMotion and is_dragging:
        var delta = event.position - last_mouse_pos
        product_model.rotate_y(-delta.x * rotate_speed * 0.01)
        last_mouse_pos = event.position
    
    # 键盘控制
    if event.is_action_pressed("ui_left"):
        previous_material()
    elif event.is_action_pressed("ui_right"):
        next_material()
    elif event.is_action_pressed("ui_accept"):  # R键
        reset_view()

func next_material() -> void:
    current_material_index = (current_material_index + 1) % materials.size()
    apply_material(current_material_index)

func previous_material() -> void:
    current_material_index = (current_material_index - 1 + materials.size()) % materials.size()
    apply_material(current_material_index)

func set_material(index: int) -> void:
    if index >= 0 and index < materials.size():
        current_material_index = index
        apply_material(index)

func apply_material(index: int) -> void:
    if materials.is_empty() or not product_model:
        return
    
    var mesh_instances = product_model.get_tree().get_nodes_in_group("product_mesh")
    for mesh_instance in mesh_instances:
        if mesh_instance is MeshInstance3D:
            mesh_instance.set_surface_override_material(0, materials[index])
    
    print("[ProductConfigurator] 切换材质: ", material_names[index])
    
    # 通知UI更新
    var ui = get_tree().get_first_node_in_group("configurator_ui")
    if ui and ui.has_method("update_material_label"):
        ui.update_material_label(material_names[index])

func reset_view() -> void:
    var tween = create_tween()
    tween.tween_property(product_model, "rotation", Vector3.ZERO, 0.5)

func move_camera(distance: float) -> void:
    var camera = get_viewport().get_camera_3d()
    if camera:
        camera.position.z = clamp(camera.position.z + distance, 2.0, 10.0)

func get_current_config() -> Dictionary:
    return {
        "material_index": current_material_index,
        "material_name": material_names[current_material_index],
        "timestamp": Time.get_datetime_string_from_system()
    }
