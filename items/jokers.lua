--- STEAMODDED HEADER
--- MOD_NAME: Yahimod
--- MOD_ID: Yahimod
--- MOD_AUTHOR: Yahiamice
--- MOD_DESCRIPTION: hi
--- PREFIX: yahi
----------------------------------------------------------
----------- MOD CODE -------------------------------------

SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'joker2',
    loc_txt= {
        name = 'Lazy Joker',
        text = { 'cba making a proper {C:attention} image for this',
                '{X:mult,C:white}X#1#{} Mult and {X:attention}$1{}' }
    },
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    pools = {["Yahimodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {
        Xmult = 1.215
    }},

    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return{
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT

            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
    calc_dollar_bonus = function(self,card)
        return 1
    end,
}

-- Marx
SMODS.Atlas{
    key = 'marx',
    path = 'marx.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'marx',
    loc_txt= {
        name = 'Marx',
        text = { "Gains {X:mult,C:white} X#1# {} Mult every time a",
                    "scored {C:attention}Lucky{} card {C:red}DOESN'T{} trigger",
                    "{C:inactive}Resets when a {}{C:attention}Lucky card{} {C:inactive}triggers{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",}
    },
    atlas = 'marx',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {Xmult = 1, additional = 0.25}},
    enhancement_gate = 'm_lucky',

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "Lydia" }}
		info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
		return { vars = { center.ability.extra.additional , center.ability.extra.Xmult}  }
	end,

    calculate = function(self, card, context)
		if context.joker_main and (card.ability.extra.Xmult > 1) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
				Xmult_mod = card.ability.extra.Xmult
			}
		end
        if context.individual and context.cardarea == G.play and context.other_card.ability.name == 'Lucky Card' and not context.other_card.lucky_trigger then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.additional
            if card.ability.extra.Xmult >= 3 then check_for_unlock({ type = "ach_marxblep" }) end
            return {
                message = "Unlucky!",
                colour = G.C.RED
            }
        end
        if context.individual and context.other_card.lucky_trigger then
            card.ability.extra.Xmult = 1
            return {
                message = ":p",
                colour = G.C.RED
            }
		end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- LCDirects
SMODS.Atlas{
    key = 'lcdirects',
    path = 'lcdirects.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'lcdirects',
    loc_txt= {
        name = 'LCDirects',
        text = { "Gains {X:mult,C:white} X#1# {} Mult every time a",
                    "Joker or playing card {C:red}is destroyed{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                    "",
                    "{C:inactive}``WHAT AM I GONNA DO WITH HALF A MULT?!``{}"
    }},
    atlas = 'lcdirects',
    rarity = 2,
    cost = 5,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 1},
    soul_pos = { x = 0, y = 0, extra = { x = 0, y = 0 } },
    config = { extra = {Xmult = 1, additional = 0.5}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.additional , center.ability.extra.Xmult}  }
	end,

    

    calculate = function(self, card, context)
		if context.joker_main and (card.ability.extra.Xmult > 1) then
            if card.ability.extra.Xmult >= 20 then check_for_unlock({ type = "ach_lc" }) end
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
				Xmult_mod = card.ability.extra.Xmult
			}
		end
        if context.remove_playing_cards then
            for k, val in ipairs(context.removed) do
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.additional
                return {
                    message = "BOOM!",
                    colour = G.C.RED
                }
            end
        end

        if G.hasajokerbeendestroyedthistick == true then
            G.hasajokerbeendestroyedthistick = false
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.additional
            return {
                message = "BOOM!",
                colour = G.C.RED 
            }
        end

        if context.using_consumeable then
            if context.consumeable.ability.name == 'Hex' or context.consumeable.ability.name == 'Ankh' then
                G.hasajokerbeendestroyedthistick = true
            end
            --print("LC" .. context.consumeable.ability.name)
        end

    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,


}

-- 21 kid
SMODS.Atlas{
    key = '21kid',
    path = '21kid.png',
    px = 71,
    py = 95,
}

SMODS.Sound({key = "nine", path = "nine.ogg",})
SMODS.Sound({key = "ten", path = "ten.ogg",})
SMODS.Sound({key = "twennyone", path = "twennyone.ogg",})

SMODS.Joker{
    key = '21kid',
    loc_txt= {
        name = '21 Kid',
        text = { "{X:mult,C:white} X#1# {} Mult if scored hand" ,
                    "contains a {C:attention}9{} and a {}{C:attention}10{}"}
    },
    atlas = '21kid',
    rarity = 1,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {Xmult = 2.1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult}  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
            local hasnine = false
            local hasten = false

            local hastwo = false -- achievement check
            local hasace = false

            for i = 1, #context.scoring_hand do
				if context.full_hand[i]:get_id() == 9 then
                    hasnine = true
                end
                if context.full_hand[i]:get_id() == 10 then
                    hasten = true
                end
                if context.full_hand[i]:get_id() == 14 then
                    hasace = true
                end
                if context.full_hand[i]:get_id() == 2 then
                    hastwo = true
                end
            end

            if hasnine == true and hasten == true and hasace == true and hastwo == true then   
                check_for_unlock({ type = "ach_twennyone" })
			end

            if hasnine == true and hasten == true then   
			return {
				message = "21!",
				Xmult_mod = card.ability.extra.Xmult,
                sound= "yahimod_twennyone",
			}
            end
		end
        if context.cardarea == G.play and context.individual and context.other_card then
            local rank = context.other_card:get_id()
			if rank == 9 then
				return {
                    sound = 'yahimod_nine',
                    message = '9!',
                }
			end
            if rank == 10 then
				return {
                    sound = 'yahimod_ten',
                    message = '10!',
                }
			end
		end

    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}
-- Jackblack
SMODS.Atlas{
    key = 'jackblack',
    path = 'jackblack.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'jackblack',
    loc_txt= {
        name = 'Jack Black',
        text = { "{X:mult,C:white} X#2# {} Mult for every",
                    "{C:attention}Jack{} in your full deck",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
    },},
    atlas = 'jackblack',
    rarity = 3,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { 
        extra = 
        {Xmult = 2
        , additional = 0.5
        , currentquip = 0
        , Xquips = { 'I... am STEVE.', 'Chicken Jockey!', 'THE NETHER.', 'Flint and STEEL!!', "First we mine,\n then we craft.\nLet's MINECRAFT!", "Octagon!", "I will literally\n suck your dick \nright now.", "Frigigigigigigigigi-"  }
        }},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult, center.ability.extra.additional, center.ability.extra.currentquip, center.ability.extra.Xquips }}
	end,

    update = function(self, card, dt)
        if G.jokers then
            local jackamount = G.playing_cards and calculate_jack_amount() or 0
            Xmult_mod = (card.ability.extra.additional * jackamount)
            card.ability.extra.Xmult = Xmult_mod
        end
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.currentquip = card.ability.extra.currentquip + 1
            if card.ability.extra.currentquip > 8 then
                card.ability.extra.currentquip = 1
            end
            if card.ability.extra.Xmult >= 5 then check_for_unlock({ type = "ach_jackblack" }) end
            return 
                {
                Xmult = Xmult_mod,
                message = card.ability.extra.Xquips[card.ability.extra.currentquip]
                }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Lydia Function

if not Yahimod then Yahimod = {} end
if not Yahimod.LydiaScale then Yahimod.LydiaScale = 1 end
local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
	if (
	    key == "x_mult"
	    or key == "xmult"
	    or key == "Xmult"
	    or key == "x_mult_mod"
	    or key == "xmult_mod"
	    or key == "Xmult_mod"
	) and amount ~= 1
	then
        local islydiahere = false
        local _lydiacard = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == 'j_yahimod_lydia' then
                islydiahere = true
                _lydiacard = G.jokers.cards[i]
            end
        end
        if G.GAME.current_round.hands_left ~= 0 and islydiahere == true then
            Yahimod.LydiaScale = tNum(Yahimod.LydiaScale * amount)
            if tNum(Yahimod.LydiaScale) >= tNum(1e100) then check_for_unlock({ type = "ach_lydia" }) end
            card_eval_status_text(_lydiacard,'jokers',nil,nil,nil,{message = "Stored X" ..amount.."!"})
            amount = 1
        end
	end
	local ret = scie(effect, scored_card, key, amount, from_edition)
	return ret
	end

-- Lydia 

SMODS.Atlas{
    key = 'lydia',
    path = 'lydia.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'yahimod_lydia',
    loc_txt= {
        name = 'Lydia',
        text = { "Stores all your {X:mult,C:white}XMult{}" ,
                    "and unleashes it on the {C:attention}final hand{}",
                    "{C:inactive}(Stockpiled: {X:mult,C:white} X#1# {C:inactive} Mult)",}
    },
    atlas = 'lydia',
    rarity = 4,
    cost = 20,
    pools = {["Yahimodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    demicoloncompat = true,

    pos = {x=0, y= 0},
    soul_pos = { x = 0, y = 1 },

    loc_vars = function(self, info_queue, center)
        return { vars = { tNum(Yahimod.LydiaScale) }}
    end,

    calculate = function(self, card, context)
        if (tNum(G.GAME.current_round.hands_left) == tNum(0) and context.final_scoring_step and tNum(Yahimod.LydiaScale) ~= tNum(1)) or context.forcetrigger then
            return {
                message = 'X' .. tNum(Yahimod.LydiaScale),
                xmult = Yahimod.LydiaScale
            }
        end
        if context.end_of_round or context.setting_blind then
            if tNum(Yahimod.LydiaScale) ~= tNum(1) then
                Yahimod.LydiaScale = tNum(1)
            end
        end
    end,

}
-- Lighttophat
SMODS.Atlas{
    key = 'lighttophat',
    path = 'lighttophat.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'lighttophat.png',
    loc_txt= {
        name = 'LightTophat',
        text = { "Once per round, duplicates",
                    "the first used {C:attention}consumable{}.",
                    "{C:inactive}(Must have room){}",
                    "#1#",
    },},
    atlas = 'lighttophat',
    rarity = 2,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = { active = "Active!"}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.active }  }
	end,

    calculate = function(self, card, context)

        if context.end_of_round and card.ability.extra.active == "Inactive" then
            card.ability.extra.active = "Active!"
        end
		if
			context.using_consumeable
			and not context.consumeable.beginning_end
		then
			if card.ability.extra.active == "Active!" then
                card.ability.extra.active = "Inactive"
				local card = create_card('', G.consumeables, nil, nil, nil, nil, context.consumeable.config.center_key, 'lighttophat')
				card:add_to_deck()
                if card.config.center_key == "c_yahimod_opentolan" then check_for_unlock({ type = "ach_printer" }) end
				G.consumeables:emplace(card)
                return{message = "Yep, that's going in the blackmail folder",}
			end
		end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}
-- Spongebobinspace
SMODS.Atlas{
    key = 'spongebobinspace',
    path = 'spongebobinspace.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'spongebobinspace.png',
    loc_txt= {
        name = 'Spongebob In Space',
        text = { "Creates your most played hand's",
                    "{C:attention}planet card{} every blind",
                    "Creates a Black Hole on boss blind",
                    "{C:inactive}(Must have room){}",
    },},
    atlas = 'spongebobinspace',
    rarity = 3,
    cost = 11,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {active = true}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.active }  }
	end,
    active = true,

    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local card_type = 'Planet'
            local _planet = 0
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == G.GAME.current_round.most_played_poker_hand then
                    _planet = v.key
                end
            end
            if G.GAME.blind:get_type() ~= 'Boss' then
                local card = create_card(nil, G.consumeables, nil, nil, nil, nil, _planet, 'spongebobinspace')
                card:add_to_deck()
                G.consumeables:emplace(card)
                active = false
                return{message = "AHHHHHHHHHHH!!!!!!"}
            else
                local card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_black_hole', 'spongebobinspace')
                card:add_to_deck()
                G.consumeables:emplace(card)
                active = false
                return{message = "AHHHHHHHHHHH!!!!!!"}
            end
            
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}
-- Doorknob
SMODS.Sound({key = "horsedeath", path = "horsedeath.ogg",})

SMODS.Atlas{
    key = 'doorknob',
    path = 'doorknob.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'doorknob',
    loc_txt= {
        name = 'Doorknob',
        text = { "{X:mult,C:white}X#1#{} Mult",
                    "{C:red}-X#2# Mult{} every round",},},
    atlas = 'doorknob',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {Xmult = 3, loss = 0.5}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_artcredit', set = 'Other', vars = { "Blake Andrews" }}
		return { vars = { center.ability.extra.Xmult, center.ability.extra.loss }  }
	end,


    
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            if card.ability.extra.Xmult > (1 + card.ability.extra.loss) then
                card.ability.extra.Xmult = (card.ability.extra.Xmult - card.ability.extra.loss)
                return{message = "-" .. card.ability.extra.loss,}
            else
                card:start_dissolve({G.C.RED})
                check_for_unlock({ type = "ach_jovial" })
                return{
                    message = "-" .. card.ability.extra.loss,
                    sound = "yahimod_horsedeath",
                }
            end
        end

        if context.joker_main then
            return{
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Deer
SMODS.Atlas{
    key = 'deer',
    path = 'deer.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'deer',
    loc_txt= {
        name = 'Deer',
        text = { "{C:red} +#1#{} Mult",
                    "{C:inactive}(Press {C:attention}Y{C:inactive} to summon deer)",
    },},
    atlas = 'deer',
    rarity = 1,
    cost = 2,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 2}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        return 
            {
            mult = card.ability.extra.mult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Budgie
SMODS.Atlas{
    key = 'budgie',
    path = 'budgie.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'budgie',
    loc_txt= {
        name = 'Budgie',
        text = { "{C:red} +#1#{} Mult and {X:mult,C:white}X#2#{} Mult",
                    "when you play a {C:spades}Spade{}, {C:clubs}Club{} or {C:attention}King{}",
    },},
    atlas = 'budgie',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 3, Xmult = 1.15, triggersthishand = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.Xmult }  }
	end,

    calculate = function(self, card, context)
    
    if context.cardarea == G.play and context.individual and context.other_card then
        local _trigger = false
        if context.other_card:get_id() == 13 then _trigger = true end
        if context.other_card:is_suit('Clubs') then _trigger = true end
        if context.other_card:is_suit('Spades') then _trigger = true end
        if _trigger == true then
            card.ability.extra.triggersthishand = card.ability.extra.triggersthishand + 1
            return {
                mult = card.ability.extra.mult,
                Xmult_mod = card.ability.extra.Xmult,
                message = "That's buckets!",
            }
        end
    end
    if context.post_joker then
        if card.ability.extra.triggersthishand >= 5 then check_for_unlock({ type = "ach_buckets" }) end
        card.ability.extra.triggersthishand = 0
    end

    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Glungus
SMODS.Atlas{
    key = 'glungus',
    path = 'glungus.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'glungus',
    loc_txt= {
        name = 'Glungus',
        text = { "Gains{C:red} +#2#{} Mult",
                    "every round",
                    "{C:inactive}(Currently {C:red}+#1# {C:inactive}Mult)",}
    },
    atlas = 'glungus',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 2, additional = 2}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.additional }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "+".. card.ability.extra.mult,
				mult_mod = card.ability.extra.mult
			}
        end
        if context.setting_blind then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.additional
            return {
                message = "Upgrade!",
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Penis
SMODS.Atlas{
    key = 'pe',
    path = 'pe.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'penis',
    loc_txt= {
        name = 'Penis',
        text = { "Gains{C:blue} +#2#{} Chips",
                    "every round",
                    "{C:inactive}(Currently {C:blue}+#1# {C:inactive}Chips)",}
    },
    atlas = 'pe',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 10, additional = 10}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.additional }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "+".. card.ability.extra.chips,
				chip_mod = card.ability.extra.chips
			}
        end
        if context.setting_blind then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.additional
            return {
                message = "Upgrade!",
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Greatest Golfer
SMODS.Atlas{
    key = 'greatestgolfer',
    path = 'greatestgolfer.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'greatestgolfer',
    loc_txt= {
        name = 'Greatest Golfer',
        text = { "{C:red}+#1#{} Mult",
                    "on the first hand of the round",
                    "Otherwise, {C:red}#2#{} Mult",}
    },
    atlas = 'greatestgolfer',
    rarity = 1,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 15, negativemult = -2}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.negativemult }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    message = "+".. card.ability.extra.mult,
                    mult_mod = card.ability.extra.mult
                }
            else
                return {
                    message = "-".. card.ability.extra.negativemult,
                    mult_mod = card.ability.extra.negativemult
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}


