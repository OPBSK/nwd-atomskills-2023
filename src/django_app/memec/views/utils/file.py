
import subprocess


def run_executable(exe_name, params):
    call_string = f"{exe_name} {params}"
    subprocess.call(call_string)
