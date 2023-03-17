from django.shortcuts import render
from django.views.generic import ListView
from ..models import *

class ReportList(ListView):
    model = Reports
    context_object_name = 'reports'
    template_name='memec/reports.html'