-- Moonwalkingpig
SMODS.Atlas{
    key = 'moonwalkingpig',
    path = 'moonwalkingpig.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'moonwalkingpig',
    loc_txt= {
        name = 'Moonwalking Pig',
        text = { "If you beat the boss blind",
                    "without triggering {C:red}fire effects,",
                    "go back by {C:attention}1 Ante{}",
                    "{C:inactive}(Self-Destructs when triggered)",}
    },
    atlas = 'moonwalkingpig',
    rarity = 2,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {triggered = false, chat = false}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.triggered, center.ability.extra.chat }  }
	end,

    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.chat = false
        end
		if context.end_of_round and (G.GAME.blind:get_type() == 'Boss') and (card.ability.extra.triggered == false) then
            if beatInOneHand() == false then
                ease_ante(-1)
                card_eval_status_text(card,'extra',nil,nil,nil,{message = "Hee-Hee!"})
                card:start_dissolve({G.C.RED})
                card.ability.extra.triggered = true
            else
                if card.ability.extra.chat == false then
                    card_eval_status_text(card,'extra',nil,nil,nil,{message = "Nah Nah!"})
                    card.ability.extra.chat = true
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Subway Surfers
SMODS.Atlas{
    key = 'subwaysurfers',
    path = 'subwaysurfers.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'subwaysurfers',
    loc_txt= {
        name = 'Subway Surfers',
        text = { "Randomly gains {C:blue}Chips{} ",
                    "and {C:red}Mult{} over time",
                    "Can randomly lose all {C:blue}Chips{} and {C:red}Mult{}",
                    "{C:inactive}(Currently {C:blue}#1#{C:inactive} Chips {C:red}#2#{C:inactive} Mult)",}
    },
    atlas = 'subwaysurfers',
    rarity = 3,
    cost = 10,
    pools = {["Yahimodaddition"] = true},

    pixel_size = { w = 71 , h = 96 },
    frame = 0,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 1, mult = 1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "New High Score!",
				chip_mod = card.ability.extra.chips,
                mult_mod = card.ability.extra.mult,
			}
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Sisyphus
SMODS.Atlas{
    key = 'sisyphus',
    path = 'sisyphus.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'sisyphus',
    loc_txt= {
        name = 'Sisyphean Joker',
        text = { "Gains {X:mult,C:white} X#2#{} Mult",
                    "every round",
                    "{C:green}#3# in #4#{} chance to reset",
                    "back to {X:mult,C:white}X1{} Mult",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",}
    },
    atlas = 'sisyphus',
    rarity = 2,
    cost = 8,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 1.5, additional = 0.5, chance = 4}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.additional, G.GAME.probabilities.normal, center.ability.extra.chance }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "x".. card.ability.extra.xmult,
				Xmult_mod = card.ability.extra.xmult
			}
        end
        if context.setting_blind then
            if pseudorandom('sisyphus') < (G.GAME.probabilities.normal / card.ability.extra.chance) then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.additional
                return {
                    message = "Upgrade!",
                }
            else
                card.ability.extra.xmult = 1
                return {
                    message = "Rolled back!",
                    play_sound("timpani")
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- abuelita

SMODS.Sound({key = "nomus1", path = "nomusic1.ogg",})
SMODS.Sound({key = "nomus2", path = "nomusic2.ogg",})
SMODS.Sound({key = "nomus3", path = "nomusic3.ogg",})
SMODS.Sound({key = "whip", path = "whip.ogg",})


SMODS.Atlas{
    key = 'abuelita',
    path = 'abuelita.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'abuelita',
    loc_txt= {
        name = 'Abuelita',
        text = { "Smacks all boss blinds,",
                    "reducing their required",
                    "score by half.",
                    "{C:inactive}NO MUSIC!",}
    },
    atlas = 'abuelita',
    rarity = 2,
    cost = 5,
    pools = {["Yahimodaddition"] = true},

    config = { extra = {storedmusicvol = 0}},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.setting_blind and (G.GAME.blind:get_type() == 'Boss') then
            G.GAME.blind.chips = G.GAME.blind.chips/2
            local _nomusic = {"yahimod_nomus1","yahimod_nomus2","yahimod_nomus3"}
            play_sound(_nomusic[math.random(#_nomusic)],math.random(0.9,1.1),0.5)
            play_sound("yahimod_whip",math.random(1.1,1.3),0.5)
            card.ability.extra.storedmusicvol = G.SETTINGS.SOUND.music_volume
            G.SETTINGS.SOUND.music_volume = 0
            return {
                
                message = "NO MUSIC!",
                
            }
        end
        if context.end_of_round and (G.GAME.blind:get_type() == 'Boss') then
           G.SETTINGS.SOUND.music_volume = card.ability.extra.storedmusicvol
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}


-- Roblox Madness
SMODS.Atlas{
    key = 'robloxmadness',
    path = 'robloxmadness.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'robloxmadness',
    loc_txt= {
        name = 'Roblox Madness',
        text = { "{C:blue}+#2#{} Chips {C:red}+#1#{} Mult",}
    },
    atlas = 'robloxmadness',
    rarity = 2,
    cost = 25,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    

    pos = {x=0, y= 0},
    config = { extra = {mult = 25, chips = 150}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.chips }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
            return {
                message = "+".. card.ability.extra.mult .. " Mult" .. "& " .. card.ability.extra.chips .. " Chips",
                mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
                }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Horse
SMODS.Sound({key = "horse", path = "horse.ogg",})

SMODS.Atlas{
    key = 'horse',
    path = 'horse.png',
    px = 71,
    py = 95,
}



SMODS.Joker{
    key = 'horsewalksin',
    loc_txt = {
        name = 'HORSE',
        text = { "{C:green}>be me",
        "{C:green}>playing Balatro",
        "{C:green}>reroll shop",
        "{C:green}>horse walks in",
        "{C:green}>he takes up an entire Joker slot",
        "{C:green}>wtf.jpeg",
        "{C:green}>i try to sell him",
        "{C:green}>fails",
        "{C:green}>huh.lua",
        "{C:green}>he neighs and then exclaims",
        "{C:green}in perfect english:",
        "{C:red}''You won't be able to shake me off",
        "{C:red}until (#2#/#3#) rounds later.''",
        "{C:green}>he's {X:mult,C:white}X#1#{C:green} mult",
        "{C:green}>what the fuck"},},
    atlas = 'horse',
    rarity = 2,
    cost = 1,
    pools = {["Yahimodaddition"] = true},


    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    hidden = true,
    

    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},
    config = { extra = {negativeXmult = 0.75, round = 0, maxround = 3}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.negativeXmult, center.ability.extra.round, center.ability.extra.maxround}}
	end,


    calculate = function(self, card, context)
		if context.joker_main then
            return {
                color = G.C.RED,
                message = "X".. card.ability.extra.negativeXmult,
                Xmult_mod = card.ability.extra.negativeXmult,
                }
            end
        if context.setting_blind and not context.blueprint then
            local _msg = "Neigh!"
            card.ability.extra.round = card.ability.extra.round + 1
            if card.ability.extra.round >= card.ability.extra.maxround then 
                _msg = "...Neigh?" 
                card.ability.eternal = nil 
            end
            return {
                message = _msg,
                sound = "yahimod_horse",
            }
        end
        if context.selling_self then
            play_sound("yahimod_horsedeath")
        end
    end,
}

SMODS.Joker{
    key = 'horsebait',
    loc_txt = {
        name = 'Horse',
        text = { "hi im a horsey"}
    },
    atlas = 'horse',
    rarity = 2,
    cost = 1,
    pools = {["Yahimodaddition"] = true},


    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},
    config = { extra = {trigger = false}},

    
    add_to_deck = function(self, card, from_debuff)
        addHorse()
        card:start_dissolve({G.C.RED})
        card = nil
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- fortnite y free fire

SMODS.Atlas{
    key = 'fortnitebabagee',
    path = 'fortnitebabagee.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'fortnitebabagee',
    loc_txt= {
        name = 'Fortnite y Babagee?',
        text = { "Randomly copies the",
                    "joker to its left",
                    "or the joker to its right.",}
    },
    atlas = 'fortnitebabagee',
    rarity = 2,
    cost = 7,
    config = { extra = {chosenside = 1}},
    pools = {["Yahimodaddition"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    calculate = function(self, card, context)
        if context.joker_main or context.final_scoring_step or context.before or context.end_of_round or context.setting_blind or context.discard or context.buying_card or context.selling_card or context.reroll_shop then
            card.ability.extra.chosenside = math.random(1,2)
        end
        for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then _selfid = i end
            end
        _lr = card.ability.extra.chosenside
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            
            if _lr == 1 then
                if context.other_card == G.jokers.cards[_selfid-1] then
                    return {
                        message = "Fortnite!",
                        repetitions = 1,
                        card = card,
                    }
                else
                    return nil, true end
            end
            if _lr == 2 then
                if context.other_card == G.jokers.cards[_selfid+1] then
                    return {
                        message = "Babagee!",
                        repetitions = 1,
                        card = card,
                    }
                else
                    return nil, true end
            end
		end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Koda
SMODS.Atlas{
    key = 'koda',
    path = 'koda.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'koda',
    loc_txt= {
        name = 'Koda',
        text = { "{C:dark_edition}+#1#{} Joker Slot",
                    "{C:inactive}''mrreow''",}
    },
    atlas = 'koda',
    rarity = 1,
    cost = 3,
    pools = { ["Cat"] = true,["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {jokerslots = 1}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "Koiroppi" }}
		return { vars = { center.ability.extra.jokerslots }  }
	end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.jokerslots
        if card.edition and card.edition.type and card.edition.type == "negative" then check_for_unlock({ type = "ach_negkoda" }) end
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.jokerslots
	end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Bean
SMODS.Atlas{
    key = 'bean',
    path = 'bean.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'bean',
    loc_txt= {
        name = 'Bean',
        text = { "Triggers one of the following:",
                    "{C:blue}+#1#{} Chips",
                    "OR {C:red}+#2#{} Mult",}
    },
    atlas = 'bean',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chipamt = 30, multamt = 6}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "Annuh_wx" }}
		return { vars = { center.ability.extra.chipamt, center.ability.extra.multamt, }  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        if math.random(1,2) == 1 then
            return {
                color = G.C.BLUE,
                message = "+".. card.ability.extra.chipamt,
                chip_mod = card.ability.extra.chipamt
            }
        else
            return {
                color = G.C.RED,
                message = "+".. card.ability.extra.multamt,
                mult_mod = card.ability.extra.multamt
            }
        end
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   

-- Leo
SMODS.Atlas{
    key = 'leo',
    path = 'leo.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'leo',
    loc_txt= {
        name = 'Leo',
        text = { "{C:blue}+#1#{} Chips",
                    "for every {C:attention}vowel in the",
                    "name of the card to its right",
                    "{C:inactive}Currently {C:blue}+#2#{C:inactive} Chips",}
    },
    atlas = 'leo',
    rarity = 2,
    cost = 5,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chipamt = 10, chiptotal = 0}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "LCDirects" }}
		return { vars = { center.ability.extra.chipamt, center.ability.extra.chiptotal }  }
	end,

    update = function(self, card, dt)
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then _selfid = i end
            end
            if _selfid and G.jokers.cards[_selfid+1] then
                local _cname = G.jokers.cards[_selfid+1].config.center.name
                if string.find(_cname,"j_") then _cname = G.jokers.cards[_selfid+1].config.center.loc_txt.name end

                _, nvow = string.gsub(_cname, "[AEIOUaeiou]", "")
                card.ability.extra.chiptotal = nvow * card.ability.extra.chipamt
            else
                card.ability.extra.chiptotal = 0
            end
        end
    end,

    calculate = function(self, card, context)
    
        
    if context.joker_main then
        if math.random(1,20) == 1 then
            local card = create_card(nil, G.consumeables, nil, nil, nil, nil, "c_yahimod_puke", 'leo')
            card:add_to_deck()
            G.consumeables:emplace(card)
        end
            return {
                color = G.C.BLUE,
                message = "+".. card.ability.extra.chiptotal,
                chip_mod = card.ability.extra.chiptotal
            }
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   

-- Tree

SMODS.Sound({key = "woodbreaking", path = "woodbreaking.ogg",})
SMODS.Sound({key = "woodbroke", path = "woodbroke.ogg",})

SMODS.Atlas{
    key = 'tree',
    path = 'tree.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'tree',
    loc_txt= {
        name = 'Tree',
        text = { "The supplement of",
                    "every Minecraft playthrough.",}
    },
    atlas = 'tree',
    rarity = 1,
    cost = 2,
    pools = { ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {damage = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.damage}  }
	end,

    calculate = function(self, card, context)
    if context.cry_press then
        if card.states.hover.is == true then
            card.ability.extra.damage = card.ability.extra.damage + 1
            local _treecardcenter = G.P_CENTERS.j_yahimod_tree
            _treecardcenter.pos.x = 1+math.floor(card.ability.extra.damage/5)
            card:juice_up(0.3,0.5)

            if card.ability.extra.damage > 2*5 then
                for i = 1, 4 do
                    local card = create_card("j_yahimod_oaklog", G.jokers, nil, nil, nil, nil, "j_yahimod_oaklog", 'tree')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
                card:start_dissolve({G.C.RED})
                check_for_unlock({ type = "ach_wood" })
                G.P_CENTERS.j_yahimod_tree.pos.x = 0
                play_sound("yahimod_woodbroke")
            else
                play_sound("yahimod_woodbreaking")
            end
        end

    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   

-- Oak Log
SMODS.Atlas{
    key = 'oaklog',
    path = 'oaklog.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'oaklog',
    loc_txt= {
        name = 'Oak Log',
        text = { "{C:red} +#1#{} Planks",
    },},
    atlas = 'oaklog',
    rarity = 1,
    cost = 2,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    hidden = true,

    pos = {x=0, y= 0},
    config = { extra = {mult = 4}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        return 
            {
            mult = card.ability.extra.mult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Toasterball

SMODS.Atlas{
    key = 'toasterball',
    path = 'toasterball.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'toasterball',
    loc_txt= {
        name = 'Toasterball',
        text = { "If you have {C:attention}2 Toasterball",
                    "jokers, retriggers",
                    "all jokers inbetween them",}
    },
    atlas = 'toasterball',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    add_to_deck = function(self, card, from_debuff)
        toastercount = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center_key == "j_yahimod_toasterball" and G.jokers.cards[i].debuff ~= true then
                toastercount = toastercount + 1
            end
        end
        if toastercount > 1 then
            G.FUNCS.overlay_menu{
                definition = create_UIBox_custom_video1("nuuh","I understand."),
                config = {no_esc = true}
            }
            card:start_dissolve()
            ease_dollars(7)
        else
            if toastercount == 1 then
                check_for_unlock({ type = "ach_ballin" })
            end
        end
    end,

    calculate = function(self, card, context)

        selfid = 0
        toastercount = 0
        othertoaster = 1

        -- get my id
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then selfid = i end
        end

        -- make sure there's exactly 2 toasters
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center_key == "j_yahimod_toasterball" then
                toastercount = toastercount + 1
            end
        end

        -- get other toasterball id if it exists
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card and G.jokers.cards[i].config.center_key == "j_yahimod_toasterball" then
                othertoaster = i
            end
        end

        --print(selfid..")toastercount:"..toastercount)
        --print(selfid..")othertoaster:"..othertoaster)

        if toastercount == 2 and selfid < othertoaster and context.retrigger_joker_check and not context.retrigger_joker then
            
            local _tempid = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == context.other_card then _tempid = i end
            end

                if _tempid > selfid and _tempid < othertoaster then
                    return {
                            message = "BALL!",
                            repetitions = 1,
                            card = card,
                        }
		    end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Joel
SMODS.Atlas{
    key = 'joel',
    path = 'joel.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'joel',
    loc_txt= {
        name = 'Joel',
        text = { "{X:mult,C:white}X#1#{} Mult",
                    "for every {C:attention}cat joker",
                    "in your possession",
                    "{C:inactive}Currently {X:mult,C:white}X#2#{C:inactive} Mult",}
    },
    atlas = 'joel',
    rarity = 2,
    cost = 5,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 1, xmulttotal=1}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "Ursen" }}
		return { vars = { center.ability.extra.xmult, center.ability.extra.xmulttotal, }  }
	end,

    calculate = function(self, card, context)
    catcount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Cat then
            catcount = catcount + 1
        end
    end
    card.ability.extra.xmulttotal = catcount * card.ability.extra.xmult
    if context.joker_main then
        if card.ability.extra.xmulttotal >= card.ability.extra.xmult*5 then check_for_unlock({ type = "ach_joelmax" }) end
        return {
            color = G.C.RED,
            message = "x".. card.ability.extra.xmulttotal,
            Xmult_mod = card.ability.extra.xmulttotal
        }
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

SMODS.Sound({key = "piglinhmm", path = "piglinhmm.ogg",})

-- Piglin
SMODS.Atlas{
    key = 'piglin',
    path = 'piglin.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'piglin',
    loc_txt= {
        name = 'Piglin',
        text = { "Creates a {C:attention}random consumable{}",
                    "if your first hand contains",
                    "a scoring {C:attention}gold card{}",
                    "{C:inactive}(Must have room)",
    },},
    atlas = 'piglin',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    enhancement_gate = 'm_gold',

    pos = {x=0, y= 0},
    config = { extra = {mult = 3, Xmult = 1.15}},

    

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.Xmult }  }
	end,

    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            local _hasgold = false
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_gold') then
                    _hasgold = true
                end
            end
            if _hasgold == true and #G.consumeables.cards < G.consumeables.config.card_limit then 
                    
                    return{
                    G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    blocking = false,
                    delay = 0,
                    func = function()
                        message = "Hmm..."
                        play_sound("yahimod_piglinhmm")
                        local cardgen = create_card("Consumeables", G.Consumeables, nil, nil, nil, nil, nil, 'piglin')
                        cardgen:add_to_deck()
                        G.consumeables:emplace(cardgen)
                        return true
                    end,
                    }))
                    }

                    
                end
           
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Dr Whatsapp
SMODS.Atlas{
    key = 'drwhatsapp',
    path = 'drwhatsapp.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'drwhatsapp',
    loc_txt= {
        name = 'Dr. Whatsapp',
        text = { "Retriggers scored {C:green}Whatsapp Seals{} twice",
                    "If your first hand contains",
                    "{C:attention}only{} one card, applies",
                    "a {C:green}Whatsapp Seal{} to it",
    },},
    atlas = 'drwhatsapp',
    rarity = 3,
    cost = 9,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card.seal == "yahimod_whatsapp_seal" then 
                    return {
                        message = localize("k_again_ex"),
                        repetitions = 2,
                        card = card,
                    }
            end
        end

        if context.cardarea == G.play and context.individual and #G.play.cards == 1 and G.GAME.current_round.hands_played == 0 then
            context.other_card:set_seal("yahimod_whatsapp_seal",true,true)
            return {
                        message = "Whatsapp-ified!",
                        card = card,
                        sound = "yahimod_whatsapp",
                        }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- gatowhatsapp
SMODS.Atlas{
    key = 'gatowhatsapp',
    path = 'gatowhatsapp.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'gatowhatsapp',
    loc_txt= {
        name = 'Gato Whatsapp',
        text = { "Sell this card to apply",
                    "a {C:green}whatsapp seal",
                    "to two random cards",
                    "in your hand",}
    },
    atlas = 'gatowhatsapp',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},

    calculate = function(self, card, context)
    if context.selling_self then
        local _eligiblecards = {}
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].seal == nil then
                table.insert(_eligiblecards,i)
            end
        end
        if #_eligiblecards >= 2 then
            local _pickedid = math.random(#_eligiblecards)
            local _picked1 = _eligiblecards[_pickedid]
            table.remove(_eligiblecards,_pickedid)
            local _picked2 = _eligiblecards[math.random(#_eligiblecards)]
            play_sound("yahimod_whatsapp")
            G.hand.cards[_picked1]:set_seal("yahimod_whatsapp_seal",true,true)
            G.hand.cards[_picked2]:set_seal("yahimod_whatsapp_seal",true,true)
        else
            return{
                message = "How the fuck do you want me to do this"
            }
        end
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

-- Yahicard
SMODS.Atlas{
    key = 'yahicard',
    path = 'yahicard.png',
    px = 138,
    py = 186,
}

SMODS.Joker{
    key = 'yahicard',
    loc_txt= {
        name = 'Yahiamice',
        text = { "Rerolls become {C:attention}free",
                    "Sets your shop slots to {C:attention}9",
                    "The more you reroll, the more likely",
                    "{C:dark_edition}Negative{} cards show up",
                    "{C:inactive}(Currently{} {C:dark_edition}#2#%{C:inactive} odds)",
    },},
    atlas = 'yahicard',
    rarity = 4,
    cost = 24,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    soul_pos = { x = 0, y = 1 },
    config = { extra = {oldshopsize = 3, buffedodds = 0}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_artcredit', set = 'Other', vars = { "Lisnovski" }}
		return { vars = { center.ability.extra.oldshopsize, center.ability.extra.buffedodds }  }
	end,

    add_to_deck = function(self, card, from_debuff)
        check_for_unlock({ type = "ach_isthat" })
        G.GAME.current_round.free_rerolls = 2
        card.ability.extra.oldshopsize = G.GAME.shop.joker_max
        G.GAME.current_round.free_rerolls = 2
        G.GAME.shop.joker_max = 9
        if G.shop then
            G.shop:recalculate()
            G.shop_jokers.T.w = 6*1.02*G.CARD_W
            G.shop_jokers.T.h = 1.05*G.CARD_H
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.GAME.shop.joker_max = card.ability.extra.oldshopsize
	end,


    
    calculate = function(self, card, context)
        

        if context.end_of_round then
            card.ability.extra.buffedodds = 0
        end

        if context.starting_shop then
            G.GAME.current_round.free_rerolls = 2
            G.GAME.shop.joker_max = 9
            G.shop:recalculate()
            G.shop_jokers.T.w = 6*1.02*G.CARD_W
            G.shop_jokers.T.h = 1.05*G.CARD_H
        end


        if context.store_joker_create then
            --print("shopjoker created!")

        end


        G.GAME.current_round.free_rerolls = 2
        if context.reroll_shop then
            G.GAME.shop.joker_max = 9
            G.shop:recalculate()
            G.GAME.current_round.free_rerolls = 2
            card.ability.extra.buffedodds = card.ability.extra.buffedodds + 0.3
            if card.ability.extra.buffedodds > 110 then check_for_unlock({ type = "ach_yahilimit" }) end
            for i = 1, #G.shop_jokers.cards do
                if math.random(0,100) < card.ability.extra.buffedodds then
                    G.shop_jokers.cards[i]:set_edition({negative = true}, true)
                end
                if math.random(0,500) < card.ability.extra.buffedodds then
                    G.shop_jokers.cards[i]:set_edition({yahimod_evil = true}, true)
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,

    
}

-- Cantaloupe

SMODS.Sound({key = "cantaloupe", path = "cantaloupe.ogg",})
SMODS.Atlas{
    key = 'cantaloupe',
    path = 'cantaloupe.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'cantaloupe',
    loc_txt= {
        name = 'Cantaloupe',
        text = { "{C:red} +#1#{} Mult",
    },},
    atlas = 'cantaloupe',
    rarity = 2,
    cost = 6,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 25}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        G.showcantaloupe = 230
        play_sound("yahimod_cantaloupe")
        return 
            {
            mult = card.ability.extra.mult,
            
            
            }
        end
    end,
    
    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- doudou
SMODS.Atlas{
    key = 'doudou',
    path = 'doudou.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'doudou',
    loc_txt= {
        name = 'Doudou',
        text = { "{C:red}+#1#{} Mult for every other",
                    "a {C:attention}Cat Joker",
                    "in your possession",
                    "{C:inactive}Currently {C:red}+#2# Mult"}
    },
    atlas = 'doudou',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 3, multtotal =0 }},
    
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "@sansanmaoer" }}
		return { vars = { center.ability.extra.mult , center.ability.extra.multtotal}  }
	end,


    calculate = function(self, card, context)
    catcount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Cat then
            catcount = catcount + 1
        end
    end
    card.ability.extra.multtotal = catcount * card.ability.extra.mult
    if context.joker_main then
        return {
            color = G.C.RED,
            message = "+".. card.ability.extra.multtotal,
            mult_mod = card.ability.extra.multtotal
        }
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

-- hoglin
SMODS.Atlas{
    key = 'hoglin',
    path = 'hoglin.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'hoglin',
    loc_txt= {
        name = 'Hoglin',
        text = { "{C:red}+#1#{} Mult if",
                    "{C:blue}Hands{} < {C:red}Discards",
                    "{C:dark_edition}Triggers before scoring!{}"}
    },
    atlas = 'hoglin',
    rarity = 2,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 10, triggered = false}, },
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.triggered}  }
	end,


    calculate = function(self, card, context)
    if context.post_joker then card.ability.extra.triggered = false end
        
    if context.individual and context.cardarea == G.play and card.ability.extra.triggered == false then
        if G.GAME.current_round.hands_left < G.GAME.current_round.discards_left then
            card.ability.extra.triggered = true
            return {
                color = G.C.RED,
                message = "+".. card.ability.extra.mult,
                mult_mod = card.ability.extra.mult
            }
        end
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

-- ocd
SMODS.Atlas{
    key = 'ocd',
    path = 'ocd.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'ocd',
    loc_txt= {
        name = 'Obsessive Compulsory Disjoker',
        text = { "Earn {C:attention}$#1#{} at end of round",
                    "if your jokers are ordered by",
                    "name length (shortest to longest)",
                    "{C:inactive}Currently #2#"}
    },
    atlas = 'ocd',
    rarity = 2,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {dollar = 8 , active = "Inactive"}},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.dollar, center.ability.extra.active}  }
	end,

    update = function(self,card,dt)
        local _streak = false
        if G.jokers and G.jokers.cards then
            _streak = true
            for i = 1, #G.jokers.cards do
            if G.jokers.cards[i+1] then
            local _cardname = G.jokers.cards[i].config.center.name
            if string.find(_cardname,"j_") and G.jokers.cards[i].config.center.loc_txt then _cardname = G.jokers.cards[i].config.center.loc_txt.name end
            local _cardnamenext = G.jokers.cards[i+1].config.center.name
            if string.find(_cardnamenext,"j_") and G.jokers.cards[i+1].config.center.loc_txt then _cardnamenext = G.jokers.cards[i+1].config.center.loc_txt.name end
            if _cardnamenext and G.jokers.cards[i+1] then
                if string.len(_cardnamenext) < string.len(_cardname) then _streak = false end
                end
            end
        end
    end
    if _streak == false then card.ability.extra.active = "Inactive" else card.ability.extra.active = "Active!" end
    end,

    calculate = function(self, card, context)
    
end,

    calc_dollar_bonus = function(self,card)
        if card.ability.extra.active == "Active!" then 
            return card.ability.extra.dollar 
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

SMODS.Sound({key = "crash", path = "crash.ogg",})

-- damedane
SMODS.Atlas{
    key = 'damedane',
    path = 'damedane.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'damedane',
    loc_txt= {
        name = 'Dame Dane',
        text = { "{C:red}+#1#{} mult",
                    "{C:green}#2# in #3#{} chance",
                    "to crash the game"}
    },
    atlas = 'damedane',
    rarity = 2,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 20, chance = 6}},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, G.GAME.probabilities.normal, center.ability.extra.chance }  }
	end,


    calculate = function(self, card, context)
    if context.joker_main then
        if pseudorandom('damedane') < (G.GAME.probabilities.normal / card.ability.extra.chance) then crashGame() end
        return {
            color = G.C.RED,
            message = "+".. card.ability.extra.mult,
            mult_mod = card.ability.extra.mult
        }
    end
