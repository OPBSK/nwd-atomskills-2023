from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import TemplateView, ListView
from django.urls import reverse_lazy
from django.http import JsonResponse
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse
from django.conf import settings

from ..models import *
from .utils import file


class AlertsListView(LoginRequiredMixin, ListView):
    model = MessagesView
    paginate_by = 10
    login_url = reverse_lazy('signin')
    context_object_name = 'alerts'
    queryset = model.objects.all().order_by('-ts')
    template_name = "memec/alerts.html"


def ajax_alerts(request):
    messages = Messages.objects.filter(viewed=0)
    data = []
    for message in messages:
        if message.type == 0:
            alert_type = "alert-success"
        if message.type == 1:
            alert_type = "alert-warning"
        if message.type == 2:
            alert_type = "alert-danger"
        html = f"""
            <div class="alert {alert_type} alert-dismissible fade show" role="alert">
                <strong>AUMANU {message.ts.strftime("%d.%m.%Y %H:%M")}</strong>
                <p>{message.msg}</p>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        """
        data.append(
            {'html': html})
        message.viewed = 1
        message.save()
    return JsonResponse(data, safe=False)
    # type 0 - green 1 - yellow 2 - red
