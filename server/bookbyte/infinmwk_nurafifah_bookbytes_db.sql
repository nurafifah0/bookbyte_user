-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 10, 2024 at 08:26 PM
-- Server version: 10.3.39-MariaDB-cll-lve
-- PHP Version: 8.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `infinmwk_nurafifah_bookbytes_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_books`
--

CREATE TABLE `tbl_books` (
  `book_id` int(11) NOT NULL,
  `user_id` varchar(11) NOT NULL,
  `book_isbn` varchar(17) NOT NULL,
  `book_title` varchar(200) NOT NULL,
  `book_desc` varchar(2000) NOT NULL,
  `book_author` varchar(100) NOT NULL,
  `book_price` decimal(6,2) NOT NULL,
  `book_qty` int(5) NOT NULL,
  `book_status` varchar(10) NOT NULL,
  `book_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_books`
--

INSERT INTO `tbl_books` (`book_id`, `user_id`, `book_isbn`, `book_title`, `book_desc`, `book_author`, `book_price`, `book_qty`, `book_status`, `book_date`) VALUES
(7, '1', '978-001-257301-24', 'Mind, Body, Kitchen: Transform You & Your Kitchen for a Healthier Lifestyle', 'Millions of people struggle with the ups and downs of dieting. It\'s an outdated cycle-and unnecessary. Stacey Crew, certified health coach and organizing expert, demonstrates that the way to break the cycle and find optimum health is to get your mind right, get your body moving, and get your kitchen in order.', 'Stacey Crew', 10.00, 2, 'New', '2023-12-21 18:29:10.192069'),
(8, '1', '978-445-8750134-7', 'The Power of Habit ', 'At its core, The Power of Habit contains an exhilarating argument: The key to exercising regularly, losing weight, raising exceptional children, becoming more productive, building revolutionary companies and social movements, and achieving success is understanding how habits work.', 'Charles Duhigg', 46.60, 1, 'New', '2023-12-21 18:38:17.004254'),
(9, '1', '987-110-3652147-3', 'Just So Stories', 'Just So Stories is a collection of Rudyard Kipling\'s animal tales in which we learn about \'How the Whale got his Throat\', \'How the Camel got his Hump\', \'How the Rhinoceros got his Skin\', \'How the Leopard got his Spots\', \'The Elephant\'s Child\', \'The Sing-Song of Old Man Kangaroo\', \'The Beginning of the Armadilloes\', \'How the First Letter was Written\', \'How the Alphabet was Made\', \'The Crab that Played with the Sea\', \'The Cat that Walked by Himself\' and \'The Butterfly that Stamped\'. These witty, inventive stories have delighted generations of children.', 'Rudyard Kipling', 15.00, 3, 'New', '2023-12-21 18:41:05.583133'),
(10, '1', '978-001-9215731-5', 'STORY THIEVES', 'STORY THIEVES by James Riley is an action-packed fantasy that blurs the line between real life and fictional worlds. What if you could literally dive into a good book? Bethany can. As the child of a real mother and fictional father, she\'s able to disappear into any paper book.', 'James Riley', 30.00, 5, 'New', '2023-12-21 18:44:53.979314'),
(11, '1', '980-118-3210852-1', 'Bedtime Stories for Kids', 'Whether it be an important lesson or just creating laughs, Uncle Amon provides insightful stories that are sure to bring a smile to your face! His unique style and creativity stand out from other children\'s book authors, because often times he uses his life experiences to tell a tale of imagination and adventure.', ' Uncle Amon', 9.00, 3, 'New', '2023-12-21 18:46:27.482468'),
(12, '1', '985-555-1024736-1', 'The Land of Stories: The Wishing Spell', 'The Land of Stories tells the tale of twins Alex and Conner. Through the mysterious powers of a cherished book of stories, they leave their world behind and find themselves in a foreign land full of wonder and magic where they come face-to-face with fairy tale characters they grew up reading about.', 'Chris Colfer', 35.00, 10, 'New', '2023-12-21 18:49:30.321486'),
(13, '1', '987-887-1205467-2', 'Harry Potter and the Chamber of Secrets', 'The plot follows Harry\'s second year at Hogwarts School of Witchcraft and Wizardry, during which a series of messages on the walls of the school\'s corridors warn that the \"Chamber of Secrets\" has been opened and that the \"heir of Slytherin\" would kill all pupils who do not come from all-magical families.', 'J. K. Rowling', 45.00, 2, 'New', '2023-12-21 18:51:27.497452'),
(14, '1', '987-551-0039752-7', 'Harry Potter and the Order of the Phoenix', 'Harry Potter and the Order of the Phoenix is a thrilling tale of friends banding together to fight against evil. As the danger grows stronger, Harry and his friends form a secret organization called the Order of the Phoenix to defend the wizarding world.', 'J. K. Rowling', 50.00, 5, 'New', '2023-12-21 18:54:28.821700'),
(15, '1', '981-445-3671552-8', 'Harry Potter and the Goblet of Fire', 'The fourth movie in the Harry Potter franchise sees Harry (Daniel Radcliffe) returning for his fourth year at Hogwarts School of Witchcraft and Wizardry, along with his friends, Ron (Rupert Grint) and Hermione (Emma Watson). There is an upcoming tournament between the three major schools of magic, with one participant selected from each school by the Goblet of Fire. When Harry\'s name is drawn, even though he is not eligible and is a fourth player, he must compete in the dangerous contest.', 'J. K. Rowling', 55.00, 15, 'New', '2023-12-21 18:56:56.310316'),
(16, '1', '980-557-2367459-2', 'Harry Potter and the Sorcerer\'s Stone', 'The book is about 11 year old Harry Potter, who receives a letter saying that he is invited to attend Hogwarts, school of witchcraft and wizardry. He then learns that a powerful wizard and his minions are after the sorcerer\'s stone that will make this evil wizard immortal and undefeatable.', 'J. K. Rowling', 43.00, 10, 'New', '2023-12-21 19:00:18.632330'),
(17, '1', '978-998-2583164-5', 'The Book of Life', 'Having returned from their refuge in 16th century London to find a family member dead, Diana and Matthew embark on a mission of revenge, seeking the final pages of the Book of Life, and bringing justice to witches and vampires that have wronged them. Diana is now a member of the de Clermont family.', 'Deborah Harkness', 65.00, 20, 'New', '2023-12-21 19:05:01.986345'),
(18, '1', '978-752-5648557-2', 'Book of Night', 'When a terrible figure from her past returns, Charlie descends into a maelstrom of murder and lies. Determined to survive, she\'s up against a cast of doppelgangers, mercurial billionaires, gloamists, and the people she loves best in the world―all trying to steal a secret that will give them vast and terrible power.', 'Holly Black ', 70.00, 16, 'New', '2023-12-21 19:07:06.197356');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cart`
--

CREATE TABLE `tbl_cart` (
  `cart_id` int(5) NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `book_id` varchar(5) NOT NULL,
  `cart_qty` int(5) NOT NULL,
  `cart_status` varchar(10) NOT NULL,
  `order_id` varchar(5) NOT NULL,
  `cart_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_cart`
--

INSERT INTO `tbl_cart` (`cart_id`, `buyer_id`, `seller_id`, `book_id`, `cart_qty`, `cart_status`, `order_id`, `cart_date`) VALUES
(5, '7', '1', '7', 1, 'Paid', '', '2024-01-14 22:15:12.568572'),
(6, '7', '1', '10', 1, 'Paid', '', '2024-01-14 22:15:20.964141'),
(7, '7', '1', '13', 1, 'Paid', '', '2024-01-14 22:15:29.551999'),
(8, '7', '1', '8', 1, 'New', '', '2024-02-10 19:29:30.371630');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order`
--

CREATE TABLE `tbl_order` (
  `order_id` int(5) NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `order_total` decimal(5,2) NOT NULL,
  `order_date` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `order_status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_order`
--

INSERT INTO `tbl_order` (`order_id`, `buyer_id`, `seller_id`, `order_total`, `order_date`, `order_status`) VALUES
(1, '7', '1', 0.00, '2024-02-09 19:26:01.000000', 'new'),
(2, '7', '1', 0.00, '2024-02-09 19:26:20.000000', 'new'),
(3, '7', '1', 0.00, '2024-02-09 19:26:38.000000', 'new');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(5) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_phone` varchar(12) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_type` varchar(10) NOT NULL,
  `user_address` varchar(800) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_phone`, `user_password`, `user_type`, `user_address`, `user_datereg`) VALUES
(1, 'na@gmail.com', 'nana', '', '8b14cb697a5c1a25281711cec11b7d39a00f9bcc', '', '', '2023-12-11 12:41:51.224432'),
(6, 'jane@gmail.com', 'jane', '', '8b14cb697a5c1a25281711cec11b7d39a00f9bcc', '', '', '2023-12-11 17:00:12.192853'),
(7, 'halim@gmail.com', 'halim', '0109844198', '8b14cb697a5c1a25281711cec11b7d39a00f9bcc', 'Buyer', 'UUM SCHOOL', '2024-01-13 02:30:08.735575');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_books`
--
ALTER TABLE `tbl_books`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_books`
--
ALTER TABLE `tbl_books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  MODIFY `cart_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_order`
--
ALTER TABLE `tbl_order`
  MODIFY `order_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