end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  


SMODS.Sound({key = "okaypeople", path = "okaypeople.ogg",})

-- YTPMV ELF
SMODS.Atlas{
    key = 'ytpmvelf',
    path = 'okaypeople.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'ytpmvelf',
    loc_txt= {
        name = 'ytpmv elf',
        text = { "Retriggers all",
                    "{C:dark_edition}polychrome{} Jokers",}
    },
    atlas = 'ytpmvelf',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card.edition and context.other_card.edition.type == "polychrome" then
                return {
                    message = "Gay People!",
                    repetitions = 1,
                    card = card,
                    sound = "yahimod_okaypeople",
                }
            else
                return nil, true end
		end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- PREMIERE
SMODS.Atlas{
    key = 'adobepremiere',
    path = 'adobepremiere.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'adobepremiere',
    loc_txt= {
        name = 'Adobe Premiere',
        text = { "{X:mult,C:white}X#1#{} mult",
                    "{C:green}#2# in #3#{} chance",
                    "to crash the game"}
    },
    atlas = 'adobepremiere',
    pixel_size = { w = 71, h = 71  },
    rarity = 2,
    cost = 8,
    pools = { ["Yahimodaddition"] = true },  
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 2, chance=6, roundssince=0}},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, G.GAME.probabilities.normal, center.ability.extra.chance}  }
	end,


    calculate = function(self, card, context)
    if context.setting_blind then
        card.ability.extra.roundssince = card.ability.extra.roundssince + 1
    end
    if context.joker_main then
        if pseudorandom('adobepremiere') < (G.GAME.probabilities.normal / card.ability.extra.chance) then 
            crashGame()
            if card.ability.extra.roundssince < 2 then check_for_unlock({ type = "ach_goddamnit" }) end
        end
        return {
            color = G.C.RED,
            message = "x".. card.ability.extra.xmult,
            Xmult_mod = card.ability.extra.xmult
        }
        end
    end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

SMODS.Sound({key = "glassbreak", path = "glassbreak.ogg",})

-- VEGAS
SMODS.Atlas{
    key = 'sonyvegas',
    path = 'sonyvegas.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'sonyvegas',
    loc_txt= {
        name = 'Sony Vegas',
        text = { "{X:mult,C:white}X#1#{} mult",
                    "Explodes when a",
                    "consumable is used"}
    },
    atlas = 'sonyvegas',
    pixel_size = { w = 71, h = 71  },
    rarity = 2,
    cost = 8,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 2}},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult}  }
	end,


    calculate = function(self, card, context)
    if context.joker_main then
        return {
            color = G.C.RED,
            message = "x".. card.ability.extra.xmult,
            Xmult_mod = card.ability.extra.xmult
        }
        end
    if context.using_consumeable and not context.consumeable.beginning_end
		then
			explodeCard(card)
		end
    end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

recheckTwitch("please")

-- twitchchat
SMODS.Atlas{
    key = 'twitchchat',
    path = 'twitch.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'twitch',
    loc_txt= {
        name = 'Twitch Chat',
        text = { "{C:blue}+#1#{} Chips for every 1000",
                    "followers {C:attention}Yahiamice",
                    "has on {C:dark_edition}Twitch",
                    "{C:inactive}Currently {C:blue}+#2# Chips"}
    },
    atlas = 'twitchchat',
    rarity = 2,
    cost = 8,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {perfollow = 1, followercount = math.floor(G.yahifollowers/1000) }},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.perfollow , center.ability.extra.followercount}  }
	end,


    calculate = function(self, card, context)
    recheckTwitch()
    card.ability.extra.followercount = math.floor(G.yahifollowers * card.ability.extra.perfollow / 1000)
    if context.joker_main then
        return {
            color = G.C.BLUE,
            message = "+".. card.ability.extra.followercount,
            chip_mod = card.ability.extra.followercount
        }
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- twitchstream
SMODS.Atlas{
    key = 'twitchstream',
    path = 'twitchstream.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'twitchstream',
    loc_txt= {
        name = 'Twitch Stream',
        text = { "{C:red}+#1#{} Mult for every 5",
                    "viewers currently watching",
                    "{C:attention}Yahiamice on {C:dark_edition}Twitch",
                    "{C:inactive}Currently {C:red}+#2#{C:inactive} Mult"}
    },
    atlas = 'twitchstream',
    rarity = 3,
    cost = 7,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {perviewer = 1, viewercount = G.yahiviewers/5 }},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.perviewer , center.ability.extra.viewercount}  }
	end,


    calculate = function(self, card, context)
    recheckTwitch()
    card.ability.extra.viewercount = G.yahiviewers * card.ability.extra.perviewer/5
    if context.joker_main then
        return {
            color = G.C.RED,
            message = "+".. card.ability.extra.perviewer,
            mult_mod = card.ability.extra.viewercount
        }
    end
end,
}

SMODS.Sound({key = "eat", path = "eat.ogg",})

-- blingbear
SMODS.Atlas{
    key = 'blingblingbear',
    path = 'blingblingbear.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'blingblingbear',
    loc_txt= {
        name = 'Bling Bling Bear',
        text = { "Eats the joker on its left",
                "when {C:attention}Blind{} is selected, and adds",
                "half its {C:attention}sell value{} to this",
                "Joker's end-of-round payout",
                "{C:inactive}(Currently {C:attention}$#1#{C:inactive})"}
    },
    atlas = 'blingblingbear',
    rarity = 3,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {payout = 1}},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.payout}  }
	end,


    calculate = function(self, card, context)
    if context.setting_blind and not context.retrigger_joker then
        local _myid
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                _myid = i
            end
        end
        if G.jokers.cards[_myid - 1] then
            if G.jokers.cards[_myid - 1].ability.eternal ~= true then
                _cardeaten = G.jokers.cards[_myid - 1]
                card.ability.extra.payout = card.ability.extra.payout + math.max(1,math.floor(_cardeaten.sell_cost/2))
                if card.ability.extra.payout >= 10 then check_for_unlock({ type = "ach_bigandround" }) end 
                _cardeaten.getting_sliced = true

                _cardeaten:start_dissolve()
                _cardeaten = nil
                return{message = "Yum!", sound = "yahimod_eat"}
            else
                if G.jokers.cards[_myid - 1].ability.name == 'j_yahimod_horsewalksin' then
                    G.FUNCS.overlay_menu{
                        definition = create_UIBox_custom_video1("nuuh","I understand that a bear wouldn't find an Eternal Horse tasty whatsoever"),
                        config = {no_esc = true}
                    }
                else
                    return{message = "Hey that's not very nice."}
                end
            end
        else
            return{message = "#Starving..."}
        end
    end
