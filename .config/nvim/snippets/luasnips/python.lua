local ts_utils = require "nvim-treesitter.ts_utils"

local function is_class_method(fn_node)
  if not fn_node then
    return false
  end

  local parent = fn_node:parent()
  while parent do
    if parent:type() == "class_definition" then
      return true
    end
    parent = parent:parent()
  end

  return false
end

local function get_python_params()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return {}
  end

  -- Walk up to function_definition
  while node and node:type() ~= "function_definition" do
    node = node:parent()
  end
  if not node then
    return {}
  end

  local is_method = is_class_method(node)

  -- Find the parameters() child
  local params_node
  for child in node:iter_children() do
    if child:type() == "parameters" then
      params_node = child
      break
    end
  end

  if not params_node then
    return {}
  end

  local params = {}

  -- Walk each parameter inside (parameters ...)
  for param in params_node:iter_children() do
    local t = param:type()

    if t == "identifier" then
      table.insert(params, vim.treesitter.get_node_text(param, 0))
    elseif t == "default_parameter" or t == "typed_parameter" or t == "typed_default_parameter" then
      for child in param:iter_children() do
        if child:type() == "identifier" then
          table.insert(params, vim.treesitter.get_node_text(child, 0))
          break
        end
      end
    elseif t == "list_splat_pattern" or t == "dictionary_splat_pattern" then
      -- *args or **kwargs
      for child in param:iter_children() do
        if child:type() == "identifier" then
          table.insert(params, vim.treesitter.get_node_text(child, 0))
          break
        end
      end
    end
  end

  -- Drop self / cls for class methods
  if is_method and #params > 0 then
    if params[1] == "self" or params[1] == "cls" then
      table.remove(params, 1)
    end
  end

  return params
end

local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local t = ls.text_node

local function python_docstring()
  local params = get_python_params()

  local nodes = {
    t '"""',
    t { "", "" },
    t "",
    i(1, "Description"),
    t { "", "" },
    t { "", "" },
  }

  local insert_index = 2

  for _, param in ipairs(params) do
    table.insert(nodes, t(":param " .. param .. ": "))
    table.insert(nodes, i(insert_index))
    insert_index = insert_index + 1
    table.insert(nodes, t { "", "" })
  end

  table.insert(nodes, t ":return: ")
  table.insert(nodes, i(insert_index))
  table.insert(nodes, t { "", '"""' })

  return sn(nil, nodes)
end

ls.add_snippets("python", {
  s("docs", {
    d(1, python_docstring),
  }),
})
