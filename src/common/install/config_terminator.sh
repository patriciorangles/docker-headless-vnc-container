#!/bin/bash
#
# Realiza la configuración de terminator, esto porque en ciertas imágenes da error al iniciar
# se aprovecha para configurarlo acorde a nuestros requerimientos

sudo mkdir -p /etc/xdg/terminator

sudo tee /etc/xdg/terminator/config > /dev/null <<EOL
[global_config]
title_transmit_bg_color = "#d30102"
title_inactive_bg_color = "#eeeeec"
title_receive_bg_color = "#f57900"
title_inactive_fg_color = "#cccccc"
title_receive_fg_color = "#2e3436"
title_transmit_fg_color = "#fce94f"

[profiles]
   [[default]]
      background_color = "#000000"
      foreground_color = "#ffffff"
      scrollbar_position = hidden
      font = Monospace 12
      scrollback_infinite = True
EOL
