[{1 :Zeioth/compiler.nvim
  :cmd [:CompilerOpen :CompilerToggleResults :CompilerRedo]
  :dependencies [:stevearc/overseer.nvim]
  :opts {}}
 {1 :stevearc/overseer.nvim
  :opts {:task_list {:default_detail 1
                     :direction :bottom
                     :max_height 25
                     :min_height 25}}}
 {1 :michaelb/sniprun
  :build "bash ./install.sh"
  :config (fn []
            ((. (require :plugins.config.sniprun) :setup)))}]

