/obj/projectile/magic/repel
	name = "bolt of repeling"
	expose_caster_on_deflect = TRUE
	icon = 'icons/effects/effects.dmi'
	icon_state = "curseblob"
	flag = "blunt"
	speed = MAGE_PROJ_FAST
	range = 15
	cannot_cross_z = TRUE

/obj/projectile/magic/repel/on_hit(target, blocked = FALSE)
	var/atom/throw_target = get_edge_target_turf(firer, get_dir(firer, target))
	if(isliving(target))
		var/mob/living/L = target
		if(L.anti_magic_check() || !firer)
			L.visible_message(span_warning("[src] vanishes on contact with [target]!"))
			return BULLET_ACT_BLOCK
		if(blocked >= 100)
			return
		L.throw_at(throw_target, out_of_effective_range() ? 3 : 7, 4)
	else
		if(isitem(target))
			var/obj/item/I = target
			if(I.anchored || I.move_resist >= MOVE_FORCE_STRONG)
				return
			var/mob/living/carbon/human/carbon_firer
			if (ishuman(firer))
				carbon_firer = firer
				if (carbon_firer?.can_catch_item())
					throw_target = get_edge_target_turf(firer, get_dir(firer, target))
			I.throw_at(throw_target, 7, 4)
