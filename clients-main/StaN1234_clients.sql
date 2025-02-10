-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Фев 10 2025 г., 08:52
-- Версия сервера: 8.0.13
-- Версия PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `StaN1234_clients`
--

-- --------------------------------------------------------

--
-- Структура таблицы `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `firstName` varchar(10) NOT NULL,
  `lastName` varchar(15) NOT NULL,
  `phoneNumber` varchar(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `status` varchar(14) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `clients`
--

INSERT INTO `clients` (`id`, `firstName`, `lastName`, `phoneNumber`, `email`, `address`, `status`) VALUES
(1, 'Ivan', 'Ivanov', '800000000', 'ivan@iavn.iv', 'Salekhard', 'Потенциальный'),
(3, 'Petr', 'Petrov', '89080000000', 'ivan@iavn.iv', 'Salekhard', 'Потенциальный'),
(4, 'Petr', 'Petrov', '89080000000', 'ivan@iavn.iv', 'Salekhard', 'Потенциальный'),
(5, 'Petr', 'Petrov', '89080000000', 'ivan@iavn.iv', 'Salekhard', 'Потенциальный'),
(6, 'Petr', 'Petrov', '89080000000', 'ivan@iavn.iv', 'Salekhard', 'Потенциальный'),
(7, 'Petr', 'Petrov', '89080000000', 'ivan@iavn.iv', 'Salekhard', 'Потенциальный'),
(8, 'Petr', 'Petrov', '89080000000', 'ivan@iavn.iv', 'Salekhard', 'Потенциальный');

-- --------------------------------------------------------

--
-- Структура таблицы `interactions`
--

CREATE TABLE `interactions` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `type` varchar(15) NOT NULL,
  `result` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `interactions`
--

INSERT INTO `interactions` (`id`, `client_id`, `date`, `type`, `result`) VALUES
(1, 1, '2025-01-21', 'Письмо', 'Отсутсвует'),
(3, 1, '2025-01-16', 'Звонок', 'Никакой'),
(4, 1, '2025-01-16', 'Звонок', 'Никакой');

-- --------------------------------------------------------

--
-- Структура таблицы `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `generatedDate` date NOT NULL,
  `data` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `reports`
--

INSERT INTO `reports` (`id`, `generatedDate`, `data`) VALUES
(1, '2025-01-17', '2');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `login` varchar(8) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `login`, `password`, `role`) VALUES
(27, 'student', 'student', '$2b$12$Fy2xCzZYizgzgm30rXaMdOxcJxRYmG4Qx/0SV44JtFfT5Mj.4V7O6', 'Manager'),
(52, 'asdasda', 'asdasda', '$2b$12$eInlj.A5TWpTTOIuRwrcRut8KHbHzRTSfT8V02ZOTC3mvR7fa7Z/u', 'Manager'),
(48, 'manager', 'manager', '$2b$12$8mEUbNRCjytY58BJFJndY.v8Z/qwC7emBDEczNx6S2J4jEUt5tdmW', 'Manager'),
(49, 'admin', 'admin', '$2b$12$kdBARoLBrhzOCjRpc4QfH.G0Qpv6kIX2AI48Yl7YzycNzoPceArUy', 'Administrator');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `interactions`
--
ALTER TABLE `interactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interactions_client_id` (`client_id`);

--
-- Индексы таблицы `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `interactions`
--
ALTER TABLE `interactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
