from django.shortcuts import render, get_object_or_404
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, TemplateView
from django.urls import reverse_lazy
from django.http import HttpResponse
from django.conf import settings
from .utils import file


from ..models import *


class ReportListView(LoginRequiredMixin, ListView):
    model = ReportsView
    paginate_by = 10
    login_url = reverse_lazy('signin')
    context_object_name = 'reports'
    queryset = model.objects.all().order_by('-id')
    template_name = 'memec/reports.html'


class ReportView(TemplateView):
    model = ReportsView
    template_name = 'memec/report_view.html'

    def get(self, request, *args, **kwargs):
        report_id = self.request.GET.get('id', '')
        port = self.request.GET.get('port', '')
        html_report = get_object_or_404(self.model, id=report_id)
        if port != '':
            executable_path = settings.BASE_DIR.joinpath(
                'tools').joinpath('rest_sender.exe')
            file.run_executable(
                executable_path, f'-mode repair -param1 {port}')
            # -mode repair -param1 port port is empty?
        return HttpResponse("<div style='padding-left:3rem; padding-right:3rem'>"+html_report.html+"</div>")
