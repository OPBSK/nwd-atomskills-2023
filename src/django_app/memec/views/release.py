from django.shortcuts import redirect
from django.views.generic import ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse_lazy
from django.conf import settings

from .utils import mssql
from .utils import file
from ..models import *


class ReleaseListView(LoginRequiredMixin, ListView):
    template_name = "memec/release.html"
    paginate_by = 10
    model = ReleasedProduction
    context_object_name = 'release'
    login_url = reverse_lazy('signin')

    def post(self, request, *args, **kwargs):
        item_id = self.request.POST.get('item_id')
        request_id = self.request.POST.get('request_id')
        quantity = self.request.POST.get('count')
        executable_path = settings.BASE_DIR.joinpath(
            'tools').joinpath('rest_sender.exe')
        file.run_executable(
            executable_path, f'-mode release -param1 {request_id} -param2 {item_id} -param3 {quantity}')
        return redirect(self.request.path_info)
