#! /bin/bash

#altere a pasta final para mudar o tipo do programa.

cd /home/pi/app/contagem-garrafas/serverContagem

venv/bin/python manage.py runserver 0.0.0.0:8000
