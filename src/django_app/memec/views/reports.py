from django.shortcuts import render, get_object_or_404
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, TemplateView
from django.urls import reverse_lazy
from django.http import HttpResponse


from ..models import *


class ReportListView(LoginRequiredMixin, ListView):
    model = Reports
    login_url = reverse_lazy('signin')
    context_object_name = 'reports'
    queryset = model.objects.all()
    template_name = 'memec/reports.html'


class ReportView(TemplateView):
    model = Reports
    template_name = 'memec/report_view.html'

    def get(self, request, *args, **kwargs):
        html_report = get_object_or_404(self.model, id=kwargs['id'])
        return HttpResponse("<div style='padding-left:3rem; padding-right:3rem'>"+html_report.html+"</div>")
