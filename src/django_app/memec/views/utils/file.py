
import subprocess

# rest_loader.exe
# -db AS2033 -login django_user -password django_user -rest https://reqres.in -key qwerty -host HOME-PC\SQLEXPRESS
def run_executable(exe_name, params):
    call_string = f"{exe_name} {params}"
    # subprocess.run(["rest_loader.exe", "-db AS2033 -login django_user -password django_user -rest https://reqres.in -key qwerty -host HOME-PC\SQLEXPRESS"])
    subprocess.call(call_string)