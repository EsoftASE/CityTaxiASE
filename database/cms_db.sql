-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2024 at 07:10 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking_list`
--

CREATE TABLE `booking_list` (
  `id` int(30) NOT NULL,
  `ref_code` varchar(100) NOT NULL,
  `client_id` int(30) NOT NULL,
  `cab_id` int(30) NOT NULL,
  `pickup_zone` text NOT NULL,
  `drop_zone` text NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0 = Pending,\r\n1 = Driver has Confirmed,\r\n2 = Pickup,\r\n3 = drop-off,\r\n4 = cancelled',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking_list`
--

INSERT INTO `booking_list` (`id`, `ref_code`, `client_id`, `cab_id`, `pickup_zone`, `drop_zone`, `status`, `date_created`, `date_updated`) VALUES
(2, '202202-00003', 1, 2, 'Sample Pickup Zone 1', 'Sample Drop-off Zone 1', 4, '2022-02-16 13:53:27', '2022-02-16 15:01:16'),
(3, '202202-00003', 1, 2, 'Sample Pickup Zone 1', 'Sample Drop off Zone 1', 3, '2022-02-16 15:33:10', '2022-02-16 15:40:01'),
(4, '202409-00001', 2, 2, 'Chilaw', 'Kurunegala', 4, '2024-09-02 18:59:00', '2024-09-02 19:05:12'),
(5, '202409-00002', 2, 5, 'Chilaw', 'Kuliyapitiya', 3, '2024-09-02 19:05:36', '2024-09-02 19:08:19');

-- --------------------------------------------------------

--
-- Table structure for table `cab_list`
--

