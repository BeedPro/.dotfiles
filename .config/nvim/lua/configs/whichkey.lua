return {
  delay = function(ctx)
    if ctx.plugin == "spelling" then
      return 0
    end
    return 1000
  end,
}
