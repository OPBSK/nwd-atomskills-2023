from django.urls import path
from memec.views import main

urlpatterns = [
    path('', main.MainView.as_view(), name="main")
]
