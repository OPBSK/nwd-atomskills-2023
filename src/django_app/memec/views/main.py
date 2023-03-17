from django.shortcuts import render
from django.views.generic import TemplateView

from .utils import mssql
from .utils import file

# Create your views here.
class MainView(TemplateView):
    template_name = "memec/index.html"

    def get(self, request, *args, **kwargs):
        query = mssql.execute_procedure('dbo._test_proc', '1', '2')
        file.run_executable('rest_loader.exe', '-db AS2033 -login django_user -password django_user -rest https://reqres.in -key qwerty -host HOME-PC\SQLEXPRESS')
        context = {}
        context.update({'result': query})
        return render(request, self.template_name, context)
