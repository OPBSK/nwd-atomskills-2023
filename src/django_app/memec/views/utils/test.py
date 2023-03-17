# получение ролей
l = request.user.groups.values_list('name',flat = True) # QuerySet Object
l_as_list = list(l)                                     # QuerySet to `list`
print(l_as_list)