end,

    calc_dollar_bonus = function(self,card)
        return card.ability.extra.payout
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

SMODS.Sound({key = "muchotexto", path = "muchotexto.ogg",})

-- muchotexto
SMODS.Atlas{
    key = 'muchotexto',
    path = 'muchotexto.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'muchotexto',
    loc_txt= {
        name = 'mucho texto',
        text = { "If boss blind has more",
                "than 1 line of text,",
                "{C:red}disables it{}"}
    },
    atlas = 'muchotexto',
    rarity = 3,
    cost = 8,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},

    calculate = function(self, card, context)
        if G.GAME.blind.loc_debuff_lines and context.setting_blind and not context.retrigger_joker then
            if #G.GAME.blind.loc_debuff_lines > 1 then
                play_sound("gong")
                play_sound("yahimod_muchotexto")
                G.GAME.blind:disable()
                G.GAME.blind.loc_debuff_lines = {"mucho texto"}
                SMODS.juice_up_blind()
                return{message = "mucho texto"}
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Half-Blueprint
SMODS.Atlas{
    key = 'halfblueprint',
    path = 'halfblueprint.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'halfblueprint',
    loc_txt= {
        name = 'Half-Blueprint',
        text = { "Copies ability of",
                    "{C:attention}Joker{} to the right",
                    "{C:green}#3# out of #2#{} times{}"}
    },
    atlas = 'halfblueprint',
    pixel_size = { w = 71 , h = 64 },
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},

    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = { mainodds = 1, totalodds = 2, bptarget = 0, chance = 2} },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mainodds, center.ability.extra.totalodds, G.GAME.probabilities.normal }  }
	end,

    calculate = function(self, card, context)
        local _myid = getJokerID(card)
        if G.jokers.cards[_myid + 1] then card.ability.extra.bptarget = G.jokers.cards[_myid + 1] end

        if pseudorandom('halfblueprint') < (G.GAME.probabilities.normal / card.ability.extra.totalodds) and context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card == G.jokers.cards[getJokerID(card) + 1] then
                return {
                    repetitions = 1,
                    card = card,
                }
            else
                return nil, true 
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- blueprintdagger
SMODS.Atlas{
    key = 'blueprintdagger',
    path = 'blueprintdagger.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'blueprintdagger',
    loc_txt= {
        name = 'Bluenemonial Printer',
        text = { "When the {C:attention}Joker{} to the right",
                    "triggers, retriggers it {C:green}#1# times{},",
                    "{C:red}destroys it, and adds",
                    "{C:green}1{} to future retriggers"}
    },
    atlas = 'blueprintdagger',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = { retriggers = 1, target = 0 , bptarget = 0 } },

    

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.retriggers, center.ability.extra.target}  }
	end,

    calculate = function(self, card, context)
        local _myid = getJokerID(card)
        if G.jokers.cards[_myid + 1] and G.jokers.cards[_myid + 1].ability.eternal ~= true then card.ability.extra.bptarget = G.jokers.cards[_myid + 1] end

        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card and context.other_card == G.jokers.cards[_myid+1] then
            local _canslice = false
            local _retriggeramount = card.ability.extra.retriggers
            if context.other_card and context.other_card.ability.eternal ~= true then _canslice = true end
            if _canslice == true then
                --print("myid" .. _myid)
                --print("retriggeramount" .. _retriggeramount)
                --print(_canslice)
                local _victim = context.other_card
                card.ability.extra.target = _victim
                local _triggerhappened = false
                
                
                
                --print("trigger picked!")
                    
                    

                    return{

                    repetitions = math.max(_retriggeramount,0),
                    
                    }
                    
            else
                return nil, true 
            end
        end

        if context.final_scoring_step and card.ability.extra.target ~= 0 then
            local _victim = card.ability.extra.target
            card.ability.extra.target = 0
            card.ability.extra.retriggers = card.ability.extra.retriggers + 1
            if card.ability.extra.retriggers >= 10 then check_for_unlock({ type = "ach_bluenemonial" }) end
            return{ G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    blocking = false,
                    delay = 0,
                        func = function()
                            if 1 == 1 then
                                _triggerhappened = true
                                _victim.card = nil
                                card_eval_status_text(card,'extra',nil,nil,nil,{message = "Sliceprinted!"})
                                _victim.getting_sliced = true
                                _victim:start_dissolve()
                                play_sound("slice1")
                                return true
                            end
                        end,
                    })),}
        end
       
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Greenprint
SMODS.Atlas{
    key = 'greenprint',
    path = 'greenprint.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'greenprint',
    loc_txt= {
        name = 'Greenprint',
        text = { "Copies ability of {C:green}Uncommon",
                    "{C:attention}Joker{} to the right",
                    "{C:attention}#1#",}
    },
    atlas = 'greenprint',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},

    config = { extra = { active = "Inactive" , bptarget = 0 } },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.active}  }
	end,

    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    update = function(self, card, front)
        local _myid = getJokerID(card)
        if G.jokers and G.jokers.cards[_myid + 1] then card.ability.extra.bptarget = G.jokers.cards[_myid + 1] end

		if G.STAGE == G.STAGES.RUN then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i + 1]
				end
			end
			if other_joker and other_joker ~= card and other_joker.config.center.rarity == 2 then
				card.ability.extra.active = "Compatible!"
            else
                card.ability.extra.active = "INCOMPATIBLE"
		    end
        end
	end,


    calculate = function(self, card, context)
        
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card == G.jokers.cards[getJokerID(card) + 1] and context.other_card.config.center.rarity == 2 then
                return {
                    repetitions = 1,
                    card = card,
                }
            else
                return nil, true 
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

--  Trueprint
SMODS.Atlas{
    key = 'trueprint',
    path = 'trueprint.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'trueprint',
    loc_txt= {
        name = 'TRUEPRINT',
        text = { "Retriggers the {C:attention}Joker{}",
                    "to the right {C:blue}twice."}
    },
    atlas = 'trueprint',
    rarity = 4,
    cost = 25,
    pools = {["Yahimodaddition"] = true},

    config = { extra = { active = "Inactive" , bptarget = 0 } },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.active}  }
	end,

    update = function(self, card, front)
        local _myid = getJokerID(card)
        if G.jokers and G.jokers.cards[_myid + 1] then card.ability.extra.bptarget = G.jokers.cards[_myid + 1] end
    end,

    calculate = function(self, card, context)

        --and not context.retrigger_joker--
        --and context.retrigger_check--
        if context.retrigger_joker then 
            return{
                repetitions = 2,
                retrigger_joker = retrigger_card
            }
        end

        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card == G.jokers.cards[getJokerID(card) + 1] then
                if context.other_card.bptarget and context.other_card.bptarget ~= 0 then
                    return {
                        repetitions = 2,
                        card = context.other_card.bptarget,
                    }
                else
                    return {
                        repetitions = 2,
                        --card = card,
                    }
                end
            else
                return nil, true 
            end
        end
    end,
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},

    

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

--  Whoprint
SMODS.Atlas{
    key = 'whoprint',
    path = 'whoprint.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'whoprint',
    loc_txt= {
        name = 'Whoprint?',
        text = { "Retriggers a random",
                    "compatible {C:attention}Joker{}."}
    },
    atlas = 'whoprint',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},

    calculate = function(self, card, context)
        --and not context.retrigger_joker--
        _jkrlist = {}
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.blueprint_compat == true and G.jokers.cards[i] ~= card then
                table.insert(_jkrlist,G.jokers.cards[i])
            end
        end
        if #_jkrlist > 0 then _randomid = math.random(1,#_jkrlist) end
        if (#_jkrlist > 0) and context.retrigger_joker_check and (context.other_card ~= self) then
            if context.other_card == _jkrlist[_randomid] then
                return {
                    repetitions = 1,
                    card = card,
                    message = "Again?"
                }
            else
                return nil, true 
            end
        end
    end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Katana
SMODS.Atlas{
    key = 'katana',
    path = 'katana.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'katana',
    loc_txt= {
        name = 'Katana',
        text = { "If {C:attention}Katana{} is the rightmost",
                    "{C:attention}Joker{} in your lineup,",
                    "destroys the leftmost consumable",
                    "you own when you select a Blind",
                    "and gains {C:red}+#1#{} Mult",
                    "{C:inactive}(Currently {C:red}+#2#{}{C:inactive} Mult)",}
    },
    atlas = 'katana',
    rarity = 2,
    cost = 5,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {multamt = 4, multtotal = 0}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "Burssty" }}
		return { vars = { center.ability.extra.multamt, center.ability.extra.multtotal }  }
	end,
    
    calculate = function(self, card, context)
        local _myid = getJokerID(card)
        if context.setting_blind then
            if _myid == #G.jokers.cards and G.consumeables.cards[1] then
                G.consumeables.cards[1]:start_dissolve()
                card.ability.extra.multtotal = card.ability.extra.multtotal + card.ability.extra.multamt
                if card.ability.extra.multtotal >= card.ability.extra.multamt*8 then check_for_unlock({ type = "ach_katana" }) end
                return{message = "Slice!",
                sound = "slice1",
                }
            end
        elseif context.joker_main then
            return {
                mult = card.ability.extra.multtotal
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Guy Pointing
SMODS.Atlas{
    key = 'guypointing',
    path = 'guypointing.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'guypointing',
    loc_txt= {
        name = 'Guy Pointing At Caption',
        text = { "If you don't beat the Blind's",
                    "required score, grants you a Part 2",
                    "{C:inactive}({C:blue}+1{} Hand and {C:red}+1{} Discard)",
                    "{C:inactive}(Effect triggers once per round)",}
    },
    atlas = 'guypointing',
    rarity = 2,
    cost = 7,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},
    config = { extra = {triggered = false}},
    
    calculate = function(self, card, context)
        if context.setting_blind and card.ability.extra.triggered == true then
            card.ability.extra.triggered = false
        end

        if context.final_scoring_step and card.ability.extra.triggered == false then
            if G.GAME.current_round.hands_left == 0 and G.GAME.chips < G.GAME.blind.chips then
                G.GAME.current_round.hands_left = 1
                card.ability.extra.triggered = true
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + 1

                play_sound('chips2')
                
                local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
                local discard_UI = G.HUD:get_UIE_by_ID('discard_UI_count')
                hand_UI.config.object:update()
                discard_UI.config.object:update()
                G.HUD:recalculate()
                    attention_text({
                    text = "+1",
                    scale = 0.8, 
                    hold = 0.7,
                    cover = discard_UI.parent,
                    cover_colour = col,
                    align = 'cm',
                    })
                    attention_text({
                    text = "+1",
                    scale = 0.8, 
                    hold = 0.7,
                    cover = hand_UI.parent,
                    cover_colour = col,
                    align = 'cm',
                    })
                return{message = "(Part 2)",}
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Shulkerbox
SMODS.Atlas{
    key = 'shulkerbox',
    path = 'shulkerbox.png',
    px = 75,
    py = 75,
}

SMODS.Joker{
    key = 'shulkerbox',
    loc_txt= {
        name = 'Magenta Shulker Box',
        text =  { "minecraft:magenta_shulker_box",}
        --text = { "Triggers a random bonus:",
        --            "{C:blue}+#1#{} Chips",
        --            "{C:red}+#2#{} Mult",
        --            "{X:blue,C:white}X#3#{} Chips",
        --            "{X:mult,C:white}X#4#{} Mult",
        --            "{C:attention}$#5#{}",
        --            "Nope!",
         --           "{C:inactive}Changes every hand",}
    },
    atlas = 'shulkerbox',
    rarity = 1,
    display_size = { w = 75, h = 75 },
    cost = 4,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chipamt = 20, multamt = 10, xchipamt = 1.5, xmultamt = 1.5, dollaramt = 3, chosen = 5, inventory = {} }},
    

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chipamt, center.ability.extra.multamt, center.ability.extra.xchipamt, center.ability.extra.xmultamt, center.ability.extra.dollaramt, center.ability.extra.chosen }  }
	end,

    calculate = function(self, card, context)
    if context.post_joker then
        
        G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    blocking = false,
                    delay = 0,
                        func = function()
                            if 1 == 1 then
                                card.ability.extra.chosen = math.random(1,6)
                                local _iteminquestion = nil
                                local _inv = {}
                                for i = 0, 26 do
                                    if math.random(1,3) < 3 then _inv[i+1] = card.ability.extra.chosen else _inv[i+1] = nil end
                                end
                                card.ability.extra.inventory = _inv
                                card_eval_status_text(card,'extra',nil,nil,nil,{message = "Randomized!"})
                                return true
                            end
                        end,
                    }))
    end

    if context.joker_main then
        if card.ability.extra.chosen == 4 then
            return {
                color = G.C.BLUE,
                message = "+".. card.ability.extra.chipamt,
                chip_mod = card.ability.extra.chipamt
            }end
        if card.ability.extra.chosen == 2 then
            return {
                color = G.C.RED,
                message = "+".. card.ability.extra.multamt,
                mult_mod = card.ability.extra.multamt
            }end
        if card.ability.extra.chosen == 3 then
            return {
                color = G.C.BLUE,
                message = "x".. card.ability.extra.xchipamt,
                x_chips = card.ability.extra.xchipamt
            }end
        if card.ability.extra.chosen == 1 then
            return {
                color = G.C.RED,
                message = "x".. card.ability.extra.xmultamt,
                Xmult_mod = card.ability.extra.xmultamt
            }end
        if card.ability.extra.chosen == 5 then
            ease_dollars(card.ability.extra.dollaramt)
            card_eval_status_text(card,'extra',nil,nil,nil,{message = "$"..card.ability.extra.dollaramt})
        end
        if card.ability.extra.chosen == 6 then
            card_eval_status_text(card,'extra',nil,nil,nil,{message = "Nope!"})
        end
    end
end,
}

-- elwiwi
SMODS.Atlas{
    key = 'elwiwi',
    path = 'elwiwi.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'elwiwi',
    loc_txt= {
        name = 'el wiwi',
        text = { "{C:blue}+#1#{} Chips and {C:red}+#2#{} Mult",
                    "if your hand has only one card",
                    "Explodes when clicked on",}
    },
    atlas = 'elwiwi',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 20, mult = 6}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
    if context.cry_press and card.states.hover.is == true then
        if G.wiwidestroyed == nil then G.wiwidestroyed = 0 end
        G.wiwidestroyed = G.wiwidestroyed + 1
        if G.wiwidestroyed >= 5 then check_for_unlock({ type = "ach_violence" }) end 
        explodeCard(card)
    end
            
    if context.joker_main then
        if #G.play.cards == 1 then
            return 
            {
                message = "wiwi",
                mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
            }
        end
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

SMODS.Sound({key = "ultrakill_landing", path = "ultrakill_landing.ogg",})
SMODS.Sound({key = "coin", path = "coin.ogg",})
SMODS.Sound({key = "parry", path = "parry.ogg",})
SMODS.Sound({key = "snd_explosion", path = "snd_explosion.ogg",})
SMODS.Sound({
    key = "music_cybergrind", 
    path = "music_cybergrind.ogg",
    pitch = 1,
    volume = 0.6,
    select_music_track = function()
        if jokerExists("j_yahimod_ultrakill") and string.len(G.GAME.blind.name) > 0 then
		    return true end
	end,
})


-- Ultrakill
SMODS.Atlas{
    key = 'ultrakill',
    path = 'ultrakill.png',
    px = 71,
    py = 96,
}

-- ultrakill coin click check
userHasClicked = function(x,y)
    if G.coinout and G.coinout.clickabletimer == 0 then
        local _card = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == 'j_yahimod_ultrakill' then
                _card = G.jokers.cards[i] 
            end
        end
        local mx, my = love.mouse.getPosition() 
        local _lw = 96 -- pixel leeway 

        local _xscale = love.graphics.getWidth()/1920
        local _yscale = love.graphics.getHeight()/1080

        local x2 = G.coinout.x + 64 * _xscale
        local y2 = G.coinout.y + 64 * _yscale

        local _hit = BoundingBox(G.coinout.x-_lw,G.coinout.y-_lw,x2+_lw,y2+_lw,mx,my)

        --print(_hit)
        --print("vals: ".. G.coinout.x .." | ".. G.coinout.y .." | ".. x2 .." | ".. y2 .." | ".. mx .." | ".. my)

        if _hit ~= true then
            missCoin()
        else
            hitCoin(_card)
        end
    end
end


-- ultrakill reset blocker func
resetBlockerCoin = function()
    G.hascoinbeenthrown = nil
    G.hascointriggered = nil
    G.coinout = nil
    G.haltingevaluation = nil
    G.haltevaleventsent = nil
end

