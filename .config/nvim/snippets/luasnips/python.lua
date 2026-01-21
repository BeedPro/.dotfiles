local ts_utils = require "nvim-treesitter.ts_utils"

local function node_text(node)
  return vim.treesitter.get_node_text(node, 0)
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

local function find_class_definition(name)
  if not name then
    return nil
  end

  local ok, parser = pcall(vim.treesitter.get_parser, 0, "python")
  if not ok or not parser then
    return nil
  end

  local trees = parser:parse()
  if not trees or not trees[1] then
    return nil
  end

  local root = trees[1]:root()
  if not root then
    return nil
  end

  for node in root:iter_children() do
    if node:type() == "class_definition" then
      local id = first_identifier(node)
      if id and node_text(id) == name then
        return node
      end
    end
  end

  return nil
end

local function collect_pydantic_fields(class_node)
  local out = {}
  if not class_node then
    return out
  end

  for node in class_node:iter_children() do
    if node:type() == "block" then
      for stmt in node:iter_children() do
        if stmt:type() == "expression_statement" then
          local target = stmt:child(0)
          if target and target:type() == "assignment" then
            local id = first_identifier(target)
            if id then
              table.insert(out, node_text(id))
            end
          end
        end
      end
    end
  end

  return out
end

local function get_body_model()
  local node = ts_utils.get_node_at_cursor()
  while node and node:type() ~= "function_definition" do
    node = node:parent()
  end
  if not node then
    return
  end

  local params_node = first_child_of_type(node, "parameters")
  if not params_node then
    return
  end

  for p in params_node:iter_children() do
    if p:type() == "typed_parameter" then
      local type_node = p:child(2)
      if type_node then
        return node_text(type_node)
      end
    end
  end
end

local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local t = ls.text_node

local function python_sphinx_docstring()
  local params = get_python_params()
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

local function python_fastapi_response_docstring()
  local model_name = get_body_model()
  local class_node = model_name and find_class_definition(model_name)
  local fields = collect_pydantic_fields(class_node)

  local nodes = {
    t '"""',
    t { "", "" },
    i(1, "Create an item with all the information:"),
    t { "", "", "" },
  }

  local idx = 2
  for _, field in ipairs(fields) do
    nodes[#nodes + 1] = t("- **" .. field .. "**: ")
    nodes[#nodes + 1] = i(idx)
    idx = idx + 1
    nodes[#nodes + 1] = t { "", "" }
  end

  nodes[#nodes + 1] = t '"""'

  return sn(nil, nodes)
end

ls.add_snippets("python", {
  s("sphinx", { d(1, python_sphinx_docstring) }),
})

ls.add_snippets("python", {
  s("docsfast", { d(1, python_fastapi_response_docstring) }),
})
