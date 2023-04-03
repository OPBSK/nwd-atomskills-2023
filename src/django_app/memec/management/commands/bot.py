from django.core.management.base import BaseCommand
from telebot import TeleBot
import threading
import time

from ...models import *

# Объявление переменной бота
bot = TeleBot('', threaded=True)
chat_id = 0


@bot.message_handler(commands=['start'])
def start(m, res=False):
    chat_id = m.from_user.id
    bot.send_message(
        chat_id, "Спасибо ❤️, что инициализировали меня, я буду смотреть сообщения каждую 1 минуту для вас. Если что-то будет, то я отправлю вам это!")
    t = threading.Thread(target=check_for_messages(chat_id))
    t.start()


def check_for_messages(chat_id):
    while True:
        result_set = get_messages_sql()
        for item in result_set:
            item.send_tg = 1
            item.save()
            bot.send_message(chat_id, item.msg)
        time.sleep(60)


def get_messages_sql():
    return Messages.objects.filter(send_tg=0).exclude(type=1)


class Command(BaseCommand):
    # Используется как описание команды обычно
    help = 'Implemented to Django application telegram bot setup command'

    def handle(self, *args, **kwargs):
        bot.enable_save_next_step_handlers(delay=2)  # Сохранение обработчиков
        bot.load_next_step_handlers()								# Загрузка обработчиков
        print("Telegram Bot Start...OK")
        bot.infinity_polling()
