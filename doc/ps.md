ps -f --forest -g$$ # current shell tree
ps -aef --forest # tree

ps -f --forest  -$(pgrep -f "run_app.sh mage start" | head -n 1)
