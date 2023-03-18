# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150,
                            db_collation='Cyrillic_General_CI_AS')

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(
        max_length=255, db_collation='Cyrillic_General_CI_AS')
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(
        max_length=100, db_collation='Cyrillic_General_CI_AS')

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(
        max_length=128, db_collation='Cyrillic_General_CI_AS')
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(
        unique=True, max_length=150, db_collation='Cyrillic_General_CI_AS')
    first_name = models.CharField(
        max_length=150, db_collation='Cyrillic_General_CI_AS')
    last_name = models.CharField(
        max_length=150, db_collation='Cyrillic_General_CI_AS')
    email = models.CharField(
        max_length=254, db_collation='Cyrillic_General_CI_AS')
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Contractor(models.Model):
    id = models.IntegerField(primary_key=True)
    inn = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    caption = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'contractor'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(
        db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    object_repr = models.CharField(
        max_length=200, db_collation='Cyrillic_General_CI_AS')
    action_flag = models.SmallIntegerField()
    change_message = models.TextField(db_collation='Cyrillic_General_CI_AS')
    content_type = models.ForeignKey(
        'DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(
        max_length=100, db_collation='Cyrillic_General_CI_AS')
    model = models.CharField(
        max_length=100, db_collation='Cyrillic_General_CI_AS')

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(
        max_length=255, db_collation='Cyrillic_General_CI_AS')
    name = models.CharField(
        max_length=255, db_collation='Cyrillic_General_CI_AS')
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(
        primary_key=True, max_length=40, db_collation='Cyrillic_General_CI_AS')
    session_data = models.TextField(db_collation='Cyrillic_General_CI_AS')
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Items(models.Model):
    id = models.IntegerField(primary_key=True)
    request_id = models.IntegerField(blank=True, null=True)
    product_id = models.IntegerField(blank=True, null=True)
    quantity = models.IntegerField(blank=True, null=True)
    # Field name made lowercase.
    quantityexec = models.IntegerField(
        db_column='quantityExec', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'items'


class Machines(models.Model):
    label = models.CharField(
        primary_key=True, max_length=50, db_collation='Cyrillic_General_CI_AS')
    type = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    port = models.IntegerField(blank=True, null=True)
    current_status = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    report_id = models.IntegerField(blank=True, null=True)
    product_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'machines'


class MachinesCache(models.Model):
    label = models.CharField(
        primary_key=True, max_length=50, db_collation='Cyrillic_General_CI_AS')
    type = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    port = models.IntegerField(blank=True, null=True)
    current_status = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    report_id = models.IntegerField(blank=True, null=True)
    product_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'machines_cache'


class MemecUserprofile(models.Model):
    id = models.BigAutoField(primary_key=True)
    telegramm = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS')
    user = models.OneToOneField(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'memec_userprofile'


class Messages(models.Model):
    msg = models.TextField(
        db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    viewed = models.BooleanField(blank=True, null=True)
    ts = models.DateTimeField(blank=True, null=True)
    type = models.IntegerField(blank=True, null=True)
    send = models.BooleanField(blank=True, null=True)
    report_id = models.IntegerField(blank=True, null=True)
    send_tg = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'messages'


class Orders(models.Model):
    item_id = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    label = models.ForeignKey(
        Machines, models.DO_NOTHING, db_column='label', blank=True, null=True)
    quantity = models.IntegerField(blank=True, null=True)
    priority = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'orders'


class Product(models.Model):
    id = models.IntegerField(primary_key=True)
    code = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    caption = models.CharField(
        max_length=500, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    # Field name made lowercase.
    millingtime = models.IntegerField(
        db_column='millingTime', blank=True, null=True)
    # Field name made lowercase.
    lathetime = models.IntegerField(
        db_column='latheTime', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'product'


class Reports(models.Model):
    label = models.CharField(
        max_length=255, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    title = models.CharField(
        max_length=255, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    body = models.CharField(
        max_length=255, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    description = models.TextField(
        db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    user_name = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    html = models.TextField(
        db_collation='Cyrillic_General_CI_AS', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'reports'


class Request(models.Model):
    id = models.IntegerField(primary_key=True)
    number = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    date = models.DateTimeField(blank=True, null=True)
    description = models.CharField(
        max_length=1000, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    # Field name made lowercase.
    releasedate = models.DateTimeField(
        db_column='releaseDate', blank=True, null=True)
    state = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)
    contractor_id = models.IntegerField(blank=True, null=True)
    report_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'request'


class State(models.Model):
    code = models.CharField(primary_key=True, max_length=50,
                            db_collation='Cyrillic_General_CI_AS')
    caption = models.CharField(
        max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'state'


class MessagesView(models.Model):
    id = models.IntegerField(primary_key=True)
    msg = models.TextField(blank=True, null=True)
    viewed = models.BooleanField(blank=True, null=True)
    ts = models.DateTimeField(blank=True, null=True)
    type = models.IntegerField(blank=True, null=True)
    send = models.BooleanField(blank=True, null=True)
    report_id = models.IntegerField(blank=True, null=True)
    port = models.CharField(max_length=50)

    class Meta:
        managed = False  # Created from a view. Don't remove.
        db_table = '_messages'


class ReportsView(models.Model):
    id = models.IntegerField(primary_key=True)
    label = models.CharField(max_length=255, blank=True, null=True)
    title = models.CharField(max_length=255, blank=True, null=True)
    body = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    user_name = models.CharField(max_length=50, blank=True, null=True)
    html = models.TextField(blank=True, null=True)
    port = models.CharField(max_length=50)

    class Meta:
        managed = False  # Created from a view. Don't remove.
        db_table = '_reports'


class Requests(models.Model):
    request_id = models.IntegerField(primary_key=True)
    number = models.CharField(max_length=50, blank=True, null=True)
    date = models.DateTimeField(blank=True, null=True)
    description = models.CharField(max_length=1000, blank=True, null=True)
    # Field name made lowercase.
    releasedate = models.DateTimeField(
        db_column='releaseDate', blank=True, null=True)
    state = models.CharField(max_length=50, blank=True, null=True)
    state_caption = models.CharField(max_length=50, blank=True, null=True)
    contractor_inn = models.CharField(max_length=50, blank=True, null=True)
    contractor_caption = models.CharField(max_length=50, blank=True, null=True)
    report_id = models.IntegerField(blank=True, null=True)
    i_quantity = models.IntegerField(blank=True, null=True)
    o_quantity = models.IntegerField(blank=True, null=True)
    state_order = models.CharField(max_length=23)
    state_order_int = models.IntegerField()

    class Meta:
        managed = False  # Created from a view. Don't remove.
        db_table = '_requests'


class RequestItems(models.Model):
    request_id = models.IntegerField(primary_key=True)
    number = models.CharField(max_length=50, blank=True, null=True)
    date = models.DateTimeField(blank=True, null=True)
    description = models.CharField(max_length=1000, blank=True, null=True)
    # Field name made lowercase.
    releasedate = models.DateTimeField(
        db_column='releaseDate', blank=True, null=True)
    contractor_caption = models.CharField(max_length=50, blank=True, null=True)
    quantity = models.IntegerField(blank=True, null=True)
    product_code = models.CharField(max_length=50, blank=True, null=True)
    product_caption = models.CharField(max_length=500, blank=True, null=True)
    item_id = models.IntegerField(blank=True, null=True)
    machines_list = models.CharField(max_length=8000, blank=True, null=True)
    quantity_left_lathe = models.IntegerField(blank=True, null=True)
    quantity_left_milling = models.IntegerField(blank=True, null=True)
    state_order = models.CharField(max_length=23)
    state_order_int = models.IntegerField()

    class Meta:
        managed = False  # Created from a view. Don't remove.
        db_table = '_request_items'


class FreeMachines(models.Model):
    label = models.CharField(max_length=50)
    type_caption = models.CharField(max_length=9, blank=True, null=True)
    type = models.CharField(max_length=50, blank=True, null=True)
    port = models.IntegerField(primary_key=True)

    class Meta:
        managed = False  # Created from a view. Don't remove.
        db_table = '_free_machines'