-- ultrakill misscoin func
missCoin = function()
    --print("MISSED!!")
    G.coinout = nil
    G.hascoinbeenhit = 1
    --G.hascoinbeenthrown = true
    G.hascointriggered = true

    G.haltingevaluation = nil
    G.haltevaleventsent = nil

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == 'j_yahimod_ultrakill' then
            _card = G.jokers.cards[i] 
            _card.ability.extra.xmult = 2
            _card.ability.extra.xchips = 2
            _card.ability.extra.pleasetrigger = false
            card_eval_status_text(_card,'extra',nil,nil,nil,{message = "MISS!"})
        end
    end
    
end



-- ultrakill sucessfully hitcoin func
hitCoin = function(card)
    if G.coinout then
    local temp_Xmult = card.ability.extra.xmult - card.ability.extra.additional
    local temp_x_chips = card.ability.extra.xchips - card.ability.extra.additional

        
        playEffect("explosion",285,625)
        playEffect("parry",0,0)
        shakeEverything(25)
        
        --mult = mod_mult(mult*temp_Xmult)
        --hand_chips = mod_chips(hand_chips*temp_x_chips)

        G.hascointriggered = true
        G.hascoinbeenhit = 2
        G.coinout = nil
        G.haltingevaluation = nil
        G.haltevaleventsent = nil


        for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == 'j_yahimod_ultrakill' then
            _card = G.jokers.cards[i] 
            _card.ability.extra.xmult = _card.ability.extra.xmult + _card.ability.extra.additional
            _card.ability.extra.xchips = _card.ability.extra.xchips + _card.ability.extra.additional
        end
    end
        card_eval_status_text(_card,'extra',nil,nil,nil,{message = "CLANG!"})
        _card.ability.extra.pleasetrigger = true
        playEffect("crack",161,522)


    --return _rset
    end
end

-- Hook so that the calc triggers mid scoring
local hook = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    --print("play evaluated")
    ret = hook(e)
    local _trig = false
    --print("hooked!")
    if jokerExists("j_yahimod_ultrakill") then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == 'j_yahimod_ultrakill' and G.jokers.cards[i].debuff == false then 
                _joker = G.jokers.cards[i]
                _trig = true
            end
        end
    end 

    if _trig == true and G.coinout == nil and G.hascoinbeenthrown == nil then 
        --print("threwcoin") 
        throwCoin(_joker.tilt_var.mx,_joker.tilt_var.my) 
        G.hascoinbeenthrown = true
        G.haltevaleventsent = true
        G.haltingevaluation = true
        G.hascointriggered = nil
        G.hascoinbeenhit = nil
    end
    
    if G.haltevaleventsent == true then
        G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                blockable = false,
                blocking = true,
                delay = 0.1,
                    func = function()
                        local _shoulditbeblocked = false
                        if G.hascoinbeenthrown == true and G.hascointriggered == nil then
                            _shoulditbeblocked = true end
                        if G.coinout ~= nil then
                            _shoulditbeblocked = true end
                        if G.haltingevaluation ~= nil then
                            _shoulditbeblocked = true end
                        
                        if _shoulditbeblocked == true then
                            return false 
                        else

                            hook(e)
                            resetBlockerCoin()

                            G.hascoinbeenhit = 2
                            G.coinout = nil
                            G.haltingevaluation = nil
                            G.haltevaleventsent = nil
                            
                            

                            return true
                        end
                    end
                }))
    else
        --hook(e)
        --resetBlockerCoin()
    end
end

-- Hook so stuff is reset after finishing scoring
local hook = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)

    hook(e)
    G.coinout = nil
    G.hascoinbeenthrown = nil
    G.hascointriggered = nil
    G.hascoinbeenhit = nil
    G.haltevaleventsent = nil
    G.haltingevaluation = nil

end,


SMODS.Joker{
    key = 'ultrakill',
    loc_txt= {
        name = 'V1 - ULTRAKILL',
        text = { "Flings a {C:attention}coin{} before scoring",
                    "Shooting said {C:attention}coin grants you",
                    "{X:mult,C:white}X#1#{} Mult and {X:chips,C:white}X#2#{} Chips",
                    "and adds {X:dark_edition,C:white}X#3#{} to the next",
                    "{C:inactive}(Resets on miss)"}
    },
    atlas = 'ultrakill',
    rarity = 3,
    cost = 10,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 2, xchips = 2, additional = 0.5, hit = false, pleasetrigger = false, quips = {"DESTRUCTIVE", "CHAOTIC", "BRUTAL", "ANARCHIC", "SUPREME", "SSADISTIC", "SSSHITSTORM", "ULTRAKILL"}}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.xchips, center.ability.extra.additional, center.ability.extra.hit, center.ability.extra.pleasetrigger  }  }
	end,

    init = function(self)

        
	end,

    

    add_to_deck = function(self, card, from_debuff)
        play_sound("yahimod_ultrakill_landing")
    end,
    
    calculate = function(self, card, context)
        local _myid = getJokerID(card)
        if context.joker_main then
            if card.ability.extra.pleasetrigger == true then
                
                
                --G.hascointriggered = nil
                --G.hascoinbeenthrown = nil
                --card.ability.extra.pleasetrigger = false

                local howmanyincreases = (card.ability.extra.xmult - 2)/card.ability.extra.additional
                local quipindex = math.min(8,1+howmanyincreases)
                if (howmanyincreases + 1) >= 8 then check_for_unlock({ type = "ach_ultrakill" }) end


                return
                {
                    Xmult_mod = card.ability.extra.xmult,
                    x_chips = card.ability.extra.xchips,
                    message = card.ability.extra.quips[quipindex],
                }
            end
        end
        if context.post_joker then
            G.hascointriggered = nil
            G.hascoinbeenthrown = nil
            card.ability.extra.pleasetrigger = false
            end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- this will handle my effects


function throwCoin(posx,posy)
    play_sound("yahimod_coin")
    G.hascoinbeenhit = nil
    G.coinout = {}
    G.coinout.x = posx
    G.coinout.y = posy
    G.coinout.yvel = 1
    G.coinout.xvel = math.random(-5,5)
    G.coinout.clickabletimer = 0

    if G.SETTINGS.GAMESPEED <= 1 then
        G.coinout.yvel = 2
        G.coinout.clickabletimer = 72/G.SETTINGS.GAMESPEED
    end

    G.coinout.prevx = {}
    G.coinout.prevy = {}
end



-- Sound Investment
SMODS.Atlas{
    key = 'soundinvestment',
    path = 'soundinvestment.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'soundinvestment',
    loc_txt= {
        name = 'Sound Investment',
        text = { "This card's sell value",
                    "gets {X:dark_edition,C:white}randomized{} at the start",
                    "of every blind (Up to {C:attention}$12{})",}
    },
    atlas = 'soundinvestment',
    rarity = 1,
    cost = 3,
    pools = {["Yahimodaddition"] = true},


    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    calculate = function(self, card, context)
        if context.setting_blind then
            card.sell_cost = math.floor(math.random(1,12)^math.random(0.4,1))
            return {message = "$"..card.sell_cost.."!"}
        end

        if context.selling_self == true then
            if card.sell_cost >= 10 then check_for_unlock({ type = "ach_diamondhands" }) end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- bee
SMODS.Atlas{
    key = 'bee',
    path = 'bee.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'bee',
    loc_txt= {
        name = 'Bee',
        text = { "{C:red}+#1#{} Mult",}
    },
    atlas = 'bee',
    rarity = 1,
    cost = 3,
    pools = {["Yahimodaddition"] = true},
    config = { extra = {mult = 833}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 1, #G.beemoviescript do
                card.ability.extra.mult = 8.33
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    blocking = false,
                    delay = 0,
                    func = function()  
                        card_eval_status_text(card,'extra',nil,nil,nil,{message = G.beemoviescript[i]})
                        return true
                    end,
                    }))
            end
            G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    blocking = false,
                    delay = 0,
                    func = function()  
                        check_for_unlock({ type = "ach_why" })
                        return true
                    end,
                    }))
            return {mult_mod = card.ability.extra.mult}
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Evoker


SMODS.Sound({key = "evokerspawn", path = "evokerspawn.ogg",})

SMODS.Atlas{
    key = 'evoker',
    path = 'evoker.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'evoker',
    loc_txt= {
        name = 'Swapped Evoker',
        text = { "When you pick a blind,",
            "if you have {C:attention}3{} or more empty",
                    "{X:dark_edition,C:white}Joker  slots{}, spawns {C:attention}3{}",
                    "of the same joker."}
    },
    atlas = 'evoker',
    rarity = 2,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {damage = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.damage}  }
	end,

    calculate = function(self, card, context)
        if context.setting_blind and (#G.jokers.cards + 3) <= G.jokers.config.card_limit then
            

            cardfirst = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'evoker')
            cardfirst:add_to_deck()
            G.jokers:emplace(cardfirst)
            cardfirst:start_materialize()
            for i = 1, 2 do
                local card = create_card(cardfirst.config.center.key, G.jokers, nil, nil, nil, nil, cardfirst.config.center.key, 'evoker')
                card:add_to_deck()
                G.jokers:emplace(card)
                card:start_materialize()
            end
            play_sound("yahimod_evokerspawn")
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   


SMODS.Sound({key = "bitch", path = "bitch.ogg",})
SMODS.Sound({
    key = "music_bitch", 
    path = "music_bitch.ogg",
    pitch = 0.7,
    volume = 0.6,
    select_music_track = function()
        if jokerExists("j_yahimod_bitch") and G.GAME.blind and G.GAME.blind:get_type() == 'Boss' then
		    return true end
	end,
})

SMODS.Atlas{
    key = 'bitch',
    path = 'bitch.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'bitch',
    loc_txt= {
        name = 'Bitch In Tha Studio',
        text = { "Boss blind music",
                "is altered",
                    "{X:dark_edition,C:white}BITCH!{}",}
    },
    atlas = 'bitch',
    rarity = 2,
    cost = 4,
    pools = { ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},


    calculate = function(self, card, context)
        if context.setting_blind or context.joker_main then
            
            return {
                sound = "yahimod_bitch",
                message = "BITCH!",

            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   

G.FUNCS.homophobiacheck = function(card)
    if isEven(G.GAME.round+1) ~= true then -- it's +1 cuz the round number doesn't update until after we init this
        if G.hand.config.last_poll_size == nil then G.hand.config.last_poll_size = 8 end
        local _oldhandsize = G.hand.config.card_limit
        G.hand.config.last_poll_size = _oldhandsize
        card.ability.extra.oldhandsize = _oldhandsize
        card.ability.extra.handsizetriggered = true
        G.hand:change_size( card.ability.extra.handsize )
        play_sound('chips2')
    end
end

SMODS.Atlas{
    key = 'homophobia',
    path = 'homophobia.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'homophobia',
    loc_txt= {
        name = 'Cat With Homophobia',
        text = { "On odd rounds:",
                "{C:attention}+#1# Hand Size{}",
                "On even rounds:",
                "{C:blue}+#2# Hand{}",}
    },
    atlas = 'homophobia',
    rarity = 1,
    cost = 3,
    pools = { ["Cat"] = true , ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {handsize = 1, hand = 1, oldhandsize = -1, handsizetriggered = false}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.handsize, center.ability.extra.hand, center.ability.extra.oldhandsize, center.ability.extra.handsizetriggered}  }
	end,

    add_to_deck = function(self, card, from_debuff)
        

        


        if G.GAME.blind and string.len(G.GAME.blind.name) > 0 and self.debuff == false then G.FUNCS.homophobiacheck() end
    end,

    remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.handsizetriggered == true then
            G.hand:change_size(card.ability.extra.handsize * -1)
            card.ability.extra.handsizetriggered = false
        end
	end,

    calculate = function(self, card, context)
        if context.setting_blind and card.debuff == false then
            if isEven(G.GAME.round+1) then -- it's +1 cuz the round number doesn't update until after we init this
                card.ability.extra.oldhandsize = G.hand.config.card_limit
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hand
                play_sound('chips2')
                local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
                hand_UI.config.object:update()

                G.HUD:recalculate()
                    attention_text({
                    text = "+"..card.ability.extra.hand,
                    scale = 0.8, 
                    hold = 0.7,
                    cover = hand_UI.parent,
                    cover_colour = col,
                    align = 'cm',
                    })
                return {
                    message = "+"..card.ability.extra.hand.." Hand",
                }
            else
                G.FUNCS.homophobiacheck(card)
                return {
                    message = "+1 Hand Size",
                }
            end
        end
        if context.end_of_round and context.cardarea == G.jokers then
            if card.ability.extra.handsizetriggered == true then
                G.hand:change_size( card.ability.extra.handsize *-1 )
                card.ability.extra.handsizetriggered = false
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   


SMODS.Sound({key = "pluhsh", path = "pluhsh.ogg",})
SMODS.Sound({key = "pluh", path = "pluh.ogg",})

-- Good Kitty
SMODS.Atlas{
    key = 'goodkitty',
    path = 'goodkitty.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'goodkitty',
    loc_txt= {
        name = 'Good Kitty',
        text = { "This Joker gains {C:red}+#1#{} Mult if played",
                    "hand contains a {C:attention}flush{}",
                    "{C:inactive}(Currently {C:red}+#2#{}{C:inactive} Mult){}",
                    "PLUH!",}
    },
    atlas = 'goodkitty',
    rarity = 2,
    cost = 5,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {multamt = 2, multtotal = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.multamt, center.ability.extra.multtotal }  }
	end,
    
    calculate = function(self, card, context)
        
        if string.find(G.GAME.current_round.current_hand.handname,"Flush") then
            G.E_MANAGER:add_event(Event({
            trigger = 'before',
            blocking = false,
            blockable = false,
            delay = 0.8,
            func = function()
                G.GAME.current_round.current_hand.handname = string.gsub(G.GAME.current_round.current_hand.handname,"Flush","Plush")
                return true
            end
            }))
        end

        local _myid = getJokerID(card)
        if context.before and next(context.poker_hands['Flush']) then
            card.ability.extra.multtotal = card.ability.extra.multtotal + card.ability.extra.multamt
            return {
                message = "Pluh!",
                sound = "yahimod_pluhsh"
            }
        end
        if context.joker_main and card.ability.extra.multtotal > 0 then
            if string.find(G.GAME.current_round.current_hand.handname,"Straight Plush") then check_for_unlock({ type = "ach_straightplush" }) end
            return {
                mult = card.ability.extra.multtotal,
                sound = "yahimod_pluh",
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Effoc
SMODS.Atlas{
    key = 'effoc',
    path = 'effoc.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'effoc',
    loc_txt= {
        name = 'Effoc',
        text = { "{C:blue}+#1#{} Chips if played {C:attention}Straight{}",
                    "is in reverse order",
                    "{C:inactive}(ex: {C:attention}2 3 4 5 6{C:inactive}){}",}
    },
    atlas = 'effoc',
    rarity = 1,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chipamt = 40, active = false}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chipamt }  }
	end,
    
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands['Straight']) then

            local _reverseorder = true
            local _prevrank = 0
            for i = 1, #G.play.cards do
                local _rank = G.play.cards[i]:get_id()
                if _rank < _prevrank then
                    _reverseorder = false
                end
                _prevrank = _rank
            end
            if _reverseorder == true then
                return {
                    message = "Which is funny,",
                    chip_mod = card.ability.extra.chipamt,
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}
 
-- Gifted Sub
SMODS.Atlas{
    key = 'giftedsub',
    path = 'giftedsub.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'giftedsub',
    loc_txt= {
        name = 'Gifted Sub',
        text = { "If you have more than {C:attention}$#1#{},",
                    "retriggers all played cards once",
                    "for every {C:attention}$#1#{} you own",
                    "and subtracts {C:attention}$#1#",
                    "for every retrigger",}
    },
    atlas = 'giftedsub',
    rarity = 3,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},
    config = { extra = {retriggercost = 5, retriggers_stored = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.retriggercost, center.ability.extra.retriggers_stored }  }
	end,
    
    calculate = function(self, card, context)
        if G.GAME.dollars >= card.ability.extra.retriggercost then
            if context.before then
                local _rtamt = math.floor(G.GAME.dollars/card.ability.extra.retriggercost)
                card.ability.extra.retriggers_stored = _rtamt
                --print(_rtamt)

                    ease_dollars(card.ability.extra.retriggercost*_rtamt*-1)
                    card:juice_up()
                    return {
                        message = "-$".. (card.ability.extra.retriggercost*_rtamt)
                    }
            end
                
            if context.repetition and context.cardarea == G.play then
                return {
                        repetitions = card.ability.extra.retriggers_stored,
                    }
            end
        end

        if context.post_joker or context.setting_blind then
            card.ability.extra.retriggers_stored = 0
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Gifted Sub
SMODS.Atlas{
    key = 'schmeebchair',
    path = 'schmeebchair.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'schmeebchair',
    loc_txt= {
        name = 'Worn Down Gaming Chair',
        text = { "{C:blue}+#1#{} chips and {C:red}+#2#{} Mult",
                    "{C:green}#3# in 4{} chance to break down",
                    "when blind is selected",}
    },
    atlas = 'schmeebchair',
    rarity = 1,
    cost = 2,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 10, mult = 2, chance = 4}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.mult, G.GAME.probabilities.normal }  }
	end,
    
    calculate = function(self, card, context)
        if context.setting_blind then
            if pseudorandom('schmeebchair') < (G.GAME.probabilities.normal / card.ability.extra.chance) then
                explodeCard(card)
                if G.GAME.round_resets.ante <= 1 then check_for_unlock({ type = "ach_schmeebchairgone" }) end
                
            end
        end
        if context.joker_main then
            return {
                message = "Schmeeb-tastic!",
                mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Parkour Civilization
SMODS.Atlas{
    key = 'parkourciv',
    path = 'parkourciv.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'parkourciv',
    loc_txt= {
        name = 'Parkour Civilization',
        text = { "Every {C:attention}Oak Log{} you own",
                "gives {X:mult,C:white}X#1#{} Mult",}
    },
    atlas = 'parkourciv',
    rarity = 1,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 1.5}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,
    
    calculate = function(self, card, context)
        if context.other_joker then
            local _logcount = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == 'j_yahimod_oaklog' then
                _logcount = _logcount + 1 
                end
            end
            if _logcount >= 4 then check_for_unlock({ type = "ach_parkourpro" }) end
            if _logcount >= 12 then check_for_unlock({ type = "ach_parkourmaster" }) end

            
            if context.other_joker.ability.name == 'j_yahimod_oaklog' then
                G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_joker:juice_up(0.5, 0.5)
                    return true
                end
            })) 
            return {
                message = "X"..card.ability.extra.mult,
                Xmult_mod = card.ability.extra.mult,
            }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Steamroller
