# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/code/camptocamp/odoo-addons"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "delivery_camiontrans"; then

  # Main window with vertical split
  new_window "dev_layout"

  # Left pane: src_code
  run_cmd "cd ~/code/camptocamp/odoo-addons/ && nvim"

  # Split right pane (odoo_src at top)
  split_h 50
  run_cmd "cd ~/code/odoo/versions/18.0 && nvim"

  # Split bottom-right pane (start_instance)
  split_v 50
  run_cmd "cd ~/code/camptocamp/"

  # Focus left pane by default
  select_pane 1


fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
