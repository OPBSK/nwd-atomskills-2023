from django.apps import AppConfig


class MemecConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'memec'

    def ready(self):
        import memec.signals  # Register the signals module