SMODS.Atlas{
    key = 'steamroller',
    path = 'steamroller.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'steamroller',
    loc_txt= {
        name = 'Steamroller',
        text = { "Doubles {C:attention}Blind{} {C:attention}payout{} if",
                "{C:attention}Blind{} was won in {C:attention}one hand{}",}
    },
    atlas = 'steamroller',
    rarity = 2,
    cost = 8,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {mult = 1.5}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,

    calc_dollar_bonus = function(self,card)
        if G.GAME.current_round.hands_played == 1 then
        return G.GAME.blind.dollars
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Most Replayed
SMODS.Atlas{
    key = 'mostreplayed',
    path = 'mostreplayed.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'mostreplayed',
    loc_txt= {
        name = 'Most Replayed',
        text = { "Skipping a {C:attention}Blind{}",
                "grants you {C:attention}$#1#{}",}
    },
    atlas = 'mostreplayed',
    rarity = 1,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {dollar = 5}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.dollar }  }
	end,

    calculate = function(self, card, context)
        if context.skip_blind then
            return { 
                dollars = card.ability.extra.dollar,
                message = "Skipped!",
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}


-- Conveniently Shaped Joker
SMODS.Atlas{
    key = 'convenientlyshapedlamp',
    path = 'convenientlyshapedlamp.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'convenientlyshapedlamp',
    loc_txt= {
        name = 'Conveniently Shaped Lamp',
        text = { "{X:mult,C:white}X#1#{} Mult for",
                "every filled joker slot",}
    },
    atlas = 'convenientlyshapedlamp',
    rarity = 2,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 0.5}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local _mult = #G.jokers.cards * card.ability.extra.mult
            return {
                Xmult_mod = _mult,
                message = "X".._mult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Moroccan Internet
SMODS.Atlas{
    key = 'moroccaninternet',
    path = 'moroccaninternet.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'moroccaninternet',
    loc_txt= {
        name = 'Moroccan Internet',
        text = { "Downloading {X:mult,C:white}X#1#{} Mult,",
                "please wait...",
                "{C:inactive}(#2#% complete)",}
    },
    atlas = 'moroccaninternet',
    rarity = 1,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 3, progress = 0, progresstotal = 100}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.progress, center.ability.extra.progresstotal }  }
	end,
    
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.progress >= card.ability.extra.progresstotal then
            return {
                Xmult_mod = card.ability.extra.mult,
                message = "X"..card.ability.extra.mult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- So Retro
SMODS.Atlas{
    key = 'soretro',
    path = 'soretro.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'soretro',
    loc_txt= {
        name = 'So Retro',
        text = { "{X:mult,C:white}X#1#{} Mult",
                "Mult increases the lower",
                "your game resolution is",}
    },
    atlas = 'soretro',
    rarity = 3,
    cost = 4,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 1}},

    update = function(self, card, front)
        local _xscale = love.graphics.getWidth()/1920
        local _yscale = love.graphics.getHeight()/1080
        local _factor = 1/(( _xscale + _yscale ) / 2)
        if love.graphics.getWidth() < 256 and love.graphics.getHeight() < 192 then check_for_unlock({ type = "ach_retro" }) end

        card.ability.extra.mult = math.floor(_factor*100)/100

    end,

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,
    
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.mult,
                message = "X"..card.ability.extra.mult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- teto pear
SMODS.Atlas{
    key = 'tetopear',
    path = 'tetopear.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'tetopear',
    loc_txt= {
        name = 'Teto Pear',
        text = { "This Joker gains {C:red}+#1#{} Mult if played",
                    "hand contains a {C:attention}Pair{}",
                    "{C:inactive}(Currently {C:red}+#2#{}{C:inactive} Mult){}",}
    },
    atlas = 'tetopear',
    rarity = 1,
    cost = 4,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {multamt = 1, multtotal = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.multamt, center.ability.extra.multtotal }  }
	end,
    
    calculate = function(self, card, context)
        if string.find(G.GAME.current_round.current_hand.handname,"Pair") then
                G.showtetopear = true
        else
            G.showtetopear = nil
        end

        local _myid = getJokerID(card)
        if context.before and next(context.poker_hands['Pair']) then
            card.ability.extra.multtotal = card.ability.extra.multtotal + card.ability.extra.multamt
            return {
                message = "Teto!",
            }
        end
        if context.joker_main and card.ability.extra.multtotal > 0 then
            return {
                mult = card.ability.extra.multtotal,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- mimearon
SMODS.Atlas{
    key = 'mimearon',
    path = 'mimearon.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'mimearon',
    loc_txt= {
        name = 'Mimaron',
        text = { "All {C:attention}Red Seal Steel Kings{}",
                    "held in hand grant {X:mult,C:white}X#1#{} Mult",}
    },
    atlas = 'mimearon',
    rarity = 3,
    cost = 10,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {multamt = 1.5^4}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.multamt}  }
	end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 1, #G.hand.cards do
                local _card = G.hand.cards[i]
                if _card.seal == "Red" and _card:get_id() == 13 and SMODS.has_enhancement(_card, 'm_steel') then 
                    return {
                        Xmult_mod = card.ability.extra.multamt,
                        message = "X" .. card.ability.extra.multamt
                    }
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Sand
SMODS.Atlas{
    key = 'sand',
    path = 'sand.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'sand',
    loc_txt= {
        name = 'Sand',
        text = { "Earn {C:attention}$#1#{} at round end",
                    "reduces by",
                    "{C:attention}$#2#{} every round",},},
    atlas = 'sand',
    rarity = 1,
    cost = 3,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {dollar = 5, dollarloss = 1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.dollar, center.ability.extra.dollarloss }  }
	end,

    calc_dollar_bonus = function(self,card)
        return (card.ability.extra.dollar + 1)
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            if card.ability.extra.dollar > (card.ability.extra.dollarloss*2) then
                card.ability.extra.dollar = (card.ability.extra.dollar - card.ability.extra.dollarloss)
                return{message = "Yum!",}
            else
                card:start_dissolve({G.C.RED})
                check_for_unlock({ type = "ach_yum" })
                return{
                    message = "Eaten!",
                    sound = "yahimod_eat",
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Jerma
SMODS.Atlas{
    key = 'thickjerma',
    path = 'thickjerma.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'thickjerma',
    loc_txt= {
        name = 'Happy Thanksgiving',
        text = { "This Joker gains {C:red}+#1#{} Mult if played",
                    "hand contains a {C:attention}Jerma{}",
                    "{C:inactive}(Currently {C:red}+#2#{}{C:inactive} Mult){}",
                    "Hope you had a great turkey day!",}
    },
    atlas = 'thickjerma',
    rarity = 1,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {multamt = 3, multtotal = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.multamt, center.ability.extra.multtotal }  }
	end,
    
    calculate = function(self, card, context)
        if context.before and next(context.poker_hands['yahimod_pkr_jerma']) then
            card.ability.extra.multtotal = card.ability.extra.multtotal + card.ability.extra.multamt
            return {
                message = "Upgrade!",
                sound = "yahimod_jermanoise",
            }
        end
        if context.joker_main and card.ability.extra.multtotal > 0 then
            return {
                message = "+"..card.ability.extra.multtotal,
                mult = card.ability.extra.multtotal,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- moon
SMODS.Atlas{
    key = 'moon',
    path = 'moon.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'moon',
    loc_txt= {
        name = 'Moon',
        text = { "If your hand contains {C:attention}5 cards,",
                    "changes the {C:attention}suit{} of the {C:red}last",
                    "card to that of the {C:green}first{} card",
                    "{C:inactive}(Does not change scoring)",}
    },
    atlas = 'moon',
    rarity = 2,
    cost = 5,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {multamt = 2, multtotal = 0}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "kerouz" }}
	end,
    
    calculate = function(self, card, context)
        if context.before and #G.play.cards == 5 then
            SMODS.change_base(G.play.cards[5], G.play.cards[1].base.suit)
            return {
                message = "Meow!",
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- jojo
SMODS.Atlas{
    key = 'jojo',
    path = 'jojo.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'jojo',
    loc_txt= {
        name = 'JoJoker',
        text = { "Your next draw is...",
                    "{C:attention}#1#",
                    "{C:attention}#2#",
                    "{C:attention}#3#",
                    "{C:attention}#4#",
                    "{C:attention}#5#",
                "TOYU?!",}
    },
    atlas = 'jojo',
    rarity = 1,
    cost = 6,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {nexthand = {"...","...","...","...","..."}}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.nexthand[1],center.ability.extra.nexthand[2],center.ability.extra.nexthand[3],center.ability.extra.nexthand[4],center.ability.extra.nexthand[5] }  }
	end,

    update = function(self, card, front)
        if jokerExists("j_yahimod_jojo") then
            if G.deck and #G.deck.cards >= 1 then
                for i = 1, math.min(5,#G.deck.cards) do
                    local _index = (#G.deck.cards - i + 1)
                    card.ability.extra.nexthand[i] = G.deck.cards[_index].base.name
                end
            end
        else
            for i = 1, 5 do
                card.ability.extra.nexthand[i] = "..."
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Completionist
SMODS.Atlas{
    key = 'completionist',
    path = 'completionist.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'completionist',
    loc_txt= {
        name = 'The Completionist',
        text = { "{X:mult,C:white}X#2#{} Mult",
                    "for every {C:attention}achievement{}",
                    "obtained",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"}
    },
    atlas = 'completionist',
    rarity = 3,
    cost = 10,
    pools = { ["Yahimodaddition"] = true },
    
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 1, xmultadd = 0.15}},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.xmultadd}  }
	end,

    update = function(self, card, dt)
        if G.jokers then
            local achamount = calculate_achievements() or 0
            Xmult_mod = (card.ability.extra.xmultadd * achamount)
            card.ability.extra.xmult = 1+Xmult_mod
        end
    end,

    calculate = function(self, card, context)
    if context.joker_main then
        return {
            color = G.C.RED,
            message = "x".. card.ability.extra.xmult,
            Xmult_mod = card.ability.extra.xmult
        }
        end
    end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

-- Burrito
SMODS.Atlas{
    key = 'burrito',
    path = 'burrito.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'burrito',
    loc_txt= {
        name = 'Burrito',
        text = { "{X:mult,C:white}X#1#{} Mult",
                    "then {C:red}+#2#{} Mult",
                    "then {{C:blue}+#3#{} Chips",
                    "{C:inactive}(Eaten in {X:attention,C:white}#4#{} {C:inactive}Rounds)"}
    },
    atlas = 'burrito',
    rarity = 2,
    cost = 5,
    pools = { ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 2, mult = 16,  chips = 100, rounds = 3}},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.mult, center.ability.extra.chips, center.ability.extra.rounds}  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        if card.ability.extra.rounds == 3 then
        return {
            color = G.C.RED,
            message = "x".. card.ability.extra.xmult,
            Xmult_mod = card.ability.extra.xmult
        } end
        if card.ability.extra.rounds == 2 then
        return {
            color = G.C.RED,
            message = "+".. card.ability.extra.mult,
            mult_mod = card.ability.extra.mult
        } end
        if card.ability.extra.rounds == 1 then
        return {
            color = G.C.BLUE,
            message = "+".. card.ability.extra.chips,
            chip_mod = card.ability.extra.chips
        } end
        end
    if context.end_of_round and context.main_eval and not context.blueprint then
        if card.ability.extra.rounds > 1 then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            return {
                message = "Yum!"
            }
        else 
            explodeCard(card)
            return {
                message = "Eaten!"
            }
        end
    end
end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

-- Beanemonial Dagger
SMODS.Atlas{
    key = 'beandagger',
    path = 'beandagger.png',
    px = 71,
    py = 94,
}

SMODS.Joker{
    key = 'beandagger',
    loc_txt= {
        name = 'Beanemonial Dagger',
        text = { "{C:attention}+#1#{} Hand Size",
                    "Loses {C:attention}1{} Hand Size every round",
                    "Adds the Joker to its rights' rarity",
                    "to hand size and destroys it"}
    },
    atlas = 'beandagger',
    rarity = 3,
    cost = 10,
    pools = { ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {slots = 5}},
    
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.slots}  }
	end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size( card.ability.extra.slots )
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.slots * -1)
    end,

    calculate = function(self, card, context)
        local _myid = getJokerID(card)
    if context.setting_blind and card.debuff == false  then
        if G.jokers and G.jokers.cards[_myid + 1] then
            local _victim = G.jokers.cards[_myid + 1]
            card.ability.extra.slots = card.ability.extra.slots + _victim.config.center.rarity
            _victim.getting_sliced = true
            SMODS.destroy_cards(_victim, nil, nil, true)
            G.hand:change_size(_victim.config.center.rarity)
            play_sound("slice1")
            return {
                message = "+" .. _victim.config.center.rarity
            }
        end

        
    end

    if context.end_of_round and context.main_eval and not context.blueprint then
        if card.ability.extra.slots > 1 then
            card.ability.extra.slots = card.ability.extra.slots - 1
            G.hand:change_size(-1)
            return {
                message = "Yum!"
            }
        else 
            explodeCard(card)
            return {
                message = "Eaten!"
            }
        end
    end
end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

-- Nathan
SMODS.Atlas{
    key = 'nathanjoker',
    path = 'nathanjoker.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'nathanjoker',
    loc_txt= {
        name = 'Nathan',
        text = { "Nathan?",
                    "{C:attention}Where are you!{}",}
    },
    atlas = 'nathanjoker',
    rarity = 3,
    cost = 1,
    pools = {["Yahimodaddition"] = true},

    pixel_size = { w = 71 , h = 96 },
    frame = 0,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 1, mult = 1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "Nathan?",
			}
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Foot
SMODS.Atlas{
    key = 'foot',
    path = 'foot.png',
    px = 256,
    py = 256,
}

SMODS.Joker{
    key = 'foot',
    loc_txt= {
        name = 'Foot',
        text = { "{C:attention}Seriously,what did you expect?{}",}
    },
    atlas = 'foot',
    rarity = 4,
    cost = 10,
    pools = { ["Yahimodaddition"] = true},

    display_size = { w = 95 * 2.8, h = 95*1.8 },
	pixel_size = { w = 73, h = 73 },
    frame = 0,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 1, mult = 1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "Foot",
                play_sound("yahimod_splat")
			}
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Showmen
SMODS.Atlas{
    key = 'showmen',
    path = 'showmen.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'showmen',
    loc_txt= {
        name = 'Showmen',
        text = { "{C:attention}Men{}",
                    "may appear",}
    },
    atlas = 'showmen',
    rarity = 2,
    cost = 5,
    pools = {["Yahimodaddition"] = true},

    pixel_size = { w = 71 , h = 96 },
    frame = 0,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 1, mult = 1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.mult }  }
	end,

    add_to_deck = function(self, card, from_debuff)
        os.execute("start https://images.search.yahoo.com/search/images;_ylt=AwrNPiJ4lQdqhK8abVKLuLkF;_ylu=c2VjA3NlYXJjaARzbGsDYnV0dG9u;_ylc=X0kDeVBnTjJURXlOeTRsRF9XM2FDXzNmUWRjTkRFdU1RQUFBQUE0Z3pnSgRfUwM5NjA1NzQ4MwRfcgMyBGNzcmNwdmlkA3lQZ04yVEV5Tnk0bERfVzNhQ18zZlFkY05ERXVNUUFBQUFBNGd6Z0oEZnIDBGZyMgNzYi10b3AEZ3ByaWQDBG5fcnNsdAMwBG5fc3VnZwMwBG9yaWdpbgNpbWFnZXMuc2VhcmNoLnlhaG9vLmNvbQRwb3MDMARwcXN0cgMEcHFzdHJsAzAEcXN0cmwDMwRxdWVyeQNtZW4EdF9zdG1wAzE3Nzg4ODE4ODMEdnRlc3RpZAM-?p=men&ei=&iscqry=&fr=&fr2=sb-top")
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}













