local opt_local = vim.opt_local

opt_local.spell = true
opt_local.spelllang = "en_gb"
opt_local.colorcolumn = "80"

if _G.__typst_foldexpr == nil then
  _G.__typst_foldexpr = function(lnum)
    local line = vim.fn.getline(lnum)
    local heading = line:match "^(=+)%s"

    if heading then
      return ">" .. tostring(#heading)
    end

    return "="
  end
end

opt_local.foldmethod = "expr"
opt_local.foldexpr = "v:lua.__typst_foldexpr(v:lnum)"
opt_local.foldenable = true
opt_local.foldlevel = 99
opt_local.foldlevelstart = 99
