
/mob/living/carbon/human/species/elf/wood/hostile_npc //A mix of rangers and blackoaks these are the natives of Azure who continue the struggle
	aggressive=1
	mode = AI_IDLE
	faction = list("Feral Elf")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	stand_attempts = 6
	possible_rmb_intents = list()
	var/is_silent = TRUE /// Determines whether or not we will scream our funny lines at people.

/mob/living/carbon/human/species/elf/wood/hostile_npc/ambush
	aggressive=1
	wander = TRUE

/mob/living/carbon/human/species/elf/wood/hostile_npc/retaliate(mob/living/L)
	.=..()
	if(target)
		aggressive=1
		wander = TRUE

/mob/living/carbon/human/species/elf/wood/hostile_npc/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/elf/wood/hostile_npc/Initialize()
	. = ..()
	set_species(/datum/species/elf/wood)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE

/mob/living/carbon/human/species/elf/wood/hostile_npc/after_creation()
	..()
	job = "Feral Elf"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_AZURENATIVE, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/elf/wood/hostile_npc)
	gender = pick(MALE, FEMALE)
	regenerate_icons()

	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes/elf)
	var/obj/item/organ/ears/organ_ears = getorgan(/obj/item/organ/ears/elf)
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	var/hairf = pick(list(/datum/sprite_accessory/hair/head/longemo,
						/datum/sprite_accessory/hair/head/countryponytailalt,
						/datum/sprite_accessory/hair/head/stacy,
						/datum/sprite_accessory/hair/head/kusanagi_alt))
	var/hairm = pick(list(/datum/sprite_accessory/hair/head/ponytailwitcher,
						/datum/sprite_accessory/hair/head/dave,
						/datum/sprite_accessory/hair/head/emo,
						/datum/sprite_accessory/hair/head/sabitsuki))

	var/datum/bodypart_feature/hair/head/new_hair = new()

	if(gender == FEMALE)
		new_hair.set_accessory_type(hairf, null, src)
	else
		new_hair.set_accessory_type(hairm, null, src)

	new_hair.accessory_colors = "#2C1608"
	new_hair.hair_color = "#2C1608"
	hair_color = "#2C1608"

	head.add_bodypart_feature(new_hair)

	dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
	dna.species.handle_body(src)

	if(organ_eyes)
		organ_eyes.eye_color = "#669999"
		organ_eyes.accessory_colors = "#FFBF00#FFBF00"

	if(organ_ears)
		organ_ears.accessory_colors = "FFF0e9"

	skin_tone = SKIN_COLOR_GRENZEL_WOODS

	if(gender == FEMALE)
		real_name = pick(world.file2list("strings/rt/names/elf/elfwf.txt"))
	else
		real_name = pick(world.file2list("strings/rt/names/elf/elfwm.txt"))
	update_hair()
	update_body()

/mob/living/carbon/human/species/elf/wood/hostile_npc/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))

/mob/living/carbon/human/species/elf/wood/hostile_npc/handle_combat()
	if(mode == AI_HUNT)
		if(prob(5))
			emote("whistle")
	. = ..()

/datum/outfit/job/roguetown/human/species/elf/wood/hostile_npc/pre_equip(mob/living/carbon/human/H)
	. = ..()
	var/welf_random_cloak = rand(1,5)
	var/welf_random_armor = rand(1,3)
	var/welf_random_weapon = rand(1,2)
	var/welf_random_head = rand(1,10)
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather/rope
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets
	switch(welf_random_head)
		if(1,3)
			neck = /obj/item/clothing/head/roguetown/roguehood
		if(4,5)
			head = /obj/item/clothing/head/roguetown/dendormask
		if(6)
			head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
		if(10)
			head = /obj/item/clothing/head/roguetown/helmet/heavy/elven_helm
	switch(welf_random_cloak)
		if(1,2)
			cloak = /obj/item/clothing/cloak/forrestercloak
		if(3)
			cloak = /obj/item/clothing/cloak/raincloak/green
	switch(welf_random_armor)
		if(1)
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
		if(2)
			armor = /obj/item/clothing/suit/roguetown/armor/leather
		if(3)
			armor = /obj/item/clothing/suit/roguetown/armor/leather/trophyfur
	switch(welf_random_weapon)
		if(1)
			r_hand = /obj/item/rogueweapon/huntingknife
		if(2)
			r_hand = /obj/item/rogueweapon/spear
	H.STASTR = rand(10,12)
	H.STASPD = rand(16,18)
	H.STACON = rand(10,12)
	H.STAEND = rand(10,12)
	H.STAPER = rand(16,18)
	H.STAINT = rand(10,14)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

