session_root "~/code/oca"

if initialize_session "oca"; then

  new_window "ai"

  # Main window with vertical split
  new_window "dev_layout"

  # Left pane: src_code
  run_cmd "cd ~/code/oca/ && nvim"

  # Split right pane (odoo_src at top)
  split_h 50
  run_cmd "cd ~/code/odoo/odoo/18.0 && nvim"

  # Split bottom-right pane (start_instance)
  split_v 50
  run_cmd "cd ~/code/oca"

  # Focus left pane by default
  select_pane 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
