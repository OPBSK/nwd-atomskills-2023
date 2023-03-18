# signals.py
from django.core.signals import request_started
from django.dispatch import receiver
import subprocess


@receiver(request_started)
def run_bot(sender, **kwargs):
    # Run the 'mycommand' management command in a separate process
    subprocess.Popen(
        ["python", "manage.py", "bot"])
    request_started.disconnect(run_bot)
