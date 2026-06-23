SMODS.Atlas({
    key = 'stakes',
    path = 'stakes.png',
    px = '29',
    py = '29'
})

SMODS.Atlas({
    key = 'stickers',
    path = 'stake_stickers.png',
    px = 71,
    py = 95
})

-- hook to overwrite costs
costhook = Card.set_cost
function Card:set_cost()
    costhook(self)
    if self.ability.yahimod_sticker_madeinmorocco then
        self.cost = 2
        self.sell_cost = 1
    end
end

SMODS.Sticker({
	key = "sticker_madeinmorocco",
	atlas = "stickers",
    pos = { x = 0, y = 0 },
	badge_colour = G.C.RED,
	default_compat = true,
    needs_enable_flag = true,
    rate = 0.3,
    loc_txt = {
        name = "Made In Morocco",
        text = {
            'Card costs $2 but will',
            'self-destruct 3 turns after',
            'being bought'
        },
        label = "MADE-IN-MOROCCO",
    },

    should_apply = function(self, card, center, area)
        if (pseudorandom('badges') < 0.8) or (not G.GAME.modifiers.yahimod_spawn_madeinmorocco == true) then
            return false
        end
        return (area == G.shop_jokers) or (area == G.pack_cards)
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            card.ability.yahimod_sticker_madeinmorocco = card.ability.yahimod_sticker_madeinmorocco - 1

            if card.ability.yahimod_sticker_madeinmorocco <= 0 then
                explodeCard(card)
            else
                _text = card.ability.yahimod_sticker_madeinmorocco .. " rounds remaining!"
                card_eval_status_text(card,'extra',nil,nil,nil,{message = _text})
            end
        end
    end,
    apply = function(self, card, val)
        card.ability[self.key] = 3
        card.ability.cost = 3
        if card.ability[self.key] then card:set_cost() end
    end

})

SMODS.Sound({key = "pineapple", path = "pineapple.ogg",})

SMODS.Stake({
    key = "pineapple",
    applied_stakes = {},
    above_stake = 'black',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    atlas = 'stakes',
    pos = {x = 2, y = 0},
    shiny = false,

    loc_txt = {
        name = "Pineapple",
        text = {
            'A pineapple jpeg',
            'covers half your screen'
        },
    },

    modifiers = function()
        G.GAME.modifiers.yahimod_pineapple = true
        play_sound("yahimod_pineapple")
    end,
})

SMODS.Stake({
    key = "equine",
    applied_stakes = {},
    above_stake = 'black',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    atlas = 'stakes',
    pos = {x = 1, y = 0},
    shiny = true,

    loc_txt = {
        name = "Equine Stake",
        text = {
            'Every card in your deck',
            'has a 15% chance to spawn',
            'with a Horse Seal'
        },
    },

modifiers = function()
       
        G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blocking = false,
                    delay = 0.5,
                    func = function()
                        for _, card in ipairs(G.playing_cards) do
                            if math.random(0,1) < 0.15 then
                                card:set_seal('yahimod_horse_seal') 
                            end
                        end
                        return true
                    end,
                    }))
    end,
})

SMODS.Stake({
    key = "camel",
    applied_stakes = {'black'},
    above_stake = 'black',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    atlas = 'stakes',
    pos = {x = 0, y = 0},
    shiny = true,
    sticker_pos = {x = 0, y = 0},
    sticker_atlas = 'stickers',

    loc_txt = {
        name = "Camel Stake",
        text = {
            'Cards can have a',
            'Made in Morocco sticker'
        },
    },

    modifiers = function()
        G.GAME.modifiers.yahimod_spawn_madeinmorocco = true
    end,
})



