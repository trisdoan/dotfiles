# Set a custom session root path. Default is `$HOME`.
session_root "~/code/camptocamp/avy-addons/"

if initialize_session "vertical-winery"; then

  new_window "ai"

  # Main window with vertical split
  new_window "dev_layout"

  # Left pane: src_code
  run_cmd "cd ~/code/camptocamp/vertical-winery && nvim"
  split_v 50
  run_cmd "cd $session_root"

  # Split right pane (odoo_src at top)
  split_h 50
  run_cmd "cd ~/code/odoo/versions/18.0 && nvim"

  # Split bottom-right pane (start_instance)
  split_v 50
  run_cmd "cd ~/code/camptocamp/avy-addons"

  # Focus left pane by default
  select_pane 1


fi

finalize_and_go_to_session

