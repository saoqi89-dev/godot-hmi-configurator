extends Camera3D
class_name CameraController

## 目标节点
@export var target: Node3D

## 距离设置
@export var distance: float = 5.0
@export var min_distance: float = 2.0
@export var max_distance: float = 10.0

## 旋转设置
@export var rotation_speed: float = 5.0
@export var min_pitch: float = -80.0
@export var max_pitch: float = 80.0

## 自动旋转
@export var auto_rotate: bool = true
@export var auto_rotate_speed: float = 10.0

var current_pitch: float = 20.0
var current_yaw: float = 0.0
var current_distance: float = 5.0

func _ready() -> void:
    current_distance = distance
    update_camera_position()

func _process(delta: float) -> void:
    if target:
        if auto_rotate:
            current_yaw += auto_rotate_speed * delta
        update_camera_position()

func _input(event: InputEvent) -> void:
    # 鼠标右键旋转
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            auto_rotate = false
            last_mouse_pos = event.position
            is_rotating = true
        elif event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed:
            is_rotating = false
            await get_tree().create_timer(3.0).timeout
            auto_rotate = true
        
        # 滚轮缩放
        if event.button_index == MOUSE_BUTTON_WHEEL_UP:
            current_distance = clamp(current_distance - 0.5, min_distance, max_distance)
        elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            current_distance = clamp(current_distance + 0.5, min_distance, max_distance)
    
    if event is InputEventMouseMotion and is_rotating:
        var delta = event.position - last_mouse_pos
        current_yaw += delta.x * rotation_speed * 0.01
        current_pitch = clamp(current_pitch - delta.y * rotation_speed * 0.01, min_pitch, max_pitch)
        last_mouse_pos = event.position

var is_rotating: bool = false
var last_mouse_pos: Vector2 = Vector2.ZERO

func update_camera_position() -> void:
    if not target:
        return
    
    var rot = Basis(Vector3.UP, deg_to_rad(current_yaw)) * Basis(Vector3.RIGHT, deg_to_rad(current_pitch))
    var offset = rot * Vector3(0, 0, current_distance)
    global_position = target.global_position + offset
    look_at(target.global_position)

func focus_on_target(new_target: Node3D) -> void:
    target = new_target

func reset_camera() -> void:
    current_pitch = 20.0
    current_yaw = 0.0
    current_distance = distance
    auto_rotate = true
