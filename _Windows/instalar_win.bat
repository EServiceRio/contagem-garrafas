@ECHO OFF

call:cor f1 "Verificando se o Python está instalado..."

pause

pip --version 2> nul || GOTO :erropip

pip --version | findstr "pip 2"

:erropip

if %errorlevel% equ 0 (
    call:cor f1 "python OK"
) else (
    echo Python não encontrado favor instalar e reiniciar esse script
    pause
    powershell.exe -Command "Start-Process -FilePath 'https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe' -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1' -Wait"
    GOTO :fim
)


call:cor f1 "instalado componentes"

timeout /t 5

pip install django django-cors-headers pymodbustcp django-bootstrap4 django-stdimage

call:cor f1 "verifique se nao ocorreu erros"

pause

call:cor f1 "criando os arquivos de inicialização na area de trabalho e de inicializaçao do SO"

cd ..

type NUL > Contagem.bat
chcp 65001 > nul
echo start chrome --kiosk --fullscreen http://localhost:8000 > Contagem.bat
echo cd /d %cd%\serverContagem >> Contagem.bat
echo python manage.py runserver 0.0.0.0:8000 >> Contagem.bat

set /p desk="Gostaria de criar atalho na area de trabalho (s)/(n)"

if %desk% equ s (copy "Contagem.bat" "c:\%HOMEPATH%\Desktop")

set /p startup="Gostaria de iniciar junto do windowns (s)/(n)"

if %startup% equ s (copy "c:\%HOMEPATH%\Desktop\Contagem.bat" "%appdata%\Microsoft\windows\start menu\programs\startup")

call:cor f1 "vamos começar a configurar o supervisorio"

pause

cd serverContagem
cd config

ren views.py viewsMain.py
ren views#.py views.py

cd ..

call:cor f1 "criando banco de dados"

pause

python manage.py migrate

call:cor f1 "verifique se não ocorreu erro, caso contrario nao continue"

set /p desk="continuar? (s)/(n)"

if %desk% equ n (

cd config
ren views.py views#.py
ren viewsMain.py views.py
GOTO :fim

)

pause

call:cor f1 "criando usuario master, atencao!!! esse não sera o de login"

python manage.py createsuperuser

call:cor f1 "verifique se não ocorreu erro, caso contrario nao continue"

set /p desk="continuar? (s)/(n)"

if %desk% equ n (

cd config
ren views.py views#.py
ren viewsMain.py views.py
GOTO :fim

)

pause

call:cor f1 "faça login e crie uma camera no supervisorio depois aperte control + c e volte aqui no prompt"

pause

call:cor f1 "inicinado o supervisorio aguarade..."

start http://localhost:8000/admin

python manage.py runserver 0.0.0.0:8000

call:cor f1 "finalizando configurações"

pause

cd config
ren views.py views#.py
ren viewsMain.py views.py

cd ..

cd ..

set /p valor="deseja iniciar o supervisorio (s)/(n)"

if %valor% equ n (GOTO :fim)

if %valor% equ N (GOTO :fim)

call:cor f1 "inicinado o supervisorio aguarade..."

start chrome --kiosk --fullscreen http://localhost:8000

cd serverContagem

python manage.py runserver 0.0.0.0:8000

exit
:cor
>%2 (set/p=.) <&1
findstr /a:%1 . %2 con &erase %2
for /f "delims=" %%a in ('cmd /k prompt $h$h ^<^&1') do echo %%a
goto:eof

:fim
