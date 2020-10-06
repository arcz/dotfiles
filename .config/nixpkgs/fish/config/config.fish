set fish_color_command brwhite
set fish_greeting # disable greeting

set fish_function_path $fish_function_path ~/.nix-profile/share/fish-foreign-env/functions
fenv source ~/.nix-profile/etc/profile.d/nix.sh

set fish_function_path (dirname (status --current-filename))/functions $fish_function_path
