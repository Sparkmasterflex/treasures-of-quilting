-- phpMyAdmin SQL Dump
-- version 3.3.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 04, 2011 at 07:42 PM
-- Server version: 5.0.77
-- PHP Version: 5.2.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `toq_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `message` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `contacts`
--


-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE IF NOT EXISTS `images` (
  `id` int(11) NOT NULL auto_increment,
  `attachable_id` int(11) default NULL,
  `attachable_type` varchar(255) default NULL,
  `attachment_file_name` varchar(255) default NULL,
  `attachment_content_type` varchar(255) default NULL,
  `attachment_file_size` int(11) default NULL,
  `attachment_updated_at` datetime default NULL,
  `caption` text,
  `enabled` tinyint(1) NOT NULL default '0',
  `position` int(11) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `attachable_id`, `attachable_type`, `attachment_file_name`, `attachment_content_type`, `attachment_file_size`, `attachment_updated_at`, `caption`, `enabled`, `position`, `created_at`, `updated_at`) VALUES
(1, 1, 'Webpage', 'spools_quilt.jpg', 'image/jpeg', 71978, '2011-05-01 17:44:12', 'spool quilt', 1, 0, '2011-05-01 17:44:15', '2011-05-01 17:44:23'),
(2, 1, 'Webpage', 'blackwhitered.jpg', 'image/jpeg', 262660, '2011-05-01 17:44:12', 'other quilt', 1, 0, '2011-05-01 17:44:15', '2011-05-01 17:44:24'),
(3, 1, 'Webpage', 'blue-stairs.jpg', 'image/jpeg', 34618, '2011-05-01 17:44:14', 'blue stairs', 1, 0, '2011-05-01 17:44:15', '2011-05-01 17:44:26'),
(4, 1, 'Webpage', 'double-four-layout1.jpg', 'image/jpeg', 50532, '2011-05-01 17:44:15', 'double four layout', 1, 0, '2011-05-01 17:44:15', '2011-05-01 17:44:27'),
(5, 4, 'Subpage', 'spools_quilt.jpg', 'image/jpeg', 71978, '2011-05-01 17:49:01', 'spools quilt', 1, 0, '2011-05-01 17:49:02', '2011-05-01 17:49:04'),
(6, 1, 'Subpage', 'spools_quilt.jpg', 'image/jpeg', 71978, '2011-05-01 21:15:16', 'spool quilt', 1, 2, '2011-05-01 21:15:17', '2011-05-01 21:15:58'),
(7, 1, 'Subpage', 'blue-stairs.jpg', 'image/jpeg', 34618, '2011-05-01 21:15:47', 'blue-stairs', 1, 1, '2011-05-01 21:15:48', '2011-05-01 21:15:56');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20110328222359'),
('20110328222428'),
('20110328223724'),
('20110328232023'),
('20110328232226'),
('20110402031810'),
('20110403190256'),
('20110409161859'),
('20110410164321');

-- --------------------------------------------------------

--
-- Table structure for table `subpages`
--

CREATE TABLE IF NOT EXISTS `subpages` (
  `id` int(11) NOT NULL auto_increment,
  `webpage_id` int(11) default NULL,
  `parent` varchar(255) default NULL,
  `page_alias` varchar(255) default NULL,
  `template` int(11) NOT NULL default '20',
  `page_title` varchar(255) default NULL,
  `text` text,
  `updated_by` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `preview_text` text,
  `enabled` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `subpages`
--

INSERT INTO `subpages` (`id`, `webpage_id`, `parent`, `page_alias`, `template`, `page_title`, `text`, `updated_by`, `created_at`, `updated_at`, `preview_text`, `enabled`) VALUES
(1, 3, 'services', 'quilted_purse', 30, 'Quilted purse', 'I have a lot of purses of all types of sports teams and such.', 1, '2011-04-09 19:40:35', '2011-05-01 21:17:47', 'Quilted Eagles Large Purse, black lining, zipper closure, see through pocket in front, Pockets on both sides of inside of purse.', 1),
(2, 4, 'quilts', 'finishing_quilts_tops', 30, 'Finishing Quilts Tops', 'Nam gravida ipsum ut ligula congue tincidunt. Duis nec placerat lectus. Nunc vestibulum, lacus eu tincidunt placerat, orci nisi pretium justo, eu interdum erat libero at urna. \r\n\r\nEtiam augue metus, tincidunt in scelerisque suscipit, sodales quis lorem. Praesent sodales vulputate posuere. Suspendisse posuere posuere ullamcorper. Quisque interdum, tortor non posuere imperdiet, elit dui auctor lorem, in luctus arcu mauris non sem. Nam ipsum mi, euismod ac condimentum id, cursus in orci.', 1, '2011-04-09 19:52:16', '2011-04-10 21:36:38', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ante massa, pellentesque at tempor at, blandit vel quam. Praesent mollis.', 0),
(3, 4, 'quilts', 'custom_quilts', 20, 'Custom Quilts', 'Quisque laoreet purus tempor quam sollicitudin non porta risus condimentum. Integer pellentesque convallis lectus. Phasellus in urna purus, vitae molestie nisl. Etiam viverra tempor nisl sit amet lobortis. Phasellus fermentum nisl in sem luctus adipiscing.\r\n\r\nIn hac habitasse platea dictumst. Pellentesque eleifend ante ut orci vulputate quis ultrices sem viverra. In aliquet placerat orci, sed vehicula quam gravida eu. Praesent auctor bibendum tortor id condimentum. ', 1, '2011-04-09 20:01:56', '2011-04-10 21:37:57', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ante massa, pellentesque at tempor at, blandit vel quam. Praesent mollis.', 1),
(4, 6, 'store', 'sports_purses', 35, 'Sports Purses', 'Nam gravida ipsum ut ligula congue tincidunt. Duis nec placerat lectus. Nunc vestibulum, lacus eu tincidunt placerat, orci nisi pretium justo, eu interdum erat libero at urna. Suspendisse ac magna a mi gravida viverra. Sed velit mauris, suscipit sit amet ultricies sit amet, condimentum non lectus. Nunc augue purus, semper in rutrum vitae, egestas et quam. Ut et ipsum a massa blandit eleifend. Etiam augue metus, tincidunt in scelerisque suscipit, sodales quis lorem. Praesent sodales vulputate posuere. Suspendisse posuere posuere ullamcorper.', 1, '2011-04-09 21:06:28', '2011-05-01 17:58:45', 'Nam gravida ipsum ut ligula congue tincidunt. Duis nec placerat lectus. Nunc vestibulum, lacus eu tincidunt placerat, orci nisi pretium just', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL auto_increment,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `crypted_password` varchar(255) NOT NULL,
  `password_salt` varchar(255) NOT NULL,
  `persistence_token` varchar(255) NOT NULL,
  `single_access_token` varchar(255) NOT NULL,
  `perishable_token` varchar(255) NOT NULL,
  `login_count` int(11) NOT NULL default '0',
  `failed_login_count` int(11) NOT NULL default '0',
  `last_request_at` datetime default NULL,
  `current_login_at` datetime default NULL,
  `last_login_at` datetime default NULL,
  `current_login_ip` varchar(255) default NULL,
  `last_login_ip` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `login`, `email`, `crypted_password`, `password_salt`, `persistence_token`, `single_access_token`, `perishable_token`, `login_count`, `failed_login_count`, `last_request_at`, `current_login_at`, `last_login_at`, `current_login_ip`, `last_login_ip`) VALUES
(1, 'Keith', 'Raymond', 'keith', 'raymondke99@gmail.com', '449433a7c3b8da4bfec1b3b5a1f7ca1a8546809847b144302fb708d3f511ddce666be717aec07b86ab5a5f5877456884408e42b0cbad6444dae0eb723dd58205', '9kfUkR9sxaYaBHV0UHA6', '14eb67f1b4fb1d8be3d67b838f6531a19dfa785b62e4614462b8505b15064291a7c6e2927b5ee73fdcac861dd1183fb6d7ee1aeb2a5b888fef2840122eda1390', 'IM1v8Y31tTJKsQlzvO2D', '97JX0W-TVKefGGgK5q8N', 6, 0, '2011-05-03 22:11:17', '2011-05-02 00:50:50', '2011-05-01 18:30:58', '127.0.0.1', '127.0.0.1'),
(2, 'Ellen', 'Raymond', 'ellen', 'treasuresofquilting@yahoo.com', 'a65a45d26cd35201f04ffc752e544eb09bda1aefa88738647588565112af309bad9696c7c4db01bdeec8b8e71dd682b411193005a3f38755641f74d35cdbd381', 'mBhNBuMKqUS7kDyvA6PE', '6952c06dd04d08cb5d8cd512698fafd1d20ef02cc2a840aac4cdecac8125063d4f939dc41092c264efe03a6d00c75bde2ab6fa35d9b02c8b7cf48200831e277b', 'Au0LQ8wj5n96jUf-LAkB', 'IP2uS2cRLL4KswcPTvsg', 0, 0, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `webpages`
--

CREATE TABLE IF NOT EXISTS `webpages` (
  `id` int(11) NOT NULL auto_increment,
  `page_alias` varchar(255) default NULL,
  `template` int(11) NOT NULL default '20',
  `page_title` varchar(255) default NULL,
  `text` text,
  `updated_by` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `is_root` tinyint(1) NOT NULL default '0',
  `preview_text` text,
  `enabled` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `webpages`
--

INSERT INTO `webpages` (`id`, `page_alias`, `template`, `page_title`, `text`, `updated_by`, `created_at`, `updated_at`, `is_root`, `preview_text`, `enabled`) VALUES
(1, 'treasures', 10, 'Treasures of Quilting', 'I hope you enjoy browsing Our website.\r\n\r\nMy Mother and two Aunts have helped to contribute to making and designing different parts of the Quilts.\r\n\r\nSo let us know if there is something we can do for you, or if you have any questions, you can contact me.', 1, '2011-04-09 19:17:10', '2011-05-02 00:51:41', 1, 'Welcome to Treasures of Quilting. I chose the name so I could have different options to use my long arm along with finishing quilt tops, but also create Quilted items and other crafts and use my imagination.', 1),
(2, 'about', 20, 'About Me', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ante massa, pellentesque at tempor at, blandit vel quam. Praesent mollis pellentesque ante, quis porta nibh pellentesque nec.\r\n\r\nNunc eleifend rhoncus posuere. Pellentesque id enim ipsum, quis tristique ligula. Mauris eu libero vel tellus posuere condimentum. Phasellus id diam leo, vitae feugiat odio. Praesent fermentum, dui ut semper blandit, lacus nisl scelerisque ipsum, quis egestas metus dolor et elit. Sed cursus semper tellus, id mattis lectus dapibus ut.\r\n\r\nClass aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris molestie porttitor dolor, ut consequat tellus ultrices et. Suspendisse condimentum consectetur nulla ut gravida.', 1, '2011-04-09 19:21:58', '2011-04-09 19:21:58', 0, 'This is my about me text. It tells my customers just who I am and why I do what I do. It should be interesting and full of good stuff.', 1),
(3, 'services', 30, 'My Services', 'raesent id augue et lorem laoreet luctus. Aenean et magna vel nulla tincidunt varius. Phasellus consectetur faucibus sapien eu tristique. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.\r\n\r\nNullam dolor massa, condimentum vitae volutpat non, faucibus ac turpis. Praesent vitae neque arcu. Vivamus adipiscing tortor vel ipsum rutrum at ullamcorper orci pellentesque. Pellentesque lorem arcu, commodo ut tempor id, dictum vitae leo.', 1, '2011-04-09 19:32:47', '2011-04-10 17:58:30', 0, 'Here is my services page it describes all the stuff I can do.Nullam congue placerat leo, lobortis mollis felis bibendum in. Cras vulputate.', 1),
(4, 'quilts', 30, 'Quilts', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ante massa, pellentesque at tempor at, blandit vel quam. Praesent mollis pellentesque ante, quis porta nibh pellentesque nec.\r\n\r\nNunc eleifend rhoncus posuere. Pellentesque id enim ipsum, quis tristique ligula. Mauris eu libero vel tellus posuere condimentum. Phasellus id diam leo, vitae feugiat odio. Praesent fermentum, dui ut semper blandit, lacus nisl scelerisque ipsum, quis egestas metus dolor et elit.\r\n\r\nSed cursus semper tellus, id mattis lectus dapibus ut. Class aptent taciti sociosqu ad litora torquent per conubia nostra', 1, '2011-04-09 20:00:49', '2011-04-10 21:37:50', 0, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ante massa, pellentesque at tempor at, blandit vel quam. Praesent mollis.', 1),
(5, 'contact', 20, 'Contact', 'Nullam congue placerat leo, lobortis mollis felis bibendum in. Cras vulputate luctus justo. Nulla facilisis fermentum consectetur. Vivamus interdum, magna sed sodales volutpat, urna libero placerat mauris, nec rutrum eros dolor id leo. Ut adipiscing ligula sed sapien vestibulum nec egestas purus ultricies. Praesent id augue et lorem laoreet luctus.\r\n\r\nAenean et magna vel nulla tincidunt varius. Phasellus consectetur faucibus sapien eu tristique. ', 1, '2011-04-09 20:16:17', '2011-04-09 20:16:17', 0, 'Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus.', 1),
(6, 'store', 30, 'Store', 'Pellentesque eleifend ante ut orci vulputate quis ultrices sem viverra. In aliquet placerat orci, sed vehicula quam gravida eu. Praesent auctor bibendum tortor id condimentum.\r\n\r\nCurabitur varius malesuada augue, non viverra nisi accumsan quis. Nam cursus, mauris vel interdum cursus, nisi lacus bibendum nulla, nec tempor purus enim ut massa. Nam accumsan justo quis nisl sagittis sagittis.', 1, '2011-04-09 20:59:42', '2011-04-10 21:11:08', 0, 'Quisque laoreet purus tempor quam sollicitudin non porta risus condimentum. Integer pellentesque convallis lectus. Phasellus in urna purus, ', 1);

-- --------------------------------------------------------

--
-- Table structure for table `widgets`
--

CREATE TABLE IF NOT EXISTS `widgets` (
  `id` int(11) NOT NULL auto_increment,
  `gadget_id` int(11) NOT NULL,
  `gadget_type` varchar(255) NOT NULL,
  `widget` int(11) NOT NULL,
  `content` text,
  `enabled` tinyint(1) NOT NULL default '0',
  `position` int(11) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `widgets`
--

INSERT INTO `widgets` (`id`, `gadget_id`, `gadget_type`, `widget`, `content`, `enabled`, `position`, `created_at`, `updated_at`) VALUES
(1, 1, 'Webpage', 10, NULL, 1, 0, '2011-05-01 17:44:31', '2011-05-01 17:44:31'),
(6, 1, 'Subpage', 70, NULL, 1, 0, '2011-05-01 21:17:21', '2011-05-01 21:17:21'),
(7, 1, 'Webpage', 60, 'Subpage_4', 0, 0, '2011-05-02 00:51:16', '2011-05-02 00:51:16');
