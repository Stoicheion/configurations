case $1 in
  awesome) exec awesome ;;
  xmonad ) exec xmonad  ;;
  openbox) exec openbox ;;
  * ) exec awesome ;;
esac
