SMODS.Atlas{
    key = 'atlas_consumeable_opentolan',
    path = 'consumeable_opentolan.png',
    px = 71,
    py = 96,
}


SMODS.Consumable({
    key = "yahimod_opentolan",
    set = "Spectral",
    object_type = "Consumable",
    name = "opentolan",
    soul_set = "Spectral",
    loc_txt = {
        name = "Open To Lan",
        text={
        "Spawns the card",
        "{C:dark_edition}of your choice.{}",
        },
    },
	
	config = {},
	pos = {x=0, y= 1},
    soul_pos = { x = 0, y = 0 },
	order = 99,
	atlas = "atlas_consumeable_opentolan",
    unlocked = true,
    cost = 10,
    sell_cost = 0,
    hidden = true,

    use = function(self, card, area, copier)
        G.opentolan_canspawn = true
        G.opentolan_phase = Yahimod.ticks
        G.opentolan_phase_ex = 1
        G.opentolan_phase = 600
        print("Can spawn any item! Go to the Collection, hover on what you want and press Enter")
    end,

    can_use = function(self, card)
		return true
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

SMODS.Sound({key = "catvomit", path = "catvomit.ogg",})

SMODS.Atlas{
    key = 'atlas_yahimod_consumeables',
    path = 'yahimod_consumeables.png',
    px = 71,
    py = 96,
}

-- cat puke

SMODS.Consumable({
    key = "yahimod_puke",
    set = "Tarot",
    object_type = "Consumable",
    name = "puke",
    loc_txt = {
        name = "Puke",
        text={
        "Damages blinds",
        "by {C:attention}10%{}",
        },
    },
	
	config = {},
	pos = {x=0, y= 0},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,
    hidden = true,

    use = function(self, card, area, copier)
        play_sound("yahimod_catvomit")
        delay(1)
        G.GAME.blind.chips = G.GAME.blind.chips * 0.9
    end,

    can_use = function(self, card)
        if G.GAME.blind:get_type() then
		    return true
        end
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

-- cashouttf

SMODS.Consumable({
    key = "yahimod_cashouttf",
    set = "Tarot",
    object_type = "Consumable",
    name = "cashouttf",
    loc_txt = {
        name = "Cashout.tf",
        text={
        "Sells all your jokers for",
        "{C:attention}2x{} their {C:attention}sell values{}",
        "and makes the next {C:attention}7{} rerolls {C:green}free",
        "{C:inactive}(yes, this is an ad){}",
        },
    },
	
	config = {},
	pos = {x=1, y= 0},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        local _sellval = 0
        for i = 1, #G.jokers.cards do
            if not G.jokers.cards[i].ability.eternal then
                _sellval = _sellval + G.jokers.cards[i].sell_cost*2
            end
        end
        for i = 1, #G.jokers.cards do
            if not G.jokers.cards[i].ability.eternal then
                G.jokers.cards[i].getting_sliced = true
                G.jokers.cards[i] = nil
            end
        end
        ease_dollars(_sellval)
        G.GAME.current_round.free_rerolls = 7
        calculate_reroll_cost(true)
    end,

    can_use = function(self, card)
        if not G.GAME.blind:get_type() then
		    return true
        end
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

-- sponsor

SMODS.Consumable({
    key = "yahimod_sponsor",
    set = "Tarot",
    object_type = "Consumable",
    name = "sponsor",
    loc_txt = {
        name = "Sponsor",
        text={
        "Gain {C:attention}$#1#{}",
        },
    },
	
	
	pos = {x=2, y= 0},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,
    hidden = false,

    config = { extra = {dollaramt = 10}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.dollaramt }  }
	end,

    use = function(self, card, area, copier)
        ease_dollars(card.ability.extra.dollaramt)
    end,

    can_use = function(self, card)
        return true
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

-- fish

SMODS.Sound({key = "fish", path = "fish.ogg",})
SMODS.Sound({key = "fishloud", path = "fishloud.ogg",})

SMODS.Consumable({
    key = "yahimod_fish",
    set = "Tarot",
    object_type = "Consumable",
    name = "fish",
    loc_txt = {
        name = "Fish",
        text={
        "Fish!",
        },
    },
	
	
	pos = {x=3, y= 0},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,
    hidden = false,

    use = function(self, card, area, copier)
        if G.GAME.blind and G.GAME.blind.name == 'boss_fish' then
        G.showfish = 170*3
        play_sound("yahimod_fishloud")
        check_for_unlock({ type = "ach_stanleymovref" })
        else
        G.showfish = 170
        play_sound("yahimod_fish")
        end
    end,

    can_use = function(self, card)
        return true
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

SMODS.Sound({key = "mariopaintmeow", path = "mariopaintmeow.ogg",})

-- cardboardbox

SMODS.Consumable({
    key = "yahimod_cardboardbox",
    set = "Tarot",
    object_type = "Consumable",
    name = "cardboardbox",
    loc_txt = {
        name = "Cardboardbox",
        text={
        "Creates a random",
        "{C:attention}Cat Joker{}",
        "{C:inactive}(must have room){}",
        },
    },
	
	
	pos = {x=0, y= 1},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        local card = create_card("Cat", G.Jokers, nil, nil, nil, nil, nil, 'cardboardbox')
        card:add_to_deck()
        G.jokers:emplace(card)
        play_sound("yahimod_mariopaintmeow")
    end,

    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit then
            return true
        end
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})



-- yahiworld

SMODS.Consumable({
    key = "yahimod_yahiworld",
    set = "Tarot",
    object_type = "Consumable",
    name = "yahiworld",
    loc_txt = {
        name = "Yahiworld",
        text={
        "Creates a random",
        "{C:attention}Yahimod Joker{}",
        "{C:inactive}(must have room){}",
        },
    },
	
	
	pos = {x=1, y= 1},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        local card = create_card("Yahimodaddition", G.Jokers, nil, nil, nil, nil, nil, 'yahiworld')
        card:add_to_deck()
        G.jokers:emplace(card)
        play_sound("yahimod_mariopaintmeow")
    end,

    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit then
            return true
        end
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

-- win

SMODS.Sound({key = "catlaughing", path = "catlaughing.ogg",})

SMODS.Consumable({
    key = "yahimod_instantwin",
    set = "Tarot",
    object_type = "Consumable",
    name = "instantwin",
    loc_txt = {
        name = "Instant Win",
        text={
        "Instantly {C:attention}WIN{} the game!",
        },
    },
	
	
	pos = {x=2, y= 1},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        G.showlaughingcat = 990
        play_sound("win")
    end,

    can_use = function(self, card)
        return true
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})


SMODS.Consumable {
    set = "Tarot",
    key = "yahimod_hispanicgathering",
	config = {
        -- How many cards can be selected.
        max_highlighted = 1,
        -- the key of the seal to change to
        extra = 'whatsapp_seal',
    },
    loc_vars = function(self, info_queue, card)
        -- Handle creating a tooltip with seal args.
        info_queue[#info_queue+1] = G.P_SEALS[(card.ability or self.config).extra]
        -- Description vars
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    loc_txt = {
        name = 'Hispanic Family Gathering',
        text = {
            "Select {C:attention}#1#{} card to",
            "apply a {C:green}Whatsapp Seal{} to"
        }
    },
    cost = 4,
    atlas = "atlas_yahimod_consumeables",
    pos = {x=3, y=1},
    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('yahimod_whatsapp')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_seal("yahimod_whatsapp_seal",true,true)
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

SMODS.Consumable {
    set = "Tarot",
    key = "yahimod_vampire",
	config = {
        max_highlighted = 1,
        extra = 'vampire',
    },
    loc_vars = function(self, info_queue, card)
        -- Handle creating a tooltip with seal args.
        info_queue[#info_queue+1] = G.P_CENTERS.e_yahimod_evil
        -- Description vars
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    loc_txt = {
        name = 'Vampirify',
        text = {
            "Select {C:attention}#1#{} card to",
            "turn {C:red}Evil{}"
        }
    },
    cost = 4,
    atlas = "atlas_yahimod_consumeables",
    pos = {x=0, y=2},

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            return true
        end
	end,

    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('yahimod_vampire')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[1]:set_edition({ yahimod_evil = true })
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

-- amongwojak

SMODS.Consumable {
    set = "Tarot",
    key = "yahimod_amongwojak",
	config = {
        -- How many cards can be selected.
        max_highlighted = 3,
        -- the key of the seal to change to
        extra = 'ifunny_seal',
    },
    loc_vars = function(self, info_queue, card)
        -- Handle creating a tooltip with seal args.
        info_queue[#info_queue+1] = G.P_SEALS[(card.ability or self.config).extra]
        -- Description vars
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    loc_txt = {
        name = 'Among Wojak',
        text = {
            "Select up to {C:attention}#1#{} cards to",
            "apply an {C:dark_edition}Ifunny Watermark{} to"
        }
    },
    cost = 4,
    atlas = "atlas_yahimod_consumeables",
    pos = {x=1, y=2},
    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('paper1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_seal("yahimod_ifunny_seal",true,true)
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

-- is that yaha mouse

SMODS.Consumable({
    key = "yahimod_yahamouse",
    set = "Tarot",
    object_type = "Consumable",
    name = "yahimod_yahamouse",
    loc_txt = {
        name = "is that yaha mouse",
        text={
        "{C:green}#1# in #2# chance",
        "to spawn {C:attention}Yahiamice{}",
        },
    },
    config = {chance = 100},
    loc_vars = function(self, info_queue, card)
        return {vars = {G.GAME.probabilities.normal, (card.ability or self.config).chance}}
    end,
	
	
	pos = {x=2, y= 2},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        if pseudorandom('yahimod_yahamouse') < (G.GAME.probabilities.normal / card.ability.chance) then
            local card = create_card('Joker', G.Jokers, nil, nil, nil, nil, 'j_yahimod_yahicard', 'yahamouse')
            card:add_to_deck()
            G.jokers:emplace(card)
            play_sound("yahimod_jackpot")
        else
            -- copied from wheel of fortune
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Tarot,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4);return true end}))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
            return true end }))
        end
    end,

    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit then
            return true
        end
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

-- is that yaha mouse

SMODS.Consumable({
    key = "yahimod_fortune",
    set = "Tarot",
    object_type = "Consumable",
    name = "yahimod_fortune",
    loc_txt = {
        name = "Fortune Of Wheel",
        text={
        "{C:green}#1# in #2# chance",
        "to gain {C:attention}$1,000,000{}",
        },
    },
    config = {chance = 1000},
    loc_vars = function(self, info_queue, card)
        return {vars = {G.GAME.probabilities.normal, (card.ability or self.config).chance}}
    end,
	
	
	pos = {x=3, y= 2},
	order = 99,
	atlas = "atlas_yahimod_consumeables",
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        if pseudorandom('yahimod_fortune') < (G.GAME.probabilities.normal / card.ability.chance) then
            play_sound("yahimod_jackpot")
            check_for_unlock({ type = "ach_fortune" })
            ease_dollars(1000000)
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Tarot,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4);return true end}))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
            return true end }))
        end
    end,

    can_use = function(self, card)
        return true
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

SMODS.Consumable {
    set = "Tarot",
    key = "yahimod_jar",
	config = {
        -- How many cards can be selected.
        max_highlighted = 1,
        -- the key of the seal to change to
        extra = 'swapper_seal',
    },
    loc_vars = function(self, info_queue, card)
        -- Handle creating a tooltip with seal args.
        info_queue[#info_queue+1] = G.P_SEALS[(card.ability or self.config).extra]
        -- Description vars
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    loc_txt = {
        name = 'mod.jar',
        text = {
            "Select {C:attention}#1#{} card to",
            "apply a {C:red}Swap{C:blue}per Seal{} to"
        }
    },
    cost = 4,
    atlas = "atlas_yahimod_consumeables",
    pos = {x=0, y=3},
    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_seal("yahimod_swapper_seal",true,true)
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

SMODS.Sound({key = "splat", path = "splat.ogg",})

SMODS.Atlas{
    key = 'atlas_consumeable_sole',
    path = 'solecard.png',
    px = 63,
    py = 93,
}

-- Sole

SMODS.Consumable({
    key = "yahimod_solecard",
    set = "Spectral",
    object_type = "Consumable",
    name = "solecard",
    loc_txt = {
        name = "Sole",
        text={
        "foot",
        },
    },
	
	
	pos = {x=0, y= 0},
    soul_pos = { x = 0, y = 1 },
	order = 99,
	atlas = "atlas_consumeable_sole",
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        local card = create_card('Joker', G.Jokers, nil, nil, nil, nil, 'j_yahimod_foot', 'sole')
        card:add_to_deck()
        G.jokers:emplace(card)
        play_sound("yahimod_splat")
    end,

    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit then
            return true
        end
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})


-- reset open to lan on run restart (and other variables)
local _startrunhook = Game.start_run
function Game:start_run(args)
    _startrunhook(self, args)
    if G.SETTINGS.GAMESPEED == 0.25 then G.SETTINGS.GAMESPEED = 1 end
    if G.wiwidestroyed and G.wiwidestroyed ~= 0 then G.wiwidestroyed = 0 end

    if G.opentolan_canspawn == true then
        G.opentolan_phase_ex = 2
        G.opentolan_phase = Yahimod.ticks
        G.opentolan_canspawn = false
    end
end