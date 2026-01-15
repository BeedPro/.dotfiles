local ts_utils = require "nvim-treesitter.ts_utils"

local function node_text(node)
  return vim.treesitter.get_node_text(node, 0)
end

local function children_of_type(node, wanted)
  local out = {}
  for c in node:iter_children() do
    if c:type() == wanted then
      out[#out + 1] = c
    end
  end
  return out
end

local function first_child_of_type(node, wanted)
  for c in node:iter_children() do
    if c:type() == wanted then
      return c
    end
  end
end

local function first_identifier(node)
  return first_child_of_type(node, "identifier")
end

local function is_named(node, name)
  local id = first_identifier(node)
  return id and node_text(id) == name
end

local function get_class_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  while node and node:type() ~= "class_definition" do
    node = node:parent()
  end
  return node
end

local function get_init_function(class_node)
  local blocks = children_of_type(class_node, "block")
  for _, block in ipairs(blocks) do
    local fns = children_of_type(block, "function_definition")
    for _, fn in ipairs(fns) do
      if is_named(fn, "__init__") then
        return fn
      end
    end
  end
end

local function param_name(param)
  local t = param:type()
  if t == "identifier" then
    return node_text(param)
  end

  if
    t == "default_parameter"
    or t == "typed_parameter"
    or t == "typed_default_parameter"
    or t == "list_splat_pattern"
    or t == "dictionary_splat_pattern"
  then
    local id = first_identifier(param)
    return id and node_text(id)
  end
end

local function collect_params(params_node)
  local out = {}
  for p in params_node:iter_children() do
    local name = param_name(p)
    if name then
      out[#out + 1] = name
    end
  end
  return out
end

local function get_class_init_params()
  local class_node = get_class_node_at_cursor()
  if not class_node then
    return nil
  end

  local init_fn = get_init_function(class_node)
  if not init_fn then
    return {}
  end

  local params_node = first_child_of_type(init_fn, "parameters")
  if not params_node then
    return {}
  end

  local params = collect_params(params_node)
  if params[1] == "self" then
    table.remove(params, 1)
  end

  return params
end

local function is_class_method(fn_node)
  local parent = fn_node and fn_node:parent()
  while parent and parent:type() ~= "class_definition" do
    parent = parent:parent()
  end
  return parent ~= nil
end

local function get_python_params()
  local node = ts_utils.get_node_at_cursor()
  while node and node:type() ~= "function_definition" do
    node = node:parent()
  end
  if not node then
    return {}
  end

  local params_node = first_child_of_type(node, "parameters")
  if not params_node then
    return {}
  end

  local params = collect_params(params_node)
  if is_class_method(node) and (params[1] == "self" or params[1] == "cls") then
    table.remove(params, 1)
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
  local params = get_class_init_params() or get_python_params()
  local nodes = {
    t '"""',
    t { "", "" },
    t "",
    i(1, "Description"),
    t { "", "" },
    t { "", "" },
  }

  local idx = 2
  for _, p in ipairs(params) do
    nodes[#nodes + 1] = t(":param " .. p .. ": ")
    nodes[#nodes + 1] = i(idx)
    idx = idx + 1
    nodes[#nodes + 1] = t { "", "" }
  end

  nodes[#nodes + 1] = t ":return: "
  nodes[#nodes + 1] = i(idx)
  nodes[#nodes + 1] = t { "", '"""' }

  return sn(nil, nodes)
end

ls.add_snippets("python", {
  s("docs", { d(1, python_docstring) }),
})
