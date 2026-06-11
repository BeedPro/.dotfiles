local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local root_dir = vim.fs.root(0, {
  "gradlew",
  "mvnw",
  ".git",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  "settings.gradle",
  "settings.gradle.kts",
})

if not root_dir then
  return
end

local data_dir = vim.fn.stdpath "data"
local mason_packages = vim.fs.joinpath(data_dir, "mason", "packages")
local workspace_dir = vim.fs.joinpath(data_dir, "jdtls-workspace", vim.fs.basename(root_dir))

local bundles = {}

local function extend_bundles(pattern, exclude)
  for _, path in ipairs(vim.fn.glob(pattern, true, true)) do
    local name = vim.fn.fnamemodify(path, ":t")
    if not exclude or not exclude[name] then
      bundles[#bundles + 1] = path
    end
  end
end

extend_bundles(vim.fs.joinpath(mason_packages, "java-debug-adapter", "extension", "server", "com.microsoft.java.debug.plugin-*.jar"))
extend_bundles(vim.fs.joinpath(mason_packages, "java-test", "extension", "server", "*.jar"), {
  ["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true,
  ["jacocoagent.jar"] = true,
})

local launcher = vim.fn.glob(vim.fs.joinpath(mason_packages, "jdtls", "plugins", "org.eclipse.equinox.launcher_*.jar"))
local config_dir = vim.fs.joinpath(mason_packages, "jdtls", "config_linux")
local lombok_jar = vim.fs.joinpath(mason_packages, "jdtls", "lombok.jar")

if launcher == "" then
  vim.notify("jdtls launcher not found. Install Mason package 'jdtls' first.", vim.log.levels.WARN)
  return
end

jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  name = "jdtls",
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=WARN",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. lombok_jar,
    "-jar",
    launcher,
    "-configuration",
    config_dir,
    "-data",
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
      signatureHelp = {
        enabled = true,
      },
      format = {
        enabled = false,
      },
    },
  },
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

jdtls.start_or_attach(config)

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
end

map("n", "<leader>co", jdtls.organize_imports, "Organize imports")
map("n", "<leader>crv", jdtls.extract_variable, "Extract variable")
map("v", "<leader>crv", function()
  jdtls.extract_variable(true)
end, "Extract variable")
map("n", "<leader>crc", jdtls.extract_constant, "Extract constant")
map("v", "<leader>crc", function()
  jdtls.extract_constant(true)
end, "Extract constant")
map("v", "<leader>crm", function()
  jdtls.extract_method(true)
end, "Extract method")
map("n", "<leader>tc", jdtls.test_class, "Debug test class")
map("n", "<leader>tr", jdtls.test_nearest_method, "Debug nearest test")