function playEffect(effect,posx,posy)
    if effect == "explosion" then
        play_sound("yahimod_snd_explosion")
        neweffect = 
            {
            name = "explosion",
            duration = 100,

            frame = 1,
            maxframe = 17,
            fps = 20,
            tfps = 0, -- ticks per frame per second


            xpos = posx,
            ypos = posy,
            xvel = 0,
            yvel = 0,
            }end
        
    if effect == "parry" then
        play_sound("yahimod_parry")
        neweffect = 
            {
            name = "parry",
            duration = 77+20,

            frame = 1,
            maxframe = 47,
            fps = 60,
            tfps = 0, -- ticks per frame per second


            xpos = posx,
            ypos = posy,
            xvel = 0,
            yvel = 0,
            }end
    if effect == "crack" then
        neweffect = 
            {
            name = "crack",
            duration = 200,

            frame = 1,
            maxframe = 1,
            fps = 0,
            tfps = 0, -- ticks per frame per second


            xpos = posx,
            ypos = posy,
            xvel = 0,
            yvel = 0,
            }end
    if effect == "cardexplosion" then
        neweffect = 
            {
            name = "crack",
            duration = 200,

            frame = 1,
            maxframe = 1,
            fps = 0,
            tfps = 0, -- ticks per frame per second


            xpos = posx,
            ypos = posy,
            xvel = 0,
            yvel = 0,
            }end
    if effect == "errormessage" then
        local _pickedframe = math.random(1,3)
        neweffect = 
            {
            name = "errormessage",
            duration = 200,


            
            frame = _pickedframe,
            maxframe = _pickedframe,
            fps = 0,
            tfps = 0, -- ticks per frame per second


            xpos = posx,
            ypos = posy,
            xvel = 0,
            yvel = 0,
            }end
    table.insert(G.effectmanager,{neweffect})
end

local yahimodkeypress = love.keypressed
function love.keypressed(key)
    --print(key)
    if G.dino then
        if key == "space" or key == "up" or key == "w" then
            dinoJump()
        end
    end

    if key == "y" and G.jokers then
        local isdeerhere = false
        local deerid = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == 'j_yahimod_deer' then
                isdeerhere = true
                deerid = i
            end
        end
        if (isdeerhere == true) then
            if #G.jokers.cards < G.jokers.config.card_limit then
                if pseudorandom('deer') < (G.GAME.probabilities.normal / 500) then
                    card_eval_status_text(G.jokers.cards[deerid],'extra',nil,nil,nil,{message = "Wait a minute."})
                    check_for_unlock({ type = "ach_waitaminute" })
                    addHorse()
                else
                    local card = create_card('Joker', G.Jokers, nil, nil, nil, nil, 'j_yahimod_deer', 'deer')
                    card.sell_cost = 0
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    play_sound("timpani")
                end
            else
                card_eval_status_text(G.jokers.cards[deerid],'extra',nil,nil,nil,{message = localize('k_no_room_ex')})
            end
        end
    end
    if key == "return" and G.CONTROLLER.hovering.target.config.center ~= nil then
        local _element = G.CONTROLLER.hovering.target
        local _set = false
        if (_element.config.center.set == "Joker") then 
            _set = true 
            end
        if (_element.config.center.set == "Tarot" ) then 
            _set = true
            end
        if (_element.config.center.set == "Planet") then 
            _set = true
            end
        if (_element.config.center.set == "Spectral") then 
            _set = true
            end
        
        if (G.opentolan_canspawn == true) and _element and _set == true then
            local card = create_card('',G.Jokers, nil, nil, nil, nil, _element.config.center.key, 'opentolan')
            card.sell_cost = 0
            card:add_to_deck()
            G.jokers:emplace(card)
            G.opentolan_phase_ex = 2
            G.opentolan_phase = Yahimod.ticks
            play_sound("timpani")
            G.opentolan_canspawn = false
            
        end
    end
    return (yahimodkeypress(key))
end



local ctrup = Controller.update
function Controller:update(dt)
    ctrup(self,dt)

end

function jokerExists(abilityname)
    local _check = false
    if G.jokers and G.jokers.cards then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == abilityname then _check = true end
            --if G.jokers.cards[i].ability.name == 'j_yahimod_subwaysurfers' then _check = true end
        end
    end
    return _check
end



