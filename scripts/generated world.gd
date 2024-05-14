extends Node2D

@export var noiseHeightTexture : NoiseTexture2D
var noise: Noise

var width = 100
var height = 100

var waterSourseID = 3
var landSourseID = 0
var waterAtlas = Vector2(8, 1)
var landAtlas = Vector2(0, 0)

@onready var tile_map = $TileMap

func _ready():
	noise = noiseHeightTexture.noise
	generateWorld()

func generateWorld():
	for x in range(width):
		for y in range(height):
			var noiseValue = noise.get_noise_2d(x, y)
			print(noiseValue)
			if noiseValue >= 0.0:
				tile_map.set_cell(2, Vector2(x, y), landSourseID, landAtlas)
			elif noiseValue < 0.0:
				tile_map.set_cell(2, Vector2(x, y), waterSourseID, waterAtlas)
				pass
