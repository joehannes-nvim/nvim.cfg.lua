-- [nfnl] Compiled from fnl/plugins/config/dap.fnl by https://github.com/Olical/nfnl, do not edit.
local my = _G.my
local M = {}
M.setup = function()
  local dap, dapui = require("dap"), require("dapui")
  local firefox_bin = "/opt/homebrew/Caskroom/firefox-developer-edition/latest/Firefox Developer Edition.app/Contents/MacOS/firefox"
  do end (require("dap-vscode-js")).setup({adapters = {"pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost"}, debugger_path = (my.fs.dir.data .. "/site/pack/packer/opt/vscode-js-debug")})
  dap.adapters.chrome = {args = {(my.fs.dir.data .. "/site/pack/packer/opt/vscode-chrome-debug/out/src/chromeDebug.js")}, command = "node", type = "executable"}
  dap.adapters.firefox = {args = {(my.fs.dir.data .. "/site/pack/packer/opt/vscode-firefox-debug/dist/adapter.bundle.js")}, command = "node", type = "executable"}
  dap.configurations.javascript = {firefoxExecutable = firefox_bin, name = "Debug JS with Firefox", reAttach = true, request = "launch", type = "firefox", url = "http://localhost:3000", webRoot = "${workspaceFolder}"}
  dap.configurations.javascriptreact = {{firefoxExecutable = firefox_bin, name = "Debug JSX with Firefox", reAttach = true, request = "launch", type = "firefox", url = "http://localhost:3000", webRoot = "${workspaceFolder}"}, {cwd = vim.fn.getcwd(), name = "Debug JSX with Chrome", port = 9222, program = "${file}", protocol = "inspector", request = "attach", sourceMaps = true, type = "chrome", webRoot = "${workspaceFolder}"}}
  dap.configurations.typescript = {firefoxExecutable = firefox_bin, name = "Debug TS with Firefox", reAttach = true, request = "launch", type = "firefox", url = "http://localhost:3000", webRoot = "${workspaceFolder}"}
  dap.configurations.typescriptreact = {{firefoxExecutable = firefox_bin, name = "Debug TSX with Firefox", reAttach = true, request = "launch", type = "firefox", url = "http://localhost:3000", webRoot = "${workspaceFolder}"}, {cwd = vim.fn.getcwd(), name = "Debug TSX with Chrome", port = 9222, program = "${file}", protocol = "inspector", request = "attach", sourceMaps = true, type = "chrome", webRoot = "${workspaceFolder}"}, {cwd = "${workspaceFolder}", name = "Debug TSX: launch pwa-node", program = "${file}", request = "launch", type = "pwa-node"}, {cwd = "${workspaceFolder}", name = "Debug TSX: attach pwa-node", processId = (require("dap.utils")).pick_process, request = "attach", type = "pwa-node"}, {cwd = "${workspaceFolder}", name = "Debug TSX: launch pwa-chrome", program = "${file}", request = "launch", type = "pwa-chrome"}, {cwd = "${workspaceFolder}", name = "Debug TSX: attach pwa-chrome", processId = (require("dap.utils")).pick_process, request = "attach", type = "pwa-chrome", url = "localhost:3000"}}
  dapui.setup({floating = {mappings = {close = {"q", "<Esc>"}}, max_height = 1, max_width = 1}, icons = {collapsed = "\226\150\184", expanded = "\226\150\190"}, layouts = {{elements = {"scopes", "breakpoints", "stacks", "watches"}, position = "left", size = 40}, {elements = {"repl", "console"}, position = "bottom", size = 10}}, mappings = {edit = "e", expand = {"<CR>", "<2-LeftMouse>"}, open = "o", remove = "d", repl = "r"}, windows = {indent = 1}})
  local function _1_()
    return dapui.open()
  end
  dap.listeners.after.event_initialized["dapui_config"] = _1_
  local function _2_()
    return dapui.close()
  end
  dap.listeners.before.event_terminated["dapui_config"] = _2_
  local function _3_()
    return dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = _3_
  return nil
end
return M
