from django.urls import path
from memec.views import main, reports, alerts, plan, release
import subprocess
from pathlib import Path

urlpatterns = [
    path('', main.MainListView.as_view(), name="main"),
    path('requests/auto/', main.RequestAuto, name="request_auto"),
    path('requests/destib-clear/', main.RequestDestibutionClear,
         name="request_destib_clear"),
    path('requests/approve/',
         main.RequestApprove, name="request_approve"),
    path('requests/<int:request_id>',
         main.RequestView.as_view(), name="request_view"),
    path('release/', release.ReleaseListView.as_view(), name="release_production"),

    path('reports/', reports.ReportListView.as_view(), name="reports"),
    path('reports/view/', reports.ReportView.as_view(), name="report_view"),

    path('alerts/', alerts.AlertsListView.as_view(), name="alerts"),
    path('ajax/alerts', alerts.ajax_alerts, name="ajax_alerts"),

    path('plan/', plan.PlanListView.as_view(), name="plan"),

    # Auth Views
    path('signin/', main.SignInView.as_view(), name="signin"),
    path('signout/', main.SignOut, name="signout"),
]
