drop table if exists zayavki;
drop table if exists users;
drop table if exists roli;
drop table if exists comments;
drop table if exists detali;
drop table if exists car_model;
drop table if exists type_car;
drop table if exists statuss;

create table roli(
  id_rol int primary key,
  name_rol varchar(15)
);

create table users(
  id_user int primary key,
  FIO varchar(30),
  phone varchar(20),
  login varchar(10),
  pass varchar(10),
  id_rol int, 
  FOREIGN KEY (id_rol) REFERENCES roli(id_rol) on delete cascade
  );


create table detali(
  id_detali int primary key,
  name_detali varchar(20),
  price int
);

create table type_car(
id_carTape int primary key,
name_type varchar(10)
);

create table car_model(
	id_carmodel int primary key,
	name_model text,
	id_carTape int,
  foreign key (id_carTape) references type_car(id_carTape) on delete cascade
);

create table statuss(
id_status int primary key,
name_status varchar(20)
);

create table zayavki(
  id_zayavka int primary key,
  data date,
  id_carmodel int,
  problemDescription text,
  id_status int,
  completionDate date,
  id_detali int,
  id_master int,
  id_client int,
  foreign key (id_status) references statuss(id_status) on delete cascade,
  FOREIGN KEY (id_detali) REFERENCES detali(id_detali) on delete cascade
);

create table comments(
  id_comment int primary key,
  text_comment text,
  id_master int,
  id_zayavka int,
  FOREIGN KEY (id_zayavka) REFERENCES zayavki(id_zayavka) on delete cascade
);

insert into type_car values
(1, N'Легковая'),
(2, N'В Грузовая');

insert into car_model values
(1, 'Hyundai Avante (CN7)', 1),
(2, 'Nissan 180SX', 1),
(3, 'Toyota 2000GT', 1),
(4, 'Citroen Berlingo (B9)', 2),
(5, 'УАЗ 2360', 2);

insert into statuss values
(1, N'Новая заявка'),
(2, N'В процессе ремонта'),
(3, N'Готов к выдаче');

insert into roli values
(1, N'Заказчик'),
(2, N'Менеджер'),
(3, N'Автомеханик');

insert into users values 
(1, N'Белов Александр Давидович', '89210563128', 'login1', 'pass1', 1),
(2, N'Харитонова Мария Павловна','89535078985','login2','pass2', 3),
(3, N'Марков Давид Иванович','89210673849','login3','pass3', 3),
(4, N'Громова Анна Семёновна','89990563748','login4','pass4', 2),
(5, N'Карташова Мария Данииловна','89994563847','login5','pass5', 2),
(6, N'Касаткин Егор Львович','89219567849','login11','pass11', 1),
(7, N'Ильина Тамара Даниловна','89219567841','login12','pass12', 1),
(8, N'Елисеева Юлиана Алексеевна','89219567842','login13','pass13', 1),
(9, N'Никифорова Алиса Тимофеевна','89219567843','login14','pass14', 1),
(10, N'Васильев Али Евгеньевич','89219567844','login15','pass15', 3);

insert into zayavki values
(1, '2023-06-06', 1,'Отказали тормоза.', 2, null, null, 2, 7),
(2, '2023-05-05', 2, 'Отказали тормоза.', 2, null, null,3,8),
(3, '2022-07-07', 3, 'В салоне пахнет бензином.', 3,'2023-01-01', null, 3, 9),
(4, '2023-08-02', 4, 'Руль плохо крутится.', 1, null, null, null, 8),
(5, '2023-08-02', 5, 'Руль плохо крутится.', 1, null, null, null, 9);

insert into comments values
(1, 'Очень странно.', 2, 1), 
(2, 'Будем разбираться!',3, 2),
(3, 'Будем разбираться!',3, 3);

select * from comments;

select id_user, FIO, phone, login, pass, roli.name_rol from users inner join roli on users.id_rol=roli.id_rol;

select id_zayavka, data, type_car.name_type, car_model.name_model, problemDescription, statuss.name_status, completionDate, id_detali, id_master, id_client from zayavki
inner join statuss on zayavki.id_status = statuss.id_status
inner join car_model on zayavki.id_carmodel = car_model.id_carmodel
inner join type_car on car_model.id_carTape = type_car.id_carTape;