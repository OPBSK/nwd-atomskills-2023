# signals.py
from django.core.signals import request_started, request_finished
from django.dispatch import receiver
import subprocess
import signal
import atexit

bot = None


@receiver(request_started)
def run_bot(sender, **kwargs):
    global bot
    # Run the 'mycommand' management command in a separate process
    bot = subprocess.Popen(
        ["python", "manage.py", "bot"])
    request_started.disconnect(run_bot)


def stop_bot():
    global bot
    if bot is not None:
        # Terminate the subprocess if it is still running
        bot.terminate()


# Register the signal handler for SIGTERM
atexit.register(stop_bot)
