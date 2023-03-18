from django.shortcuts import render, redirect
from django.views.generic import TemplateView, ListView
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse_lazy
from django.conf import settings
from pathlib import Path

from .utils import mssql
from .utils import file
from ..models import *

# Create your views here.

# query = mssql.execute_procedure('dbo._test_proc', '1', '2')
# file.run_executable('rest_loader.exe', '-db AS2033 -login django_user -password django_user -rest https://reqres.in -key qwerty -host HOME-PC\SQLEXPRESS')
# context = {}
# context.update({'result': query})


class MainListView(LoginRequiredMixin, ListView):
    template_name = "memec/main.html"
    model = Requests
    paginate_by = 10
    context_object_name = 'requests'
    login_url = reverse_lazy('signin')

    def get_queryset(self):
        state = self.request.GET.get('state', 'new')
        if state == 'new':
            return self.model.objects.filter(state='DRAFT').order_by('-date')
        if state == 'production':
            return self.model.objects.filter(state='IN_PRODUCTION').order_by('-date')
        if state == 'executed':
            return self.model.objects.filter(state='EXECUTED').order_by('-date')
        return self.model.objects.filter(state='DRAFT').order_by('-date')


class RequestView(LoginRequiredMixin, ListView):
    template_name = "memec/request_view.html"
    model = RequestItems
    paginate_by = 10
    context_object_name = 'requestitems'
    login_url = reverse_lazy('signin')

    def get_context_data(self, **kwargs):
        context = super(RequestView, self).get_context_data(**kwargs)
        free_machines = FreeMachines.objects.all()
        context.update({'free_machines': free_machines})
        return context

    def get_queryset(self, *args, **kwargs):
        return self.model.objects.filter(request_id=self.kwargs['request_id'])

    def post(self, request, *args, **kwargs):
        item_id = self.request.POST.get('item_id')
        port = self.request.POST.get('port')
        quantity = self.request.POST.get('count')

        response = mssql.execute_procedure(
            'dbo._set_order', item_id, port, quantity)
        if len(response[0]['msg']) > 0:
            messages.error(request, response[0]['msg'])
        return redirect(self.request.path_info)


def RequestDestibutionClear(request):
    if request.method == "POST":
        item_id = request.POST.get('item_id')
        next = request.POST.get('next', '')
        response = mssql.execute_procedure(
            'dbo._clear_orders', item_id)
    return redirect(next)


def RequestAuto(request):
    if request.method == "POST":
        response = mssql.execute_procedure(
            'dbo._automatic_distribution_machines')
        return redirect(reverse_lazy('main'))


def RequestApprove(request):
    if request.method == "POST":
        request_id = request.POST.get('request_id')
        next = request.POST.get('next', '')
        executable_path = settings.BASE_DIR.joinpath(
            'tools').joinpath('rest_sender.exe')
        file.run_executable(
            executable_path, f'-param1 {request_id} -mode approve')
    return redirect(next)


class SignInView(TemplateView):
    template_name = "memec/signin.html"

    def post(self, request, *args, **kwargs):
        context = self.get_context_data(**kwargs)
        username = self.request.POST.get('login', None)
        password = self.request.POST.get('password', None)
        if username and password:
            user = authenticate(
                self.request, username=username, password=password)
            if user is not None:
                login(self.request, user)
                return redirect(reverse_lazy(self.request.GET.get('next', 'main')))
            else:
                messages.error(request, 'Введенные логин или пароль неверны')
        else:
            messages.error(request, 'Введите данные пользователя')
        return render(request, self.template_name)


def SignOut(request):
    logout(request=request)
    return redirect(reverse_lazy('main'))
