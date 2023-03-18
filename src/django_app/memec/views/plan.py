from django.shortcuts import render, redirect
from django.views.generic import TemplateView, ListView
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse_lazy

from .utils import mssql
from .utils import file
from ..models import *


class PlanListView(LoginRequiredMixin, ListView):
    template_name = "memec/plan.html"
    model = Requests
    context_object_name = 'requests'
    login_url = reverse_lazy('signin')
