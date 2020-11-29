<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>

    <script>
        function validate() {
            let args = [$('#username'), $('#password')];
            for (let i = 0; i < args.length; i++) {
                if (args[i].val() === '') {
                    let msg = $('#msg');
                    msg.text('Заполните поле: ' + args[i].attr('title'));
                    return false;
                }
            }
            return true;
        }
    </script>

    <title>Учет рабочего времени</title>
</head>
<body>
<div class="container pt-3">
    <div class="row">
        <div class="card" style="width: 100%">
            <div class="card-header">
                Регистрация
            </div>
            <div class="card-body">
                <form name='reg' action="<c:url value='/reg/create'/>" method="post">
                    <div class="form-group">
                        <label for="username">Имя пользователя:</label>
                        <input type="text" class="form-control" id="username" name="username" title="имя пользователя">
                    </div>
                    <div class="form-group">
                        <label for="password">Пароль:</label>
                        <input type="password" class="form-control" id="password" name="password" title="пароль">
                    </div>
                    <button type="submit" class="btn btn-primary" onclick="return validate();">Зарегистрироваться</button>
                    <p id="msg">${errorMessage}</p>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>