SMODS.PokerHand({
    key = "pkr_jerma",
    mult = 4,
    chips = 40,
    l_mult = 3,
    l_chips = 30,
    example = {
        { 'S_K', false }, -- King of Spades, does not score
        { 'D_9', true },
        { 'H_8', true, enhancement = 'm_lucky' }, -- Negative Lucky 9 of Diamonds, scores
        { 'S_5', true },
        { 'D_J', false, seal = 'Red' } -- Red Seal 3 of Diamonds, does not score
    },
    loc_txt = {
        name = "jerma985",
        description = {"A hand containing a 9, 8 and a 5."},
    },
    visible = true,

    evaluate = function(parts, hand)
        if #hand >= 3 then
            local _has9 = false
            local _has8 = false
            local _has5 = false
            local eligible_cards = {}
            local other_hands = next(parts._flush) or next(parts._straight) or next(parts._all_pairs)

            for i, card in ipairs(hand) do
                if card:get_id() == 9 and _has9 == false then
                    _has9 = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 8 and _has8 == false then
                    _has8 = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 5 and _has5 == false then
                    _has5 = true
                    eligible_cards[#eligible_cards + 1] = card
                end
            end


            if _has9 and _has8 and _has5 and not other_hands then
                return{eligible_cards}
            end
        end


    end,


    modify_display_text = function(self, cards, scoring_hand)
        return pkr_jerma
    end,
})

-- planet for Jerma
SMODS.Atlas{
    key = 'atlas_planets',
    path = 'jermaplanet.png',
    px = 71,
    py = 96,
}


SMODS.Sound({key = "jermanoise", path = "jermanoise.ogg",})

SMODS.Consumable({
    key = "yahimod_jermaplanet",
    set = "Planet",
    object_type = "Consumable",
    name = "yahimod_jermaplanet",
    loc_txt = {
        name = "Planet Jerma",
        text={
        "Jerma",
        },
    },

	
	
	pos = {x=0, y= 0},
	order = 99,
	atlas = "atlas_planets",
    unlocked = true,
    cost = 4,
    hidden = true,

    use = function(self, card, area, copier)
        SMODS.upgrade_poker_hands({from = card, hands = {"yahimod_pkr_jerma"}})
        play_sound("yahimod_jermanoise")
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