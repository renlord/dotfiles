[ -f ~/.xprofile ] && . ~/.xprofile

RAZER_MOUSE_ID="$(xinput | awk '/Razer DeathAdder/ {print $6}' | cut -c 4-)"
if [ ! -z $RAZER_MOUSE_ID ]; then
    # reduce razor mouse sensitivity by a factor of 0.7
    xinput set-prop $RAZER_MOUSE_ID 377 -0.7
fi


fcitx &
exec /usr/bin/i3
