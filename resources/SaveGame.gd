extends Resource
class_name SaveGame


@export var draupnirs: Draupnirs = Draupnirs.new()
@export var fast_travel_points: FastTravelPoints = FastTravelPoints.new()
@export var abilities: Abilities = Abilities.new()
@export var level_path: String = ""
@export var currency: int = 0
@export var last_camp_position: Vector2 = Vector2.ZERO
