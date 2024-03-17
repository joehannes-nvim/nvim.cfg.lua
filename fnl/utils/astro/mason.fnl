; ### Mason Utils
;
; Mason related utility functions to use within AstroNvim and user configurations.
;
; This module can be loaded with `local mason_utils = require("astronvim.utils.mason")`
;
; @module astronvim.utils.mason
; @see astronvim.utils
; @copyright 2022
; @license GNU General Public License v3.0

(local M {})
(local utils (require :lit.astro))
(local astroevent utils.event)
(fn mason-notify [msg type] (utils.notify msg type {:title :Mason}))
(fn M.update [pkg-names auto-install]
  (set-forcibly! pkg-names (or pkg-names {}))
  (when (= (type pkg-names) :string) (set-forcibly! pkg-names [pkg-names]))
  (when (= auto-install nil) (set-forcibly! auto-install true))
  (local (registry-avail registry) (pcall require :mason-registry))
  (when (not registry-avail)
    (vim.api.nvim_err_writeln "Unable to access mason registry")
    (lua "return "))
  (registry.update (vim.schedule_wrap (fn [success updated-registries]
                                        (if success
                                            (let [count (length updated-registries)]
                                              (when (= (vim.tbl_count pkg-names)
                                                       0)
                                                (mason-notify (: "Successfully updated %d %s."
                                                                 :format count
                                                                 (or (and (= count
                                                                             1)
                                                                          :registry)
                                                                     :registries))))
                                              (each [_ pkg-name (ipairs pkg-names)]
                                                (local (pkg-avail pkg)
                                                       (pcall registry.get_package
                                                              pkg-name))
                                                (if (not pkg-avail)
                                                    (mason-notify (: "`%s` is not available"
                                                                     :format
                                                                     pkg-name)
                                                                  vim.log.levels.ERROR)
                                                    (if (not (pkg:is_installed))
                                                        (if auto-install
                                                            (do
                                                              (mason-notify (: "Installing `%s`"
                                                                               :format
                                                                               pkg.name))
                                                              (pkg:install))
                                                            (mason-notify (: "`%s` not installed"
                                                                             :format
                                                                             pkg.name)
                                                                          vim.log.levels.WARN))
                                                        (pkg:check_new_version (fn [update-available
                                                                                    version]
                                                                                 (if update-available
                                                                                     (do
                                                                                       (mason-notify (: "Updating `%s` to %s"
                                                                                                        :format
                                                                                                        pkg.name
                                                                                                        version.latest_version))
                                                                                       (: (pkg:install)
                                                                                          :on
                                                                                          :closed
                                                                                          (fn []
                                                                                            (mason-notify (: "Updated %s"
                                                                                                             :format
                                                                                                             pkg.name)))))
                                                                                     (mason-notify (: "No updates available for `%s`"
                                                                                                      :format
                                                                                                      pkg.name)))))))))
                                            (mason-notify (: "Failed to update registries: %s"
                                                             :format
                                                             updated-registries)
                                                          vim.log.levels.ERROR))))))
(fn M.update_all []
  (let [(registry-avail registry) (pcall require :mason-registry)]
    (when (not registry-avail)
      (vim.api.nvim_err_writeln "Unable to access mason registry")
      (lua "return "))
    (mason-notify "Checking for package updates...")
    (registry.update (vim.schedule_wrap (fn [success updated-registries]
                                          (if success
                                              (let [installed-pkgs (registry.get_installed_packages)]
                                                (var running
                                                     (length installed-pkgs))
                                                (local no-pkgs (= running 0))
                                                (if no-pkgs
                                                    (do
                                                      (mason-notify "No updates available")
                                                      (astroevent :MasonUpdateCompleted))
                                                    (do
                                                      (var updated false)
                                                      (each [_ pkg (ipairs installed-pkgs)]
                                                        (pkg:check_new_version (fn [update-available
                                                                                    version]
                                                                                 (if update-available
                                                                                     (do
                                                                                       (set updated
                                                                                            true)
                                                                                       (mason-notify (: "Updating `%s` to %s"
                                                                                                        :format
                                                                                                        pkg.name
                                                                                                        version.latest_version))
                                                                                       (: (pkg:install)
                                                                                          :on
                                                                                          :closed
                                                                                          (fn []
                                                                                            (set running
                                                                                                 (- running
                                                                                                    1))
                                                                                            (when (= running
                                                                                                     0)
                                                                                              (mason-notify "Update Complete")
                                                                                              (astroevent :MasonUpdateCompleted)))))
                                                                                     (do
                                                                                       (set running
                                                                                            (- running
                                                                                               1))
                                                                                       (when (= running
                                                                                                0)
                                                                                         (if updated
                                                                                             (mason-notify "Update Complete")
                                                                                             (mason-notify "No updates available"))
                                                                                         (astroevent :MasonUpdateCompleted))))))))))
                                              (mason-notify (: "Failed to update registries: %s"
                                                               :format
                                                               updated-registries)
                                                            vim.log.levels.ERROR)))))))
M
