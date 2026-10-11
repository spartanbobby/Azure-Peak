/datum/crafting_recipe/roguetown/reading
	abstract_type = /datum/crafting_recipe/roguetown/reading
	display_category = ITEM_CAT_RAW_MATERIAL_ORGANIC
	req_table = TRUE
	verbage_simple = "write"
	skillcraft = /datum/skill/misc/reading
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/reading/goat_map
	name = "goat map"
	result = /obj/item/hunting_map/goats
	tools = list(/obj/item/natural/feather)
	reqs = list(/obj/item/paper/scroll = 3, /obj/item/natural/hide = 1)
	craftdiff = 2
