local v = require("variables")

hl.config({
	group = {
		col = {
			border_active = v.activeWindowBorderColour,
			border_inactive = v.inactiveWindowBorderColour,
			border_locked_active = v.activeWindowBorderColour,
			border_locked_inactive = v.inactiveWindowBorderColour,
		},
		groupbar = {

			font_family = "JetBrains Mono NF",
			font_size = 15,
			gradients = true,
			gradient_round_only_edges = false,
			gradient_rounding = 5,
			height = 25,
			indicator_height = 0,
			gaps_in = 3,
			gaps_out = 3,

			-- text_color = "rgb(" .. v.onPrimary .. ")",
			col = {
				-- active = "rgba(" .. v.primaryd4 .. ")",
				-- inactive = "rgba(" .. v.outlined4 .. ")",
				-- locked_active = "rgba(" .. v.primaryd4 .. ")",
				-- locked_inactive = "rgba(" .. v.secondaryd4 .. ")",
			},
		},
	},
})
