extends BaseScene

@onready var healtsContainer = $CanvasLayer/heartsContainer
@onready var camera = $Camera2D


@export var slime_scena: PackedScene
@export var gusunuca_scena: PackedScene
@export var boss_scena: PackedScene

var current_wave: int
var starting_nodes:int
var current_nodes: int
var wave_spawn_ended
var boss_spawned: bool = false  # Флаг для отслеживания спавна босса


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	camera.follow_node = player
	
	healtsContainer.setMaxHearts(player.maxHealth)
	healtsContainer.updateHearts(player.currentHealth)
	player.hearthChanged.connect(healtsContainer.updateHearts)
	
	current_wave = 0
	Global.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()

func position_to_next_wave():
	if current_nodes == starting_nodes:
		if current_wave == 2 and not boss_spawned:
			wave_spawn_ended = false
			spawn_boss()
			return
		if current_wave != 0:
			Global.moving_to_next_wave = true
		#anim
		wave_spawn_ended = false
		current_wave += 1
		Global.current_wave = current_wave
		await get_tree().create_timer(0.5).timeout
		prepare_spawn("slime", 4.0, 4.0)
		prepare_spawn("gusunuca", 1.5, 2.0)
		print(current_wave)

func prepare_spawn(type, multiplayer, mob_spawns):
	var mob_amout = float(current_wave) * multiplayer
	var mob_wait_time: float = 2.0
	print("mob_amout: ", mob_amout)
	var mob_spawn_rounds = mob_amout / mob_spawns
	spawn_type(type, mob_spawn_rounds, mob_wait_time)

	

func spawn_type(type, mob_spawn_rounds, mob_wait_time):
	if type == "slime":
		var slime_spawn = $SlimeSpawn
		var slime_spawn_2 = $SlimeSpawn2
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var slime1 = slime_scena.instantiate()
				slime1.global_position = slime_spawn.global_position
				var slime2 = slime_scena.instantiate()
				slime2.global_position = slime_spawn_2.global_position
				add_child(slime1)
				add_child(slime2)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time).timeout
	wave_spawn_ended = true


func spawn_boss():
	boss_spawned = true
	current_wave = 4  # Устанавливаем 4 волну (босс)
	Global.current_wave = current_wave
	

	
	# Создаем босса
	var boss = boss_scena.instantiate()
	boss.global_position = $BossSpawn.global_position  # Убедитесь, что у вас есть эта нода на сцене!
	wave_spawn_ended = true
	add_child(boss)


func _process(delta: float) -> void:
	current_nodes = get_child_count()
	if wave_spawn_ended:
		position_to_next_wave()
	
	
	
	



func _on_invertoy_gui_closed() -> void:
	get_tree().paused = false


func _on_invertoy_gui_opened() -> void:
	get_tree().paused = true
