-- generado por matugen, no editar
local c_primary = "{{ colors.primary.default.hex }}"
local c_secondary = "{{ colors.secondary.default.hex }}"
local c_outline = "{{ colors.outline.default.hex }}"
c_primary = c_primary:gsub("#","")
c_secondary = c_secondary:gsub("#","")
c_outline = c_outline:gsub("#","")
hl.config({
  general = {
    col = {
      active_border = { colors = { "rgb(" .. c_primary .. ")", "rgb(" .. c_secondary .. ")" }, angle = 45 },
      inactive_border = "rgb(" .. c_outline .. ")",
    },
  },
})
