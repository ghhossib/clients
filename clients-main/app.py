from multiprocessing.connection import Client

from bcrypt import *

from flask import Flask, render_template, request, redirect

from Controllers.ClientController import ClientController
from Controllers.UserController import UserController
from flask_login import LoginManager, login_required, login_user, logout_user, current_user

# создать объект класса Flask
application = Flask(__name__)
application.secret_key = "BOOM"
# это объект управляет авторизацией
login_manager = LoginManager(application)
@login_manager.user_loader
def user_loader(id):
    return UserController.show(int(id))




#Добавить методы работы с данными POST и GET
@application.route('/',methods = ['POST', 'GET'])

@application.route('/')
def home():
    title = "Вход"
    message = ''
    #переменной логин передается строка из формы
    login = request.form.get('login')
    password = request.form.get('password')
    #Проверка метода
    if request.method == 'POST':
       if UserController.auth(login, password):
           login_user(UserController.show_login(login))
           if UserController.show_login(login).role == 'Administrator':
                return redirect('/admin')
           elif UserController.show_login(login).role == 'Manager':
                return redirect('/manager')
           else:
                return redirect('/analyst')
    else:
           message = 'неверный логин или пароль'
    return render_template('login.html',
                           title = title,
                           message = message

                            )



@application.route('/admin',methods=['GET','POST'])
@login_required
def admin():
    title = "Админ панель"
    # Услови при котором открывается страница admin
    if current_user.role == "Administrator":
        users = UserController.get()

        if request.method == 'POST':
            name = request.form.get('username')
            role = request.form.get('role')

            UserController.registration(name,name,'111111',role)
            return redirect('/admin')

        return render_template('admin.html',
                           title = title, users=users)
    else:
        return redirect('/logout')


#маршрут обновления пользователя
@application.route('/user/<int:id>', methods=['GET', 'POST'])
@login_required
def user_update(id):
    title = "Обновление пользвателя"
    if current_user.role == "Administrator":
        user = UserController.show(id)
        if request.method == 'POST':
            #получаем значения введеное в поле формы по имени fullname

            fullname = request.form.get('fullname')
            role = request.form.get('role')
            # передаю значения полей в метод обновления
            UserController.update(id, username=fullname, role=role)

            #Возращение пользователя обратно после заполнения
            return redirect('/admin')

        return render_template('edit_user.html',
                               title=title, user=user)



@application.route('/client/<int:id>', methods=['GET', 'POST'])
@login_required
def client_update(id):
    title = "Панель Менеджера"
    if current_user.role == "Manager":
        client = ClientController.show(id)
        if request.method == 'POST':
            #получаем значения введеное в поле формы по имени fullname
            firstName = request.form.get('firstName')
            lastName = request.form.get('lastName')
            phoneNumber = request.form.get('phoneNumber')
            email = request.form.get('email')
            address = request.form.get('address')
            # передаю значения полей в метод обновления
            ClientController.update(id, firstName=firstName,lastName=lastName,phoneNumber=phoneNumber,email=email,address=address)

            #Возращение пользователя обратно после заполнения
            return redirect('/manager')

        return render_template('edit_client.html',
                               title=title, client=client)



@application.route('/client/delete/<int:id>')
@login_required
def client_delete(id):
    if current_user.role == "Manager":
        ClientController.delete(id)
        return redirect('/manager')
    else:
        return redirect('/logout')


#удаление пользователя
@application.route('/user/delete/<int:id>')
@login_required
def user_delete(id):
    if current_user.role == "Administrator":
        UserController.delete(id)
        return redirect('/admin')
    else:
        return redirect('/logout')




@application.route('/analyst')
@login_required
def analyst():
    title = "Аналитика"
    if current_user.role == "Analyst":
        return render_template('analitics.html',
                           title = title)
    else:
        return redirect('/logout')


@application.route('/edit_client/')
def edit_client():
    title = "Изменить клиента"
    return render_template('edit_client.html',
                           title = title)

@application.route('/edit_user')
def edit_user():
    title = "Изменить пользователя"
    return render_template('edit_user.html',
                           title = title)

@application.route('/manager',methods=['GET','POST'])
@login_required # проверяет авторизацию
def manager():
    title = "Панель менеджера"
    if current_user.role == "Manager":
        clients = ClientController.get()

        if request.method == 'POST':
            firstName = request.form.get('firstName')
            lastName = request.form.get('lastName')
            phoneNumber = request.form.get('phoneNumber')
            email = request.form.get('email')
            address = request.form.get('address')

            ClientController.add(1,2,3,4,1)

        return render_template('manager.html',
                           title = title, clients=clients)
    else:
        return redirect('/logout')

@application.route('/work')
def work():
    title = "Окно работы с клиентом"
    return render_template('work.html',
                           title = title)
# Выход из системы
@application.route('/logout')
def logout():
    logout_user()
    return redirect('/')
if __name__ == "__main__":
    application.run(debug=True)