from django.db import connection


def execute_procedure(proc_name, *args):
    cursor = connection.cursor()
    try:
        param_set = ','.join(args)
        cursor.execute(f"EXEC {proc_name} {param_set}")
        if cursor.description:
            fields = [field_md[0] for field_md in cursor.description]
            result_set = [dict(zip(fields, row)) for row in cursor.fetchall()]
        else:
            result_set = None
    finally:
        cursor.close()
    return result_set
