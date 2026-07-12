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
local workspace_root = vim.fs.joinpath(data_dir, "jdtls")
local workspace_name = ("%s-%s"):format(vim.fs.basename(root_dir), vim.fn.sha256(root_dir):sub(1, 8))
local workspace_dir = vim.fs.joinpath(workspace_root, workspace_name)
local javac = vim.fn.exepath "javac"
local jdk_home = nil
if javac ~= "" then
  local resolved_javac = (vim.uv or vim.loop).fs_realpath(javac) or javac
  jdk_home = vim.fs.dirname(vim.fs.dirname(resolved_javac))
end
local java_bin = jdk_home and vim.fs.joinpath(jdk_home, "bin", "java") or vim.fn.exepath "java"

local bundles = {}
local debug_bundle_pattern = vim.fs.joinpath(
  mason_packages,
  "java-debug-adapter",
  "extension",
  "server",
  "com.microsoft.java.debug.plugin-*.jar"
)
for _, path in ipairs(vim.fn.glob(debug_bundle_pattern, true, true)) do
  bundles[#bundles + 1] = path
end

local excluded_test_bundles = {
  ["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true,
  ["jacocoagent.jar"] = true,
}

local test_bundle_pattern = vim.fs.joinpath(mason_packages, "java-test", "extension", "server", "*.jar")
for _, path in ipairs(vim.fn.glob(test_bundle_pattern, true, true)) do
  local name = vim.fn.fnamemodify(path, ":t")
  if not excluded_test_bundles[name] then
    bundles[#bundles + 1] = path
  end
end

local launcher = vim.fn.glob(vim.fs.joinpath(mason_packages, "jdtls", "plugins", "org.eclipse.equinox.launcher_*.jar"))
local config_dir = vim.fs.joinpath(
  mason_packages,
  "jdtls",
  vim.fn.has "mac" == 1 and "config_mac" or vim.fn.has "win32" == 1 and "config_win" or "config_linux"
)
local lombok_jar = vim.fs.joinpath(mason_packages, "jdtls", "lombok.jar")

if launcher == "" then
  vim.notify("jdtls launcher not found. Install Mason package 'jdtls' first.", vim.log.levels.WARN)
  return
end

if (vim.uv or vim.loop).fs_stat(config_dir) == nil then
  vim.notify(("jdtls config directory not found: %s"):format(config_dir), vim.log.levels.WARN)
  return
end

if vim.fn.executable(java_bin) ~= 1 then
  vim.notify("Java runtime not found for jdtls. Ensure 'java' is installed and on PATH.", vim.log.levels.WARN)
  return
end

if not jdk_home or vim.fn.executable(vim.fs.joinpath(jdk_home, "bin", "javac")) ~= 1 then
  vim.notify("Java compiler not found for jdtls. Install a full JDK and ensure 'javac' is on PATH.", vim.log.levels.WARN)
  return
end

vim.fn.mkdir(workspace_dir, "p")

jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  name = "jdtls",
  cmd = {
    java_bin,
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
  cmd_env = {
    JAVA_HOME = jdk_home,
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
        enabled = true,
        settings = {
          url = vim.fn.expand "~/.config/java/eclipse-formatter.xml",
          profile = "Neovim",
        },
      },
    },
  },
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

jdtls.start_or_attach(config)
jdtls.setup_dap { hotcodereplace = "auto", config_overrides = {} }

vim.keymap.set("n", "<leader>co", jdtls.organize_imports, {
  buffer = true,
  desc = "Organize imports",
})
vim.keymap.set("n", "<leader>crv", jdtls.extract_variable, {
  buffer = true,
  desc = "Extract variable",
})
vim.keymap.set("v", "<leader>crv", function()
  jdtls.extract_variable(true)
end, { buffer = true, desc = "Extract variable" })
vim.keymap.set("n", "<leader>crc", jdtls.extract_constant, {
  buffer = true,
  desc = "Extract constant",
})
vim.keymap.set("v", "<leader>crc", function()
  jdtls.extract_constant(true)
end, { buffer = true, desc = "Extract constant" })
vim.keymap.set("v", "<leader>crm", function()
  jdtls.extract_method(true)
end, { buffer = true, desc = "Extract method" })
vim.keymap.set("n", "<leader>tc", jdtls.test_class, { buffer = true, desc = "Debug test class" })
vim.keymap.set("n", "<leader>tr", jdtls.test_nearest_method, { buffer = true, desc = "Debug nearest test" })
