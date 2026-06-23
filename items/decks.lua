SMODS.Atlas{
    key = 'Decks',
    path = 'rsgdeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "rsg_deck",
    loc_txt = {
        name = "Resetting For A Beach Seed",
        text={
        "{C:green}1 in 6{} chance",
        "to start with an",
        "{C:attention,T:c_yahimod_opentolan}Open To Lan{}",
        },
    },
	
	config = { hands = 0, discards = 0, consumeables = 'c_opentolan'},
	pos = { x = 0, y = 0 },
	order = 1,
	atlas = "Decks",
    unlocked = true,

	apply = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				if G.consumeables then
                    if math.random(1,6) == 1 then
                        local card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_yahimod_opentolan", "yahimod_deck")
                        card:add_to_deck()
                        --card:start_materialize()
                        G.consumeables:emplace(card)
                    else
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_yahimod_tree", "yahimod_deck")
                        card:add_to_deck()
                        --card:start_materialize()
                        G.jokers:emplace(card)
                    end
                    return true
                  end
			end,
		}))
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

SMODS.Back({
    key = "whatsapp_deck",
    loc_txt = {
        name = "Google Play",
        text={
        "Start with a",
        "{C:green,T:j_yahimod_drwhatsapp}Dr. Whatsapp{} and 2",
        "{C:attention,T:c_yahimod_hispanicgathering}Hispanic Family Gatherings",
        },
    },
	
	config = { hands = 0, discards = 0, consumeables = 'c_opentolan'},
	pos = { x = 1, y = 0 },
	order = 1,
	atlas = "Decks",
    unlocked = true,

	apply = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				if G.consumeables then
                    local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_yahimod_drwhatsapp", "yahimod_deck")
                    card:add_to_deck()
                    --card:start_materialize()
                    G.jokers:emplace(card)

                        for i = 1, 2 do
                        local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_yahimod_hispanicgathering", "yahimod_deck")
                        card:add_to_deck()
                        --card:start_materialize()
                        G.consumeables:emplace(card)
                        end

                    return true
                  end
			end,
		}))
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

SMODS.Back({
    key = "mound_deck",
    loc_txt = {
        name = "The Mound",
        text={
        "{C:dark_edition}+2 Joker Slots",
        "{C:blue}-2 Hands",
        },
    },
	
	config = { hands = -2, joker_slot = 2, consumeables = 'c_opentolan'},
	pos = { x = 2, y = 0 },
	order = 1,
	atlas = "Decks",
    unlocked = true,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

SMODS.Back({
    key = "e_deck",
    loc_txt = {
        name = "Avoid Fifth Glyphs",
        text={
        "Clown Cards that contain a",
        "{C:red}fifth glyph{} can't play",
        "All Clown Cards proc again",
        },
    },
	
	config = { },
	pos = { x = 3, y = 0 },
	order = 1,
	atlas = "Decks",
    unlocked = true,

    apply = function(self)
        G.GAME.shop.joker_max = 3
    end,


    calculate = function(self, back, context)
        for i = 1, #G.jokers.cards do
            local _jn = string.lower(getJokerName(G.jokers.cards[i]))
            if string.find(_jn,"e") and G.jokers.cards[i].debuff == false then G.jokers.cards[i].debuff = true end
        end
        if context.retrigger_joker_check and not context.retrigger_joker then
            local _card = context.other_card
            local _jn = string.lower(getJokerName(context.other_card))
            if string.find(_jn,"e") == nil then
                return {
                    message = "Again!",
                    repetitions = 1,
                    _card = _card,
                }
            else
                return nil, true 
            end
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