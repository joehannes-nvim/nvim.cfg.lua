(local my _G.my)
(local M {})

(fn M.setup []
  (let [(dap dapui) (values (require :dap) (require :dapui))
        firefox-bin "/opt/homebrew/Caskroom/firefox-developer-edition/latest/Firefox Developer Edition.app/Contents/MacOS/firefox"]
    ((. (require :dap-vscode-js) :setup) {:adapters [:pwa-node
                                                     :pwa-chrome
                                                     :pwa-msedge
                                                     :node-terminal
                                                     :pwa-extensionHost]
                                          :debugger_path (.. my.fs.dir.data
                                                             :/site/pack/packer/opt/vscode-js-debug)})
    (set dap.adapters.chrome {:args [(.. my.fs.dir.data
                                         :/site/pack/packer/opt/vscode-chrome-debug/out/src/chromeDebug.js)]
                              :command :node
                              :type :executable})
    (set dap.adapters.firefox {:args [(.. my.fs.dir.data
                                          :/site/pack/packer/opt/vscode-firefox-debug/dist/adapter.bundle.js)]
                               :command :node
                               :type :executable})
    (set dap.configurations.javascript
         {:firefoxExecutable firefox-bin
          :name "Debug JS with Firefox"
          :reAttach true
          :request :launch
          :type :firefox
          :url "http://localhost:3000"
          :webRoot "${workspaceFolder}"})
    (set dap.configurations.javascriptreact
         [{:firefoxExecutable firefox-bin
           :name "Debug JSX with Firefox"
           :reAttach true
           :request :launch
           :type :firefox
           :url "http://localhost:3000"
           :webRoot "${workspaceFolder}"}
          {:cwd (vim.fn.getcwd)
           :name "Debug JSX with Chrome"
           :port 9222
           :program "${file}"
           :protocol :inspector
           :request :attach
           :sourceMaps true
           :type :chrome
           :webRoot "${workspaceFolder}"}])
    (set dap.configurations.typescript
         {:firefoxExecutable firefox-bin
          :name "Debug TS with Firefox"
          :reAttach true
          :request :launch
          :type :firefox
          :url "http://localhost:3000"
          :webRoot "${workspaceFolder}"})
    (set dap.configurations.typescriptreact
         [{:firefoxExecutable firefox-bin
           :name "Debug TSX with Firefox"
           :reAttach true
           :request :launch
           :type :firefox
           :url "http://localhost:3000"
           :webRoot "${workspaceFolder}"}
          {:cwd (vim.fn.getcwd)
           :name "Debug TSX with Chrome"
           :port 9222
           :program "${file}"
           :protocol :inspector
           :request :attach
           :sourceMaps true
           :type :chrome
           :webRoot "${workspaceFolder}"}
          {:cwd "${workspaceFolder}"
           :name "Debug TSX: launch pwa-node"
           :program "${file}"
           :request :launch
           :type :pwa-node}
          {:cwd "${workspaceFolder}"
           :name "Debug TSX: attach pwa-node"
           :processId (. (require :dap.utils) :pick_process)
           :request :attach
           :type :pwa-node}
          {:cwd "${workspaceFolder}"
           :name "Debug TSX: launch pwa-chrome"
           :program "${file}"
           :request :launch
           :type :pwa-chrome}
          {:cwd "${workspaceFolder}"
           :name "Debug TSX: attach pwa-chrome"
           :processId (. (require :dap.utils) :pick_process)
           :request :attach
           :type :pwa-chrome
           :url "localhost:3000"}])
    (dapui.setup {:floating {:mappings {:close [:q :<Esc>]}
                             :max_height 1
                             :max_width 1}
                  :icons {:collapsed "▸" :expanded "▾"}
                  :layouts [{:elements [:scopes :breakpoints :stacks :watches]
                             :position :left
                             :size 40}
                            {:elements [:repl :console]
                             :position :bottom
                             :size 10}]
                  :mappings {:edit :e
                             :expand [:<CR> :<2-LeftMouse>]
                             :open :o
                             :remove :d
                             :repl :r}
                  :windows {:indent 1}})
    (tset dap.listeners.after.event_initialized :dapui_config
          (fn [] (dapui.open)))
    (tset dap.listeners.before.event_terminated :dapui_config
          (fn [] (dapui.close)))
    (tset dap.listeners.before.event_exited :dapui_config (fn [] (dapui.close)))))

M