CREATE TABLE `cab_list` (
  `id` int(30) NOT NULL,
  `reg_code` varchar(100) NOT NULL,
  `category_id` int(30) NOT NULL,
  `cab_reg_no` varchar(200) NOT NULL,
  `body_no` varchar(100) NOT NULL,
  `cab_model` text NOT NULL,
  `cab_driver` text NOT NULL,
  `driver_contact` text NOT NULL,
  `driver_address` text NOT NULL,
  `password` text NOT NULL,
  `image_path` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cab_list`
--

INSERT INTO `cab_list` (`id`, `reg_code`, `category_id`, `cab_reg_no`, `body_no`, `cab_model`, `cab_driver`, `driver_contact`, `driver_address`, `password`, `image_path`, `status`, `delete_flag`, `date_created`, `date_updated`) VALUES
(1, '202202-00002', 1, 'GBN-2306', '1014', 'Sample', 'Mark Cooper', '09123456789', 'This is a sample address of the cab driver', '9b9f9db750b39853a668cce4467cd942', 'uploads/dirvers/1.png?v=1644981064', 1, 0, '2022-02-16 10:59:12', '2024-09-02 19:10:33'),
(2, '202202-00001', 2, 'CDM-0715', '2306', 'TEst 101', 'George Williams', '09456987123', 'This is the address of the driver.', '9b9f9db750b39853a668cce4467cd942', 'uploads/dirvers/2.png?v=1644981833', 1, 0, '2022-02-16 11:13:30', '2024-09-02 19:10:14'),
(5, '202409-00001', 1, '1234', 'Sport', 'Lamborghini', 'Riza', '0776321457', 'Kurunegala', '9b9f9db750b39853a668cce4467cd942', NULL, 1, 0, '2024-09-02 19:04:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_list`
--

CREATE TABLE `category_list` (
  `id` int(30) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category_list`
--

INSERT INTO `category_list` (`id`, `name`, `description`, `delete_flag`, `status`, `date_created`, `date_updated`) VALUES
(1, '5 Seater Sedan', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis et elit sit amet tristique. Maecenas felis lectus, ullamcorper nec rhoncus vel, auctor id risus. Duis volutpat suscipit nulla sit amet fermentum. Nullam ac turpis at tellus efficitur luctus vel ut leo.', 0, 1, '2022-02-16 10:03:54', NULL),
(2, '6 Seater', 'Quisque iaculis ipsum egestas nisi pharetra, ac laoreet felis tincidunt. Cras id gravida justo. Nulla non gravida risus, vel finibus leo. Phasellus vel eros ligula. Fusce a erat sed quam vehicula convallis.', 0, 1, '2022-02-16 10:08:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `client_list`
--

CREATE TABLE `client_list` (
  `id` int(30) NOT NULL,
  `firstname` text NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` text NOT NULL,
  `gender` text NOT NULL,
  `contact` text NOT NULL,
  `address` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `image_path` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_added` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_list`
--

INSERT INTO `client_list` (`id`, `firstname`, `middlename`, `lastname`, `gender`, `contact`, `address`, `email`, `password`, `image_path`, `status`, `delete_flag`, `date_created`, `date_added`) VALUES
(1, 'Claire', 'C', 'Female', 'Male', '091234569987', 'Block 6 Lot 23, Here Subd., There City, Anywhere, 2306', 'cblake@sample.com', '4744ddea876b11dcb1d169fadf494418', 'uploads/clients/1.png?v=1644995661', 1, 0, '2022-02-16 13:06:42', '2022-02-16 15:14:21'),
(2, 'Angelo', '', 'Male', '', '07763250798', 'No. 56/A 5 \"Prasansa\"\r\nBeach Road', 'angelo.fernando2pac@gmail.com', '9b9f9db750b39853a668cce4467cd942', NULL, 1, 0, '2024-09-02 18:57:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `driver_locations`
--

CREATE TABLE `driver_locations` (
  `id` int(11) NOT NULL,
  `cab_id` int(11) NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `status` enum('available','unavailable') DEFAULT 'available',
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver_locations`
--

INSERT INTO `driver_locations` (`id`, `cab_id`, `latitude`, `longitude`, `status`, `last_update`) VALUES
(1, 1, 7.477800, 80.354000, 'available', '2024-09-04 10:17:26'),
(2, 2, 7.293600, 80.641300, 'available', '2024-09-06 19:03:23');

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Cab Management System'),
(6, 'short_name', 'CMS - PHP'),
(11, 'logo', 'uploads/1644974880_logo.png'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/1644974880_wallpaper.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1, 'Adminstrator', 'Admin', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/1624240500_avatar.png', NULL, 1, '2021-01-20 14:02:37', '2021-06-21 09:55:07'),
(8, 'Samantha Jane', 'Miller', 'sam23', '45bff2a14658fc9b21c6e5e9bf75186b', 'uploads/avatar-8.png?v=1644999240', NULL, 2, '2022-02-16 16:14:00', '2022-02-16 16:14:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking_list`
--
ALTER TABLE `booking_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cab_id` (`cab_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `cab_list`
--
ALTER TABLE `cab_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `category_list`
--
ALTER TABLE `category_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_list`
--
ALTER TABLE `client_list`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`) USING HASH;

--
-- Indexes for table `driver_locations`
--
ALTER TABLE `driver_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cab_id` (`cab_id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking_list`
--
ALTER TABLE `booking_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cab_list`
--
ALTER TABLE `cab_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `category_list`
--
ALTER TABLE `category_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `client_list`
--
ALTER TABLE `client_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `driver_locations`
--
ALTER TABLE `driver_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking_list`
--
ALTER TABLE `booking_list`
  ADD CONSTRAINT `booking_list_ibfk_1` FOREIGN KEY (`cab_id`) REFERENCES `cab_list` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_list_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client_list` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cab_list`
--
ALTER TABLE `cab_list`
  ADD CONSTRAINT `cab_list_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category_list` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `driver_locations`
--
ALTER TABLE `driver_locations`
  ADD CONSTRAINT `driver_locations_ibfk_1` FOREIGN KEY (`cab_id`) REFERENCES `cab_list` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