function decrementingTickEvent(type,tick)
    if type == "G.showlaughingcat" then 
        if tick == 547 then 
            play_sound("yahimod_catlaughing") 
            addHorse() 
            
        end
    end

    if type == "G.showcrash" then
        if tick == 1 then G.showcrash = nil SMODS.restart_game() 
        else
            if math.fmod(tick,5) == 0 then
                local _xpos = math.random(1,love.graphics.getWidth())
                local _ypos = math.random(1,love.graphics.getHeight())
                playEffect("errormessage",_xpos,_ypos)
                
            end
        end
    end

    --horse swaps play and discard
    if type == "swapbuttons" and math.fmod(Yahimod.ticks,100) == 0 and math.random(1,6) == 1 then
        if G.SETTINGS.play_button_pos_backup == nil then G.SETTINGS.play_button_pos_backup = G.SETTINGS.play_button_pos end

        local _oldbutton = G.SETTINGS.play_button_pos
        if _oldbutton == 1 then G.SETTINGS.play_button_pos = 2 else G.SETTINGS.play_button_pos = 1 end
        if G.buttons then
            G.buttons:remove()
            G.buttons = UIBox{
            definition = create_UIBox_buttons(),
          config = {align="bm", offset = {x=0,y=0.3},major = G.hand, bond = 'Weak'}
      }
        end
    end

    --speedrun boss blind
    if type == "G.clockticking" and math.fmod(Yahimod.ticks,100) == 0 then
        if G.clockticking >= 1 then
            G.clockticking = G.clockticking - 1
            play_sound("generic1",2,0.5)
        end
    end

    --event manager
    if type == "G.effectmanager" then
        for i = 1, #G.effectmanager do
            if G.effectmanager[i] and G.effectmanager[i][1] then
                if G.effectmanager[i][1].duration ~= nil and G.effectmanager[i][1].duration >= -1 then
                    _eff = G.effectmanager[i][1]

                    _eff.tfps = _eff.tfps + 1
                    _eff.duration = _eff.duration - 1
                    
                    if _eff.tfps > 100/_eff.fps and _eff.fps ~= 0 then
                        _eff.frame = _eff.frame + 1
                        _eff.tfps = 0

                        if G.effectmanager[i][1].name == "parry" and G.effectmanager[i][1].duration > 77 then 
                            _eff.frame = 1 end     
                    end
                    if _eff.frame > _eff.maxframe then
                        _eff.frame = 1
                    end
            
        
                

                elseif G.effectmanager[i][1].duration ~= nil and G.effectmanager[i][1].duration <= 0 then
                    G.effectmanager[i] = nil
                end
            end
        end
    end

    --ultrakill coin
    if type == "G.coinout" and math.fmod(Yahimod.ticks,2) == 0 then

        -- vibe stuff
        if G.coinout.clickabletimer > 0 then 
           G.coinout.clickabletimer = G.coinout.clickabletimer - 1
        end

        if #G.coinout.prevx > 5 then 
            table.remove(G.coinout.prevx,1)
            table.remove(G.coinout.prevy,1)
        end
        table.insert(G.coinout.prevx,G.coinout.x)
        table.insert(G.coinout.prevy,G.coinout.y)
        

        
        
        if G.SETTINGS.GAMESPEED <= 1 then
            G.coinout.x = G.coinout.x + G.coinout.xvel*G.SETTINGS.GAMESPEED*0.5
            G.coinout.y = G.coinout.y + G.coinout.yvel*G.SETTINGS.GAMESPEED*0.5
        else
            G.coinout.x = G.coinout.x + G.coinout.xvel
            G.coinout.y = G.coinout.y + G.coinout.yvel
        end
        



        if G.coinout.yvel < 45 and math.fmod(Yahimod.ticks,3) == 0 then
            if G.SETTINGS.GAMESPEED <= 1 then
                G.coinout.yvel = G.coinout.yvel + G.SETTINGS.GAMESPEED/2
            else
                G.coinout.yvel = G.coinout.yvel + 1
            end
        end

        if G.coinout.y > love.graphics.getHeight()*1.2 then
            missCoin()
        end
    end

    if type == "j_yahimod_subwaysurfers" then
        if math.fmod(Yahimod.ticks,12) == 0 then
            local _subcardcenter = G.P_CENTERS.j_yahimod_subwaysurfers
            _subcardcenter.frame = _subcardcenter.frame + 1
            local _fr = _subcardcenter.frame
            _subcardcenter.pos.x = math.fmod(_fr,16)
            _subcardcenter.pos.y = math.floor(_fr/16)
            if _subcardcenter.frame > 253 then _subcardcenter.frame = 0 end
        end
    end

    if type == "j_yahimod_nathanjoker" then
        if math.fmod(Yahimod.ticks,6) == 0 then
            local _subcardcenter = G.P_CENTERS.j_yahimod_nathanjoker
            _subcardcenter.frame = _subcardcenter.frame + 1
            local _fr = _subcardcenter.frame
            _subcardcenter.pos.x = math.fmod(_fr,8)
            _subcardcenter.pos.y = math.floor(_fr/8)
            if _subcardcenter.frame > 58 then _subcardcenter.frame = 0 end
        end
    end

    if type == "sansbossblind" then
        if math.fmod(Yahimod.ticks,50) == 0 then
            G.GAME.chips = G.GAME.chips - G.GAME.blind.chips*0.01
        end
    end

    if type == "gambling" then
        if math.fmod(Yahimod.ticks,100) == 0 then
            G.hand:unhighlight_all()
            local _cardlist = {}

            for i = 1, #G.hand.cards do
                G.hand.cards[i].ability.forced_selection = false
                G.hand:remove_from_highlighted(G.hand.cards[i])
                if math.random(1,2) == 1 then
                    table.insert(_cardlist,G.hand.cards[i])
                end
            end

            while #_cardlist > 5 do
                table.remove(_cardlist,math.random(1,#_cardlist))
            end

            for i = 1, #_cardlist do
                _cardlist[i].ability.forced_selection = true
                G.hand:add_to_highlighted(_cardlist[i])
                
            end
        end
    end

    if type == "j_yahimod_moroccaninternet" then
        if math.fmod(Yahimod.ticks,4) == 0 and math.random(1,115) == 1 then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == "j_yahimod_moroccaninternet" and G.jokers.cards[i].ability.extra.progress < G.jokers.cards[i].ability.extra.progresstotal then
                    G.jokers.cards[i].ability.extra.progress = G.jokers.cards[i].ability.extra.progress + 1
                end
            end
        end
    end

end


function crashGame()
    play_sound("yahimod_crash")
    G.showcrash = 300
end

function explodeCard(card)
    play_sound("yahimod_glassbreak")
    playEffect("explosion",card.tilt_var.mx,card.tilt_var.my)
    SMODS.destroy_cards(card, nil, nil, true)
    card = nil
end

-- get name of joker
function getJokerName(card)
    local _cardname = card.config.center.name
    if string.find(_cardname,"j_") then _cardname = card.config.center.loc_txt.name end
    return _cardname
end

-- get id of joker
function getJokerID(card)
    if G.jokers then
        local _selfid = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then _selfid = i end
        end
        return _selfid
    end
end



local upd = Game.update
function Game:update(dt)
    upd(self, dt)

    -- tick based events
    if Yahimod.ticks == nil then Yahimod.ticks = 0 end
    if Yahimod.dtcounter == nil then Yahimod.dtcounter = 0 end
    Yahimod.dtcounter = Yahimod.dtcounter+dt
    Yahimod.dt = dt

    while Yahimod.dtcounter >= 0.010 do
        Yahimod.ticks = Yahimod.ticks + 1
        Yahimod.dtcounter = Yahimod.dtcounter - 0.010

        if G.dino then dinoTick() end

        -- achievement check naneinf
        if G.GAME.chips and tNum(G.GAME.chips) > tNum(9e307) then check_for_unlock({ type = "ach_okyouwin" }) end

        -- achievement check cantaloupefish
        if G.showfish and G.showcantaloupe and G.showfish > 0 and G.showcantaloupe > 0 then check_for_unlock({ type = "ach_cantaloupefish" }) end

        if jokerExists("j_yahimod_subwaysurfers") then decrementingTickEvent("j_yahimod_subwaysurfers",0) end
        if jokerExists("j_yahimod_nathanjoker") then decrementingTickEvent("j_yahimod_nathanjoker",0) end
        if jokerExists("j_yahimod_moroccaninternet") then decrementingTickEvent("j_yahimod_moroccaninternet",0) end

        if G.coinout ~= nil then decrementingTickEvent("G.coinout",0) end

        if G.GAME.blind and not G.GAME.blind.disabled then
            if G.GAME.blind.name == 'boss_speedrun' then decrementingTickEvent("G.clockticking",0) end
            if G.GAME.blind.name == 'boss_horse' or G.GAME.blind.name == 'boss_mechahorse' then decrementingTickEvent("swapbuttons") end
            if G.GAME.blind.name == 'boss_sans' then decrementingTickEvent("sansbossblind") end
            if G.GAME.blind.name == 'boss_gambling' then decrementingTickEvent("gambling") end
        end
        

        if G.showfish and G.showfish > 0 then 
            G.showfish = G.showfish - 1 
            decrementingTickEvent("G.showfish",G.showfish)
        end

        if G.showlaughingcat and G.showlaughingcat > 0 then 
            G.showlaughingcat = G.showlaughingcat - 1 
            decrementingTickEvent("G.showlaughingcat",G.showlaughingcat)
        end

        if G.showcrash and G.showcrash > 0 then 
            G.showcrash = G.showcrash - 1 
            decrementingTickEvent("G.showcrash",G.showcrash)
        end

        if G.showcantaloupe and G.showcantaloupe > 0 then G.showcantaloupe = G.showcantaloupe - 1 end

        if #G.effectmanager > 0 then decrementingTickEvent("G.effectmanager",0) end

    end



    -- tick based events
    if math.fmod(Yahimod.ticks,8) == 0 then
        if G.GAME.blind and G.GAME.blind.chip_text and tonumber(G.GAME.blind.chip_text) ~= tonumber(G.GAME.blind.chips) then
            local _chipvalue = number_format(tostring(G.GAME.blind.chips):gsub(",",""))
            local _chiptext = number_format(tostring(G.GAME.blind.chip_text):gsub(",",""))

            local _diff = ((_chipvalue) - (_chiptext))
            G.GAME.blind.chip_text = math.floor(_chiptext + _diff/20)

            if math.abs(_diff) > _chipvalue*0.05 then play_sound("generic1", math.random(1.5,2.0), 0.35) end

            if math.abs(_diff) < _chipvalue*0.02 then G.GAME.blind.chip_text = _chipvalue end
                
        end
    end
    
    
    if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.in_blind and G.GAME.blind.name == 'boss_vibe' then

        local _gspeed = 0.25
        if jokerExists("j_yahimod_ultrakill") then
            _gspeed = 0.25
        end 

        G.SETTINGS.GAMESPEED = _gspeed
        else
        if G.GAME.normalgamespeed == nil and G.SETTINGS.GAMESPEED ~= _gspeed then G.GAME.normalgamespeed = G.SETTINGS.GAMESPEED end
    end
    


    if G.jokers then
        -- yahijoker presence
        if jokerExists("j_yahimod_yahiamice") then
            for i = 1, #G.shop_jokers.cards[i] do
                local _xid = 1 + math.fmod(i-1,3)
                local _yid = math.floor(i-1/3)-1
                if i < 4 and i > 6 then
                    --print(i)
                    G.shop_jokers.cards[i].CT.x = G.shop_jokers.cards[_xid].CT.x
                    G.shop_jokers.cards[i].CT.y = G.shop_jokers.cards[4].CT.y - _yid * G.shop_jokers.cards[4].CT.h
                end
            end
        end

            

        for i = 1, #G.jokers.cards do
            -- LC Sliced check
            if G.jokers.cards[i].getting_sliced == true and not G.hasajokerbeendestroyedthistick == true then
                G.hasajokerbeendestroyedthistick = true
                return {
                    --print("found a joker being destroyed! adding Mult")
                }
            end
            -- horse needs eternal sticker
            if G.jokers.cards[i].ability.name == 'j_yahimod_horsewalksin' then
                local _horse = G.jokers.cards[i]
                local _horsec = G.P_CENTERS.j_yahimod_horsewalksin
                if _horse.ability.extra.round < _horse.ability.extra.maxround and _horse.ability.eternal ~= true then
                    _horse.ability.eternal = true
                end
            end
            -- subway surfers increase
            if G.jokers.cards[i].ability.name == 'j_yahimod_subwaysurfers' then
                local _subcard = G.jokers.cards[i]

                if math.random(1,80) == 1 then 
                    G.jokers.cards[i].ability.extra.chips = G.jokers.cards[i].ability.extra.chips +1
                end
                if math.random(1,160) == 1 then 
                    G.jokers.cards[i].ability.extra.mult = G.jokers.cards[i].ability.extra.mult +1
                end
                if math.random(1,5000) == 1 then 
                    G.jokers.cards[i].ability.extra.chips = 0
                    G.jokers.cards[i].ability.extra.mult = 0
                    card_eval_status_text(G.jokers.cards[i],'extra',nil,nil,nil,{message = "Uh oh!"})
                    play_sound("timpani")
                end
            end

        end
    end
end



-- card creation override

--function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
--    if card and card.ability.name == "yahimod_horsewalksin" then
--		card:
--	end
--    return card
--end

local drawhook = love.draw
function love.draw()
    drawhook()

    if G.dino then dinoDraw() end

    function loadThatFuckingImage(fn)
        local full_path = (Yahimod.path 
        .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))
        --print ("LTFNI: Successfully loaded " .. fn)
        return (assert(love.graphics.newImage(tempimagedata),("Epic fail 3")))
    end

    function loadThatFuckingImageSpritesheet(fn,px,py,subimg,orientation)
        local full_path = (Yahimod.path 
        .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))

        local tempimg = assert(love.graphics.newImage(tempimagedata),("Epic fail 3"))

        local spritesheet = {}
        for i = 1, subimg do
            if orientation == 0 then -- 0 = downwards spritesheet
                table.insert(spritesheet,love.graphics.newQuad(0, (i-1)*py, px, py, tempimg))
            end
            if orientation == 1 then -- 1 = rightwards spritesheet
                table.insert(spritesheet,love.graphics.newQuad((i-1)*px, 0, px, py, tempimg))
            end
        end
        --print ("LTFNIS: Successfully loaded spritesheet " .. fn)

        return (spritesheet)
    end
    

    local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080


    --if Video:isplaying(Yahimod.nuuh) then
    --    love.graphics.draw(Yahimod.nuuh,0,0,0,_xscale*2/2,_yscale*2/2)
    --end

    -- debugging ticks & dt & dtcounter
    if Yahimod.debug then
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.print("ticks:"..Yahimod.ticks, 300, 16)
        love.graphics.print("dtcounter:"..Yahimod.dtcounter, 300, 16+32)
        love.graphics.print("dt:"..Yahimod.dt, 300, 16+64)
    end

    -- moroccan internet loading bar
    if jokerExists("j_yahimod_moroccaninternet") then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == "j_yahimod_moroccaninternet" then
                local _width = 60*1.7
                local _height = 12

                local _cx = G.jokers.cards[i].T.x * 100
                local _cy = -0.09+(G.jokers.cards[i].T.y+G.jokers.cards[i].T.h*0.33) * 100

                local _posx = (_cx - _width/2)*_xscale
                local _posy = (_cy + _height*6.2)*_yscale

                local _prog = G.jokers.cards[i].ability.extra.progress / G.jokers.cards[i].ability.extra.progresstotal

                
                love.graphics.setColor(0,255,0,1)
                love.graphics.rectangle( "fill", _posx, _posy,      (_width*_prog),  _height )

                --love.graphics.setColor(255,255,255,1)
                --love.graphics.rectangle( "fill", _posx, _posy,      _posx+_width,        _posy+_height )
                
            end
        end
    end

    -- ultrakill coin
    if G.coinout then
        if Yahimod.coinimage == nil then Yahimod.coinimage = loadThatFuckingImage("coin.png") end
        if Yahimod.coinsprite == nil then Yahimod.coinsprite = loadThatFuckingImageSpritesheet("coin.png",64,64,4,0) end

        for i = 1, #G.coinout.prevx do
            love.graphics.setColor(255, 230, 0, 1)
            love.graphics.draw(Yahimod.coinimage, 1, G.coinout.prevx[i], G.coinout.prevy[i],0,_xscale,_yscale,32*_xscale,32*_yscale)
        end

         -- coin star thing

        local _btm = love.graphics.getHeight()

        local _cx = G.coinout.x
        local _cy = G.coinout.y
        local _wi = 50 * math.max(3,     (1/(_btm - G.coinout.y - 100)*love.graphics.getHeight()))
        local _he = 50 * math.max(3,     (1/(_btm - G.coinout.y - 100)*love.graphics.getHeight()))
        local _thin = math.max(2,24*((G.coinout.y-100)/_btm))

        if G.coinout.clickabletimer == 0 then
            local _staralpha = math.min(88,100*((G.coinout.y-100)/_btm))/100

            local _starpoints = { _cx,_cy-_thin,     _cx+_wi,_cy-_he,    _cx+_thin,_cy,      _cx+_wi,_cy+_he,    _cx,_cy+_thin,    _cx-_wi,_cy+_he,    _cx-_thin,_cy,   _cx-_wi,_cy-_he,  _cx,_cy-_thin  }
            
            
            love.graphics.setColor(255, 230, 0, _staralpha)
            love.graphics.polygon( "fill", _starpoints )
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.setColor(1, 1, 1, 0.25)
        end

        local _imgindex = math.fmod(Yahimod.ticks, 4) + 1
        love.graphics.draw(Yahimod.coinimage, Yahimod.coinsprite[_imgindex], G.coinout.x, G.coinout.y,math.fmod(Yahimod.ticks, 360),_xscale,_yscale,32*_xscale,32*_yscale)

    end

    -- shulker box card

    if G.CONTROLLER and G.CONTROLLER.hovering.target then
        if G.CONTROLLER.hovering.target.config.center and G.CONTROLLER.hovering.target.config.center.key == "j_yahimod_shulkerbox" then
            if Yahimod.shulkerhud == nil then Yahimod.shulkerhud = loadThatFuckingImage("shulkerhud.png") end
            local mousex, mousey = love.mouse.getPosition( )
            love.graphics.setColor(1, 1, 1, 1) 
            local el_x = mousex - (Yahimod.shulkerhud:getWidth()/2)*_xscale
            local el_y = mousey + 40*_yscale
            love.graphics.draw(Yahimod.shulkerhud, el_x, el_y,0,_xscale,_yscale)


            if Yahimod.inventoryitems == nil then Yahimod.inventoryitems = loadThatFuckingImage("inventoryitems.png") end
            if Yahimod.inventoryitemsquad == nil then Yahimod.inventoryitemsquad = loadThatFuckingImageSpritesheet("inventoryitems.png",54,54,6,1) end

            if G.CONTROLLER.hovering.target.ability.extra.inventory then
                for i = 0, ( #G.CONTROLLER.hovering.target.ability.extra.inventory -1 )  do 
                    local el2_x = el_x+(21 + math.fmod((i),9)*54)  *_xscale
                    local el2_y = el_y+(51 + math.floor((i)/9)*54)  *_yscale
                    local itemnum = G.CONTROLLER.hovering.target.ability.extra.inventory[i+1]
                    if itemnum then love.graphics.draw(Yahimod.inventoryitems, Yahimod.inventoryitemsquad[itemnum], el2_x, el2_y,0,_xscale,_yscale) end
                end
            end
        end
    end

    -- boss blind speedrun
    if G.GAME.blind and G.GAME.blind.name == 'boss_speedrun' then
        love.graphics.setColor(1, 1, 1, 1) 
        local _extrazero = ""
        if G.clockticking < 10 then _extrazero = "0" end

        love.graphics.print("00:".. _extrazero.. G.clockticking, 1124, 371,0,3,3)
    end
    
    if G.showtetopear then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if Yahimod.tetopng == nil then Yahimod.tetopng = loadThatFuckingImage("tetopear.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(Yahimod.tetopng, 77*_xscale, 478*_yscale,0,_xscale*1.2,_yscale*0.5)
    end

    -- fake game crash
    if G.showcrash and (G.showcrash > 0) and (G.showcrash < 25) then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if Yahimod.crashpng == nil then Yahimod.crashpng = loadThatFuckingImage("crash.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(Yahimod.crashpng, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end

    -- washee washee
    if G.washee then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if Yahimod.washeepng == nil then Yahimod.washeepng = loadThatFuckingImage("washeewashee.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(Yahimod.washeepng, 200*_xscale*2, 100*_yscale*2,0,_xscale,_yscale)
    end

    -- fish
    if G.showfish and (G.showfish > 0) then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if Yahimod.fishpng == nil then Yahimod.fishpng = loadThatFuckingImage("fishondafloo.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(Yahimod.fishpng, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end

    -- pineapple
    if G.GAME.modifiers.yahimod_pineapple and not G.SETTINGS.paused then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if Yahimod.pineapplepng == nil then Yahimod.pineapplepng = loadThatFuckingImage("pineapple.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(Yahimod.pineapplepng, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end

    -- cantaloupe
    if G.showcantaloupe and (G.showcantaloupe > 0) then
        if Yahimod.cantaloupe == nil then Yahimod.cantaloupe = loadThatFuckingImage("cantaloupescreen.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(Yahimod.cantaloupe, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end

    -- cat
    if G.showlaughingcat and (G.showlaughingcat > 0) then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if G.showlaughingcat < (547) then
            if (G.showlaughingcat < 545 and G.showlaughingcat >540) then G.FUNCS.exit_overlay_menu() end
            if Yahimod.catlaughingpng == nil then Yahimod.catlaughingpng = loadThatFuckingImage("catlaughing.png") end
            love.graphics.setColor(1, 1, 1, 1) 
            love.graphics.draw(Yahimod.catlaughingpng, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2) 
        end
    end

    if (G.opentolan_canspawn == true) then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if Yahimod.horsepng == nil then Yahimod.horsepng = loadThatFuckingImage("horsepng.png") end
        if Yahimod.mcchat1 == nil then Yahimod.mcchat1 = loadThatFuckingImage("assets/mcchat/line1.png") end
        if Yahimod.mcchat2 == nil then Yahimod.mcchat2 = loadThatFuckingImage("assets/mcchat/line2.png") end
        
        
        local _graph = Yahimod.mcchat1
        if math.fmod((Yahimod.ticks),600) <= 300 then 
            _graph = Yahimod.mcchat1 
        else
            _graph = Yahimod.mcchat2
        end

        
        
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(_graph, 1*_xscale*2, 350*_yscale*2,0,_xscale*2,_yscale*2)
    end
    if (G.opentolan_canspawn ~= true) and G.opentolan_phase_ex == 2 then

        local alphatemp = 2 - (Yahimod.ticks - G.opentolan_phase)/300
        if Yahimod.mcchat3 == nil then Yahimod.mcchat3 = loadThatFuckingImage("assets/mcchat/line3.png") end
        love.graphics.setColor(1, 1, 1, alphatemp)
        love.graphics.draw(Yahimod.mcchat3, 1*_xscale*2, 350*_yscale*2,0,_xscale*2,_yscale*2)
        if alphatemp == 0 then
            G.opentolan_phase_ex = 0
        end
    end

    -- EFFECT MANAGER!!! 
    -- this is where on-screen little gifs play

    if G.effectmanager then
        
        --print("Effect manager has "..#G.effectmanager)
        for i = 1, #G.effectmanager do
            local _xscale = love.graphics.getWidth()/1920
            local _yscale = love.graphics.getHeight()/1080
            --print("G.effectmanager[i].name".. G.effectmanager[i][1].name)
            if G.effectmanager[i] ~= nil then
                if G.effectmanager[i][1].name == "explosion" then
                    if Yahimod.imageexplosion == nil then Yahimod.imageexplosion = loadThatFuckingImage("explosiongif.png") end
                    if Yahimod.imageexplosionsprite == nil then Yahimod.imageexplosionsprite = loadThatFuckingImageSpritesheet("explosiongif.png",200,282,17,0) end
                    imagetodraw = Yahimod.imageexplosion
                    quadtodraw = Yahimod.imageexplosionsprite
                    _imgindex = G.effectmanager[i][1].frame
                    _xpos = G.effectmanager[i][1].xpos-(200/2)
                    _ypos = G.effectmanager[i][1].ypos-(282/2)
                    --print("_imgindex".. _imgindex)
                    love.graphics.setColor(1, 1, 1, 1)
                end
                if G.effectmanager[i][1].name == "parry" then
                    if Yahimod.imageparry == nil then Yahimod.imageparry = loadThatFuckingImage("parry.png") end
                    if Yahimod.imageparrysprite == nil then Yahimod.imageparrysprite = loadThatFuckingImageSpritesheet("parry.png",480,270,47,0) end
                    imagetodraw = Yahimod.imageparry
                    quadtodraw = Yahimod.imageparrysprite
                    _imgindex = G.effectmanager[i][1].frame
                    --print("_imgindex".. _imgindex)
                    _xpos = G.effectmanager[i][1].xpos
                    _ypos = G.effectmanager[i][1].ypos

                    _xscale = _xscale * 4
                    _yscale = _yscale * 4

                    
                    if G.effectmanager[i][1].duration > 77 then 
                        love.graphics.setColor(255,255,255,0.5)
                        love.graphics.rectangle( "fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight() )
                    end

                    love.graphics.setColor(1, 1, 1, 1)
                end

                if G.effectmanager[i][1].name == "crack" then
                    if Yahimod.imagecrack == nil then Yahimod.imagecrack = loadThatFuckingImage("crack.png") end
                    if Yahimod.imagecracksprite == nil then Yahimod.imagecracksprite = loadThatFuckingImageSpritesheet("crack.png",256,192,1,0) end
                    imagetodraw = Yahimod.imagecrack
                    quadtodraw = Yahimod.imagecracksprite
                    _imgindex = 1
                    --print("_imgindex".. _imgindex)
                    _xpos = G.effectmanager[i][1].xpos* _xscale
                    _ypos = G.effectmanager[i][1].ypos* _yscale
                    love.graphics.setColor(1, 1, 1, G.effectmanager[i][1].duration/100)
                end

                if G.effectmanager[i][1].name == "errormessage" then
                    if Yahimod.imageerrormessage == nil then Yahimod.imageerrormessage = loadThatFuckingImage("errors.png") end
                    if Yahimod.imageerrormessagesprite == nil then Yahimod.imageerrormessagesprite = loadThatFuckingImageSpritesheet("errors.png",512,192,3,0) end
                    imagetodraw = Yahimod.imageerrormessage
                    quadtodraw = Yahimod.imageerrormessagesprite
                    _imgindex = G.effectmanager[i][1].frame
                    --print("_imgindex".. _imgindex)
                    _xpos = G.effectmanager[i][1].xpos* _xscale
                    _ypos = G.effectmanager[i][1].ypos* _yscale
                    _xscale = _xscale * 2
                    _yscale = _yscale * 2

                    love.graphics.setColor(1, 1, 1, G.effectmanager[i][1].duration/100)
                end
                


                
                love.graphics.draw(imagetodraw, quadtodraw[_imgindex], _xpos, _ypos, 0 ,_xscale,_yscale)
            end
        end
    end
end

function addHorse()
    local card = create_card('Joker', G.Jokers, nil, nil, nil, nil, 'j_yahimod_horsewalksin', 'deer')
    card.sell_cost = 4
    card:add_to_deck()
    G.jokers:emplace(card)
    check_for_unlock({ type = "ach_fellforit" })
    play_sound("yahimod_horse")
end

function calculate_jack_amount()
    local count = 0
    for _, card in ipairs(G.playing_cards) do
        local rank = card.base.value
        if rank == "Jack" then
            count = count + 1
        end
    end
    return count
end

function calculate_achievements()
    local count = 0
    local ACH = (smods and smods.achievements) or (SMODS and SMODS.Achievements) or {}
    local total, earned = 0, 0
    local needle = "ach_yahimod"

    for key, ach in pairs(ACH) do
        if type(key) == "string" and key:sub(1, #needle) == needle then
            total = total + 1
            if ach and ach.earned == true then
                earned = earned + 1
            end
        end
    end
    return earned
end

-- from cryptid/items/misc_joker.lua
local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ cry_press = true })
        userHasClicked(x,y)
        userHasClickedBoss(x,y)
    end
end

-- Override for the special cat koda is, to allow her to join your joker inventory even without needing space 
local buyspace = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
	if (card.ability.name == "j_yahimod_koda") then
		return true
	end
    if (card.ability.name == "Vampire") and card.edition and (card.edition.type == "yahimod_evil") then
        check_for_unlock({ type = "ach_infinitecraft" })
		return true
	end
	return buyspace(card)
end

----------------------------------------------------------
----------- MOD CODE END ----------------------------------