<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    function fromSecondsToTime(dif) {
      let seconds = dif % 60;
      let minutes = Math.floor((dif / 60) % 60);
      let hours = Math.floor((dif / 3600) % 24);

      hours = (hours < 10) ? "0" + hours : hours;
      minutes = (minutes < 10) ? "0" + minutes : minutes;
      seconds = (seconds < 10) ? "0" + seconds : seconds;

      return hours + ":" + minutes + ":" + seconds;
    }

    function loadTrack() {
      $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/user/track',
        dataType: 'json'
      }).done(function (data) {
        let table = '<table class="table" style="table-layout: fixed; text-align: center">';
        table +=
                '<thead>' +
                '<tr>' +
                '<th style="text-align: center">Пришел</th>' +
                '<th>Ушел</th>' +
                '<th>Время пребывания</th>' +
                '</tr>' +
                '</thead>';
        table += '<tbody>';

        let fullTime = 0;
        data.forEach(el => {
          let came = new Date(Date.parse(el.came));
          let gone = (el.gone != null) ? new Date(Date.parse(el.gone)) : new Date();
          let dif = Math.round((gone.getTime() - came.getTime()) / 1000);
          fullTime += dif;

          table += '<tr>' +
                  '<td>'+ came.toLocaleTimeString() + '</td>' +
                  '<td>'+ gone.toLocaleTimeString() + '</td>' +
                  '<td>' + fromSecondsToTime(dif) + '</td>' +
                  '</tr>';
        })

        table += '</tbody>';
        table += '</table>';

        $('#track').html(table);
        $('#desc').html(
                '<p>Общее время пребывания на работе: <b>' + fromSecondsToTime(fullTime) + '</b></p>'
        )
      }).fail(function (err) {
        alert(err);
      });
    };

  </script>
  <title>Учет рабочего времени</title>
</head>

<body>
<div class="container pt-3">
  <div class="row align-items-center">
    <div style="margin-right: auto;">
      <span>Статус: </span>
      <span>${user.status.name}</span>
    </div>
    <div style="margin-left: auto;">
      <ul class="nav">
        <li class="nav-item">
          <a class="nav-link" href="#">${user.username}</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<c:url value='/logout'/>">Выйти</a>
        </li>
      </ul>
    </div>
  </div>

  <div class="row">
    <table style="width: 100%; table-layout: fixed">
      <tr>
        <td>
          <form action="<c:url value='/user/came'/>" method='post'>
            <button type="submit" class="btn btn-secondary btn-block">Пришел</button>
          </form>
        </td>
        <td>
          <form action="<c:url value='/user/gone'/>" method='post'>
            <button type="submit" class="btn btn-secondary btn-block">Ушел</button>
          </form>
        </td>
        <td>
          <button class="btn btn-secondary btn-block" onclick="loadTrack()">Отработал</button>
        </td>
      </tr>
    </table>
  </div>

  <div class="row">
    <div class="card" id="track">
    </div>
  </div>

  <div class="row">
    <div id="desc">
    </div>
  </div>
</div>
</body>
</html>