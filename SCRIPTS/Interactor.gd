extends Area3D

class_name Interactor

var controller: Node3D

func interact(interactable: Interactable):
	if is_instance_valid(interactable):
		interactable.interacted.emit(self)
	
func focus(interactable: Interactable):
	interactable.focus.emit(self)
	
func unfocus(interactable: Interactable):
	interactable.unfocused.emit(self)
	
func get_closest_interactable() -> Interactable:
	var liste: Array[Area3D] = get_overlapping_areas()
	var distance: float
	var closest_distance: float = INF
	var closest: Interactable = null
	
	for interactable in liste:
		distance = interactable.global_position.distance_to(global_position)
		
		if distance < closest_distance:
			closest = interactable as Interactable
			closest_distance = distance
			
			
	return closest
	
