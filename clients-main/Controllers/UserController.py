from Models.Users import *
from bcrypt import hashpw, gensalt, checkpw




class UserController:
    #CRUD
    # У пользователя должны быть методы Аунтификация Регисртация (Пароль должен быть захеширован)
    # метод регистрации
    @classmethod
    def registration(cls,username,login,password,role):
        hash_password = hashpw(password.encode('utf-8'),gensalt())
        Users.create(username = username,login=login,password=hash_password,role=role)

    #метод проверки логина и пароля - аунтификация
    @classmethod
    def auth(cls,login,password):
        #проверить логин
        if Users.get_or_none(Users.login == login) != None:
            hspassword = Users.get_or_none(Users.login == login).password

            # if Users.get_or_none(Users.login == login).password == password:
            if checkpw(password.encode('utf-8'),hspassword.encode('utf-8')):
                return True
        return False

    #вывода записей из таблицы
    @classmethod
    def get(cls):
        return Users.select()

    #Удалить
    @classmethod
    def delete(cls,*id):
        for user in id:
            Users.delete_by_id(user)
    #Обнавить
    @classmethod
    def update(cls,id,**filds):

        for key, value in filds.items():
            if key == 'password':
                value = hashpw(value.encode('utf-8'), gensalt())

            Users.update({key:value}).where(Users.id == id).execute()

    # Метод вывода информации о пользователе по его логину
    @classmethod
    def show_login(cls,login):
        return Users.get_or_none(Users.login == login)
    # Метод вывода информации о пользователе по его id
    @classmethod
    def show(cls,id):
        return Users.get_or_none(id)


if __name__ == "__main__":
    for user in UserController.get():
        print(user.id, user.username, user.login)
    UserController.registration('manager','manager','manager','Manager')
    UserController.registration('admin','admin','admin','Administrator')
    for user in UserController.get():
        print(user.id, user.username, user.login)
    # for row in UserController.get():
    # print(row.id,row.login, row.password)
    #print(UserController.show(5))


