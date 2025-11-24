-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 24, 2025 at 11:25 AM
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
-- Database: `alluring_decors`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `bill_number` varchar(30) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `net_amount` decimal(12,2) NOT NULL,
  `generated_at` datetime DEFAULT current_timestamp(),
  `due_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`bill_id`, `request_id`, `bill_number`, `total_amount`, `tax_amount`, `discount_amount`, `net_amount`, `generated_at`, `due_date`, `notes`, `is_paid`) VALUES
(1, 2, 'BILL2025001', 1850000.00, 277500.00, 92500.00, 2035000.00, '2025-01-22 10:00:00', '2025-02-22', 'Office setup for fintech company - 25 employees. Includes furniture, partitions, and lighting.', 0),
(2, 5, 'BILL2025002', 2750000.00, 412500.00, 137500.00, 3025000.00, '2025-02-12 14:30:00', '2025-03-12', 'Wedding venue decoration for 200 guests. Includes stage design, lighting, and floral arrangements.', 0),
(3, 6, 'BILL2025003', 1650000.00, 247500.00, 82500.00, 1815000.00, '2025-02-18 09:15:00', '2025-03-18', 'Law firm office design in Kisumu. Traditional-modern blend with library space.', 1),
(4, 7, 'BILL2025004', 3200000.00, 480000.00, 160000.00, 3520000.00, '2025-02-22 11:45:00', '2025-03-22', 'Luxury villa interior in Karen. High-end finishes and smart home integration.', 0),
(5, 8, 'BILL2025005', 1350000.00, 202500.00, 67500.00, 1485000.00, '2025-02-27 16:20:00', '2025-03-27', 'Coffee shop design in Westlands. Industrial theme with outdoor patio.', 1),
(6, 9, 'BILL2025006', 1950000.00, 292500.00, 97500.00, 2145000.00, '2025-03-03 13:10:00', '2025-04-03', 'Conference hall in Nakuru. Multi-purpose with AV integration.', 1),
(7, 10, 'BILL2025007', 4800000.00, 720000.00, 240000.00, 5280000.00, '2025-03-07 15:30:00', '2025-04-07', 'Tech company headquarters in Upper Hill. 100+ employees with labs and collaboration zones.', 0),
(8, 11, 'BILL2025008', 2850000.00, 427500.00, 142500.00, 3135000.00, '2025-03-12 12:00:00', '2025-04-12', 'Beach hotel renovation in Mombasa. Coastal luxury theme.', 0),
(9, 12, 'BILL2025009', 1150000.00, 172500.00, 57500.00, 1265000.00, '2025-03-17 10:45:00', '2025-04-17', 'Asian fusion restaurant in Westlands. Open kitchen and private dining.', 1);

--
-- Triggers `bills`
--
DELIMITER $$
CREATE TRIGGER `calc_net_amount` BEFORE INSERT ON `bills` FOR EACH ROW SET NEW.net_amount = NEW.total_amount + NEW.tax_amount - NEW.discount_amount
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `contact_id` int(11) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `address` text NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `map_url` varchar(255) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`contact_id`, `label`, `address`, `phone`, `email`, `map_url`, `is_primary`, `is_active`) VALUES
(1, 'Head Office', '40100', '0707868194', 'osumbaevans21@gmail.com', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `content_sections`
--

CREATE TABLE `content_sections` (
  `section_id` int(11) NOT NULL,
  `section_key` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `content` text NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content_sections`
--

INSERT INTO `content_sections` (`section_id`, `section_key`, `title`, `content`, `is_active`, `updated_at`, `updated_by`) VALUES
(1, 'home_center', 'Why Choose Alluring Decors?', 'At Alluring Decors, we don\'t just design spaces, we craft experiences. With over 5 years of excellence in interior and exterior design, we transform ordinary spaces into extraordinary environments that reflect your unique personality and lifestyle. Our team of creative designers and skilled artisans work closely with you to ensure every detail, from concept to completion, exceeds your expectations. Choose us for innovative designs, impeccable craftsmanship, and a seamless process that turns your vision into a stunning reality.', 1, '2025-11-21 08:21:02', NULL),
(2, 'about_us', 'Our Story', 'Founded with a passion for creating beautiful, functional spaces, Alluring Decors has been transforming homes and businesses for over 5 years. We specialize in bespoke interior and exterior designs that blend aesthetics with practicality. Our portfolio spans luxurious residences, professional offices, restaurants, and event spaces, each project reflecting our commitment to quality, innovation, and client satisfaction.', 1, '2025-11-21 08:20:45', NULL),
(3, 'our_vision', 'Our Vision', 'To be the most trusted and innovative design partner, creating spaces that inspire, comfort, and transform lives. We envision a world where every environment reflects the beauty and potential of its inhabitants.', 1, '2025-11-21 08:19:52', NULL),
(4, 'our_mission', 'Our Mission', 'To deliver exceptional, personalized design solutions that exceed client expectations. We combine creative vision with technical expertise to create functional, beautiful spaces that stand the test of time.', 1, '2025-11-21 08:19:52', NULL),
(5, 'our_approach', 'Our Design Philosophy', 'We believe that great design is a balance of form and function. Our approach starts with deep listening, understanding your needs, lifestyle, and aspirations. Through collaborative design, meticulous planning, and flawless execution, we create spaces that are not only beautiful but also enhance your daily life.', 1, '2025-11-21 08:20:32', NULL),
(6, 'services_overview', 'Comprehensive Design Services', 'From complete home transformations to commercial space planning, we offer end-to-end design solutions. Our services include space planning, furniture selection, color consultation, lighting design, and project management, all tailored to your unique vision, budget, and timeline.', 1, '2025-11-21 08:21:19', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE `domains` (
  `domain_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `icon_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `domains`
--

INSERT INTO `domains` (`domain_id`, `name`, `description`, `icon_url`, `is_active`) VALUES
(1, 'Home Decoration', 'Complete interior and exterior design for residential spaces including living rooms, bedrooms, kitchens, bathrooms, gardens, and outdoor living areas. We transform houses into personalized homes that reflect your unique style and family needs.', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&w=400&q=80', 1),
(2, 'Office Decoration', 'Professional workspace design for corporations, startups, and professional firms. Includes executive suites, workstations, conference rooms, reception areas, and collaborative spaces that enhance productivity and corporate identity.', 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?ixlib=rb-4.0.3&w=400&q=80', 1),
(3, 'Banquet & Function Halls', 'Comprehensive decoration services for community halls, function halls, and banquet facilities. Perfect for weddings, parties, office meetings, seminars, conferences, and social gatherings. We create the perfect ambiance for every occasion.', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?ixlib=rb-4.0.3&w=400&q=80', 1),
(4, 'Restaurant Decoration', 'Complete interior design solutions for restaurants, cafes, and food establishments. Includes dining areas, bars, kitchen layout optimization, exterior signage, and creating atmospheres that enhance the culinary experience and customer satisfaction.', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&w=400&q=80', 1);

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `faq_id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`faq_id`, `question`, `answer`, `display_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'What services does Alluring Decors offer?', 'We offer comprehensive interior and exterior design services including home decoration, office design, banquet hall decoration, restaurant design, and landscape design. Our services cover space planning, furniture selection, lighting design, color consultation, and complete project management.', 1, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(2, 'How long does a typical interior design project take?', 'Project timelines vary based on scope and complexity. A single room refresh may take 2-4 weeks, while complete home renovations typically require 8-12 weeks. Office designs range from 4-8 weeks, and larger commercial projects may take 12-16 weeks. We provide detailed timelines during our initial consultation.', 2, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(3, 'Do you work within a specific budget range?', 'Yes, we work with various budget levels. Our projects range from KES 500,000 for basic room makeovers to KES 10+ million for comprehensive commercial designs. We prioritize maximizing your budget while ensuring quality results and transparent pricing throughout the project.', 3, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(4, 'Can you work with my existing furniture and decor?', 'Absolutely! We specialize in integrating existing pieces with new designs. During our consultation, we assess your current furniture and recommend what to keep, refurbish, or replace. This approach often saves costs while creating a cohesive design that reflects your personal style.', 4, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(5, 'What is your design process?', 'Our process includes: 1) Initial consultation to understand your needs, 2) Concept development and presentation, 3) Detailed design planning, 4) Implementation and project management, and 5) Final walkthrough and handover. We maintain clear communication at every stage to ensure your vision is realized.', 5, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(6, 'Do you handle permits and approvals for commercial projects?', 'Yes, for commercial projects we manage all necessary permits and regulatory approvals. Our team has experience working with local authorities and understands the requirements for different types of commercial spaces including restaurants, offices, and hospitality venues.', 6, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(7, 'What payment methods do you accept?', 'We accept multiple payment methods including bank transfers, M-Pesa, credit/debit cards, and cash. For larger projects, we typically work with a payment schedule: 30% deposit, 40% upon project commencement, and 30% upon completion.', 7, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(8, 'Do you offer virtual design consultations?', 'Yes, we offer virtual consultations for clients who cannot meet in person. These include video calls, digital mood boards, and 3D renderings. Virtual consultations are particularly popular for clients outside Nairobi or with busy schedules.', 8, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(9, 'What makes Alluring Decors different from other design firms?', 'Our unique approach combines creative vision with practical functionality. We focus on understanding your lifestyle and needs, use high-quality sustainable materials, provide personalized service with dedicated project managers, and ensure timely completion without compromising on quality.', 9, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(10, 'Do you provide warranty or post-completion support?', 'Yes, we offer a 1-year warranty on all our workmanship and materials. We also provide post-completion support for any adjustments or minor fixes needed. Our relationship with clients continues beyond project completion to ensure long-term satisfaction.', 10, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(11, 'Can you work on projects outside Nairobi?', 'Absolutely! We serve clients throughout Kenya including Mombasa, Kisumu, Nakuru, and Eldoret. For out-of-town projects, we coordinate site visits, local contractors, and remote project management to ensure seamless execution regardless of location.', 11, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(12, 'How do I get started with my project?', 'Getting started is easy! Contact us through our website, email, or phone to schedule a complimentary initial consultation. During this meeting, we discuss your vision, budget, timeline, and answer any questions. From there, we develop a customized proposal for your review.', 12, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(13, 'Do you offer eco-friendly and sustainable design options?', 'Yes, we strongly believe in sustainable design. We offer eco-friendly materials, energy-efficient lighting, water-saving fixtures, and sustainable furniture options. We can also incorporate indoor plants and natural ventilation systems to create healthier living environments.', 13, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(14, 'What happens if I need to make changes during the project?', 'We understand that needs may evolve during a project. We have a flexible change order process where we discuss any modifications, their impact on timeline and budget, and get your approval before proceeding. Clear communication ensures changes are handled smoothly.', 14, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37'),
(15, 'Do you provide 3D visualizations of the proposed design?', 'Yes, we provide detailed 3D renderings and virtual walkthroughs for most projects. These visualizations help you understand the proposed design, make informed decisions, and ensure the final result matches your expectations before implementation begins.', 15, 1, '2025-11-24 13:04:37', '2025-11-24 13:04:37');

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `feedback_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `message` text NOT NULL,
  `type` enum('general','suggestion','complaint','question','compliment') DEFAULT 'general',
  `is_read` tinyint(1) DEFAULT 0,
  `submitted_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`feedback_id`, `user_id`, `name`, `email`, `message`, `type`, `is_read`, `submitted_at`) VALUES
(1, 4, 'James Muthoni', 'james.muthoni@outlook.com', 'Absolutely thrilled with the home renovation! The team at Alluring Decors transformed our outdated house into a modern masterpiece. The attention to detail and quality of work exceeded our expectations. Highly recommended!', 'compliment', 1, '2025-03-20 14:30:00'),
(2, 5, 'Wanjiru Odhiambo', 'wanjiru.odhiambo@gmail.com', 'Our new office space is incredible! The design perfectly captures our company culture while maintaining professionalism. The project was completed on time and within budget. Thank you for making our workspace so inspiring!', 'compliment', 1, '2025-03-18 11:15:00'),
(3, NULL, 'Sarah Johnson', 'sarah.j@corporation.co.ke', 'I attended a wedding at a venue decorated by Alluring Decors and was blown away by the elegance and attention to detail. The lighting, floral arrangements, and overall ambiance were exceptional. Will definitely recommend your services.', 'compliment', 1, '2025-03-15 16:45:00'),
(4, 6, 'Kamar Akinyi', 'kamar.akinyi@yahoo.com', 'Loved the restaurant design work! One suggestion - it would be great if you could provide a digital portfolio of your previous projects on your website. This would help potential clients visualize what you can do for them.', 'suggestion', 1, '2025-03-12 09:20:00'),
(5, NULL, 'Michael Chen', 'michael.chen@business.com', 'Your designs are fantastic! Consider offering virtual design consultations for clients outside Nairobi. This would expand your reach to clients across East Africa who admire your work but can\'t visit in person.', 'suggestion', 0, '2025-03-10 13:40:00'),
(6, 7, 'Brian Chege', 'brian.chege@hotmail.com', 'Hello, I\'m interested in eco-friendly design options for my upcoming project. Do you offer sustainable materials and energy-efficient lighting solutions? Could you provide more information about your green design capabilities?', 'question', 1, '2025-03-08 10:05:00'),
(7, NULL, 'Grace Wanjiku', 'grace.w@enterprise.co.ke', 'Do you provide 3D renderings of proposed designs before starting the actual work? I\'d like to visualize the final outcome before making a commitment. What is the process and cost for this service?', 'question', 0, '2025-03-05 15:30:00'),
(8, 8, 'David Omondi', 'david.omondi@business.com', 'The communication throughout our project was excellent. Your team kept us informed at every stage and was very responsive to our questions and concerns. This made the entire process stress-free and enjoyable.', 'general', 1, '2025-03-03 12:25:00'),
(9, 13, 'TechInnovate Admin', 'info@techinnovate.co.ke', 'We\'ve been working with Alluring Decors on our new headquarters. The professionalism and creativity your team has demonstrated is remarkable. Looking forward to the completed project!', 'general', 1, '2025-03-01 14:50:00'),
(10, 9, 'Linda Atieno', 'linda.atieno@enterprise.co.ke', 'The custom furniture pieces you designed for our villa are absolutely stunning! The craftsmanship is exceptional and each piece tells a story. Our guests are always complimenting the unique design elements.', 'compliment', 1, '2025-02-28 11:10:00'),
(11, NULL, 'Robert Kimani', 'robert.k@consulting.com', 'I\'ve recommended Alluring Decors to three of my colleagues after seeing the amazing work you did on our office. The space planning expertise particularly impressed me - you maximized our limited space beautifully.', 'compliment', 0, '2025-02-25 16:15:00'),
(12, 10, 'Peter Kamau', 'peter.kamau@industry.org', 'How far in advance should we book your services for a restaurant renovation? We\'re planning to open in 6 months and want to ensure we have enough time for proper planning and execution.', 'question', 1, '2025-02-22 09:45:00'),
(13, 11, 'Mercy Jepkorir', 'mercy.jepkorir@corporation.com', 'The design process was great, but it would be helpful to have a dedicated project manager for larger projects. Sometimes we had to contact multiple people for different questions. A single point of contact would streamline communication.', 'suggestion', 1, '2025-02-20 13:20:00'),
(14, 12, 'Samuel Gitonga', 'samuel.gitonga@firm.co.ke', 'Thank you for the wonderful work on our family home in Eldoret. The team was respectful, professional, and truly understood our vision. The African-themed elements mixed with modern design are exactly what we wanted.', 'general', 1, '2025-02-18 10:35:00'),
(15, 14, 'Sanctuary Hotels Manager', 'management@sanctuaryhotels.com', 'Your design team\'s understanding of hospitality spaces is impressive. They considered both aesthetics and functionality for our high-traffic hotel areas. The materials selected are both beautiful and durable.', 'compliment', 0, '2025-02-15 15:55:00'),
(16, 15, 'Flavors Fusion Owner', 'admin@flavorsfusion.co.ke', 'We love our new restaurant design! Do you offer any maintenance or refresh services? We\'d like to keep the space looking as good as it does now and might need minor updates in the future.', 'question', 1, '2025-02-12 12:05:00'),
(17, NULL, 'Maria Rodriguez', 'maria.rodriguez@designlover.com', 'I follow your work on social media and wanted to say how inspiring your designs are. The way you blend contemporary styles with local cultural elements is truly unique. Keep up the amazing work!', 'general', 0, '2025-02-10 14:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `heroes`
--

CREATE TABLE `heroes` (
  `hero_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `body_text` text NOT NULL,
  `background_image` varchar(500) DEFAULT NULL,
  `primary_button` varchar(100) DEFAULT NULL,
  `primary_button_link` varchar(500) DEFAULT NULL,
  `secondary_button` varchar(100) DEFAULT NULL,
  `secondary_button_link` varchar(500) DEFAULT NULL,
  `display_order` int(11) DEFAULT 1,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `heroes`
--

INSERT INTO `heroes` (`hero_id`, `title`, `subtitle`, `body_text`, `background_image`, `primary_button`, `primary_button_link`, `secondary_button`, `secondary_button_link`, `display_order`, `is_active`, `created_at`, `updated_at`) VALUES
(4, 'Your Dream Space, Curated to Life.', 'Bespoke Interior Design That Tells Your Story.', 'Imagine a home that doesn\'t just look beautiful, but feels uniquely you. At Alluring Decors, we transform your vision into an immersive reality, crafting elegant and functional interiors that inspire your best life. Let\'s begin the journey to your perfect sanctuary.', 'https://images.unsplash.com/photo-1615529182904-14819c35db37?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Begin Your Journey', 'consultation', 'View Our Portfolio', 'portfolio', 1, 1, '2025-11-21 05:15:40', '2025-11-21 05:15:40'),
(5, 'Redefine Your Environment.', 'Where Bold Vision Meets Impeccable Execution.', 'Step beyond the conventional. Alluring Decors creates daring, personalized spaces that are as sophisticated and distinctive as you are. We orchestrate every detail to deliver an unforgettable design experience and a stunning final result.', 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Discover Our Work', 'portfolio', 'Get a Custom Quote', 'contact', 2, 1, '2025-11-21 05:15:40', '2025-11-21 05:15:40'),
(6, 'Timeless Design, Modern Living.', 'Crafting Interiors of Lasting Beauty.', 'We believe in the power of elegant simplicity. Our approach blends classic principles with contemporary flair to create serene, functional, and beautifully curated spaces tailored for how you live today.', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Explore Our Services', 'services', 'Meet Our Designers', 'about', 3, 1, '2025-11-21 05:15:40', '2025-11-21 05:15:40');

-- --------------------------------------------------------

--
-- Table structure for table `media_uploads`
--

CREATE TABLE `media_uploads` (
  `media_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` enum('image','document','video') NOT NULL,
  `file_size` int(11) NOT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `uploaded_at` datetime DEFAULT current_timestamp(),
  `purpose` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `bill_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `paid_at` datetime DEFAULT current_timestamp(),
  `method` enum('cash','mpesa','card','bank') DEFAULT 'cash',
  `reference_no` varchar(50) DEFAULT NULL,
  `receipt_url` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `recorded_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `bill_id`, `amount`, `paid_at`, `method`, `reference_no`, `receipt_url`, `notes`, `recorded_by`) VALUES
(1, 3, 1815000.00, '2025-02-20 14:30:00', 'bank', 'TT2025001', '/receipts/tt2025001.pdf', 'Full payment via bank transfer for law firm office project.', 1),
(2, 5, 1485000.00, '2025-03-01 11:20:00', 'mpesa', 'MPESA8X9Y7Z6', '/receipts/mpesa_8x9y7z6.pdf', 'Full payment via M-Pesa for coffee shop design.', 1),
(3, 6, 2145000.00, '2025-03-05 16:45:00', 'bank', 'TT2025002', '/receipts/tt2025002.pdf', 'Final payment for conference hall project in Nakuru.', 1),
(4, 4, 1760000.00, '2025-02-25 09:30:00', 'mpesa', 'MPESA1A2B3C4', '/receipts/mpesa_1a2b3c4.pdf', '50% advance payment for luxury villa project.', 1),
(5, 9, 1265000.00, '2025-03-20 13:15:00', 'card', 'CRD2025001', '/receipts/card_2025001.pdf', 'Credit card payment for restaurant design project.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `short_description` text DEFAULT NULL,
  `full_description` text DEFAULT NULL,
  `category` enum('ongoing','upcoming','accomplished') NOT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `thumbnail_url` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `title`, `short_description`, `full_description`, `category`, `client_name`, `location`, `start_date`, `end_date`, `thumbnail_url`, `is_featured`, `created_at`, `updated_at`) VALUES
(1, 'Luxury Penthouse Makeover', 'Complete interior transformation of a downtown penthouse', 'This project involved a full renovation of a 3,500 sq ft penthouse in the city center. We redesigned the living areas, master suite, and entertainment spaces with a contemporary luxury aesthetic, featuring custom millwork, smart home integration, and premium finishes throughout.', 'accomplished', 'Private Client', 'Nairobi Westlands', '2024-03-15', '2024-08-20', 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3&w=800&q=80', 1, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(2, 'Corporate Office Redesign', 'Modern workspace for a tech startup', 'Transformed a traditional office space into a collaborative, innovative environment for a growing tech company. Included open-plan workstations, private meeting pods, breakout areas, and a state-of-the-art conference facility with integrated technology.', 'accomplished', 'TechInnovate Ltd', 'Nairobi Upper Hill', '2024-01-10', '2024-04-30', 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?ixlib=rb-4.0.3&w=800&q=80', 1, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(3, 'Serene Family Residence', 'Warm and inviting home interior design', 'Created a family-friendly home that balances style with functionality. Focused on durable materials, ample storage solutions, and a warm color palette that makes the space both beautiful and practical for daily family life.', 'accomplished', 'The Johnson Family', 'Karen, Nairobi', '2024-05-01', '2024-09-15', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&w=800&q=80', 0, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(4, 'Boutique Hotel Lobby', 'Luxury hotel reception and common areas', 'Designed the lobby, lounge, and reception area for a new boutique hotel. Created an immersive experience that reflects local culture while maintaining international luxury standards, featuring custom furniture and artisanal lighting.', 'accomplished', 'Sanctuary Hotels', 'Mombasa', '2024-02-20', '2024-07-10', 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&w=800&q=80', 1, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(5, 'Modern Restaurant Interior', 'Contemporary dining space with outdoor integration', 'Complete interior design for a fine dining restaurant, featuring an open kitchen concept, custom banquette seating, and a seamless transition to an outdoor patio area. Focused on creating intimate dining experiences.', 'ongoing', 'Flavors Fusion', 'Westlands, Nairobi', '2025-01-15', NULL, 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&w=800&q=80', 1, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(6, 'Executive Villa Compound', 'Luxury residential compound design', 'Comprehensive exterior and interior design for a 5-villa compound. Project includes landscape design, pool area, outdoor entertainment spaces, and custom interiors for each villa with unique thematic approaches.', 'ongoing', 'Private Developer', 'Runda, Nairobi', '2025-02-01', NULL, 'https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-4.0.3&w=800&q=80', 0, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(7, 'Medical Center Renovation', 'Healthcare facility modernization', 'Upgrading a medical center with patient-friendly design principles. Creating calming environments with easy navigation, hygienic surfaces, and comfortable waiting areas that reduce patient anxiety.', 'ongoing', 'City Health Partners', 'Nairobi CBD', '2025-03-10', NULL, 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&w=800&q=80', 0, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(8, 'Lakeside Retreat Home', 'Vacation home with panoramic views', 'Designing a weekend retreat home that maximizes lake views and natural light. Features large windows, outdoor living spaces, and a rustic-modern aesthetic that complements the natural surroundings.', 'upcoming', 'Private Client', 'Lake Naivasha', '2025-06-01', '2025-11-30', 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?ixlib=rb-4.0.3&w=800&q=80', 1, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(9, 'Co-working Space Design', 'Flexible workspace for creative professionals', 'Planning a multi-functional co-working space with various work environments - from quiet focus areas to collaborative zones. Includes private offices, meeting rooms, and social spaces with premium amenities.', 'upcoming', 'Creative Hub Kenya', 'Kilimani, Nairobi', '2025-07-15', '2025-12-20', 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?ixlib=rb-4.0.3&w=800&q=80', 0, '2025-11-21 08:32:42', '2025-11-21 08:32:42'),
(10, 'Heritage Home Restoration', 'Preserving history with modern comforts', 'Restoring a historic home while integrating modern amenities. Carefully preserving original architectural features while updating electrical, plumbing, and climate control systems for contemporary living.', 'upcoming', 'Heritage Trust', 'Mombasa Old Town', '2025-08-01', '2026-02-28', 'https://images.unsplash.com/photo-1513584684374-8bab748fbf90?ixlib=rb-4.0.3&w=800&q=80', 0, '2025-11-21 08:32:42', '2025-11-21 08:32:42');

-- --------------------------------------------------------

--
-- Table structure for table `project_images`
--

CREATE TABLE `project_images` (
  `image_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `caption` varchar(200) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_services`
--

CREATE TABLE `request_services` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `model_id` int(11) DEFAULT NULL,
  `area` decimal(10,2) DEFAULT 0.00,
  `quantity` int(11) DEFAULT 1,
  `unit_price` decimal(10,2) DEFAULT 0.00,
  `subtotal` decimal(10,2) DEFAULT 0.00,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `base_price` decimal(10,2) DEFAULT 0.00,
  `price_per_sqft` decimal(10,2) DEFAULT 0.00,
  `unit` varchar(20) DEFAULT 'sqft',
  `image_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `domain_id`, `name`, `description`, `base_price`, `price_per_sqft`, `unit`, `image_url`, `is_active`) VALUES
(1, 1, 'Furniture & Glass Furnishing', 'Custom furniture design and glass decor installations including cabinets, shelves, and decorative glass elements that enhance your living space.', 50000.00, 1200.00, 'sqft', 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&w=400&q=80', 1),
(2, 1, 'Kitchen Design', 'Complete kitchen remodeling with modular layouts, efficient storage solutions, and aesthetic designs that combine functionality with style.', 75000.00, 2500.00, 'sqft', 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?ixlib=rb-4.0.3&w=400&q=80', 1),
(3, 1, 'Flooring Layout', 'Professional flooring solutions including hardwood, tiles, laminate, and carpet with optimal layout designs for durability and aesthetics.', 30000.00, 800.00, 'sqft', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&w=400&q=80', 1),
(4, 1, 'Lighting Effects', 'Custom lighting designs including ambient, task, and accent lighting to create the perfect mood and functionality in every room.', 20000.00, 500.00, 'sqft', 'https://images.unsplash.com/photo-1558618666-fcd25856cd25?ixlib=rb-4.0.3&w=400&q=80', 1),
(5, 1, 'Window Coverings', 'Beautiful and functional window treatments including curtains, blinds, and shades that provide privacy and enhance room aesthetics.', 15000.00, 300.00, 'sqft', 'https://images.unsplash.com/photo-1581849153063-52bd5c2c5abf?ixlib=rb-4.0.3&w=400&q=80', 1),
(6, 1, 'Color Schemes', 'Professional color consultation and painting services to create harmonious color palettes that reflect your personality and style.', 25000.00, 200.00, 'sqft', 'https://images.unsplash.com/photo-1566908829813-1c7c40b7ca55?ixlib=rb-4.0.3&w=400&q=80', 1),
(7, 1, 'Curtain Designing', 'Custom curtain design and installation with premium fabrics and modern hardware for elegant window treatments.', 18000.00, 400.00, 'sqft', 'https://images.unsplash.com/photo-1581849153063-52bd5c2c5abf?ixlib=rb-4.0.3&w=400&q=80', 1),
(8, 1, 'Architectural Design', 'Space planning and architectural modifications to optimize room layouts and enhance functionality and flow.', 100000.00, 1500.00, 'sqft', 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?ixlib=rb-4.0.3&w=400&q=80', 1),
(9, 1, 'Planting & Greenery', 'Indoor plant design and installation to bring nature indoors and create fresh, vibrant living environments.', 12000.00, 150.00, 'sqft', 'https://images.unsplash.com/photo-1484101403633-562f891dc89a?ixlib=rb-4.0.3&w=400&q=80', 1),
(10, 1, 'Living Room Seating', 'Strategic seating arrangement and furniture placement to optimize space and create comfortable, inviting living areas.', 35000.00, 600.00, 'sqft', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&w=400&q=80', 1),
(11, 2, 'Office Furniture & Glass', 'Professional office furniture and glass partitioning for productive and modern workspace environments.', 60000.00, 1500.00, 'sqft', 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?ixlib=rb-4.0.3&w=400&q=80', 1),
(12, 2, 'Office Flooring', 'Durable and professional flooring solutions suitable for high-traffic office environments.', 40000.00, 1000.00, 'sqft', 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?ixlib=rb-4.0.3&w=400&q=80', 1),
(13, 2, 'Office Lighting', 'Task-oriented lighting solutions for offices that reduce eye strain and enhance productivity.', 25000.00, 600.00, 'sqft', 'https://images.unsplash.com/photo-1497366216548-37526070297c?ixlib=rb-4.0.3&w=400&q=80', 1),
(14, 2, 'Window Treatments', 'Professional window coverings for offices that provide light control and privacy.', 20000.00, 400.00, 'sqft', 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?ixlib=rb-4.0.3&w=400&q=80', 1),
(15, 2, 'Office Color Schemes', 'Corporate color palettes that reflect brand identity and create professional atmospheres.', 30000.00, 250.00, 'sqft', 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?ixlib=rb-4.0.3&w=400&q=80', 1),
(16, 3, 'Event Furniture & Decor', 'Elegant furniture and decorative elements for weddings, parties, and corporate events.', 80000.00, 1000.00, 'sqft', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?ixlib=rb-4.0.3&w=400&q=80', 1),
(17, 3, 'Event Lighting Design', 'Dramatic and atmospheric lighting setups for special occasions and events.', 45000.00, 700.00, 'sqft', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&w=400&q=80', 1),
(18, 3, 'Stage & Backdrop Design', 'Professional stage setups and decorative backdrops for presentations and performances.', 55000.00, 1200.00, 'sqft', 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?ixlib=rb-4.0.3&w=400&q=80', 1),
(19, 3, 'Seating Arrangement', 'Optimal seating layouts for events to ensure guest comfort and smooth traffic flow.', 25000.00, 300.00, 'sqft', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?ixlib=rb-4.0.3&w=400&q=80', 1),
(20, 4, 'Restaurant Furniture', 'Custom restaurant furniture designed for comfort, durability, and aesthetic appeal.', 90000.00, 1800.00, 'sqft', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&w=400&q=80', 1),
(21, 4, 'Commercial Kitchen Design', 'Professional kitchen layouts optimized for efficiency, safety, and workflow.', 120000.00, 3000.00, 'sqft', 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?ixlib=rb-4.0.3&w=400&q=80', 1),
(22, 4, 'Dining Area Layout', 'Strategic dining area planning to maximize seating capacity and customer comfort.', 40000.00, 800.00, 'sqft', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&w=400&q=80', 1),
(23, 4, 'Restaurant Lighting', 'Atmospheric lighting designs that enhance dining experiences and restaurant ambiance.', 35000.00, 900.00, 'sqft', 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-4.0.3&w=400&q=80', 1),
(24, 4, 'Bar & Counter Design', 'Stylish bar areas and service counters that become focal points of your restaurant.', 65000.00, 2000.00, 'sqft', 'https://images.unsplash.com/photo-1578474847011-1e7e9e93439f?ixlib=rb-4.0.3&w=400&q=80', 1);

-- --------------------------------------------------------

--
-- Table structure for table `service_models`
--

CREATE TABLE `service_models` (
  `model_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `additional_price` decimal(10,2) DEFAULT 0.00,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_models`
--

INSERT INTO `service_models` (`model_id`, `service_id`, `name`, `description`, `image_url`, `additional_price`, `is_active`) VALUES
(1, 3, 'Chandelier Style', 'Luxury crystal chandeliers', NULL, 5000.00, 1),
(2, 3, 'LED Strip Lighting', 'Modern hidden LED strips', NULL, 1200.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `service_requests`
--

CREATE TABLE `service_requests` (
  `request_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `request_code` varchar(20) NOT NULL,
  `location` text NOT NULL,
  `area_sqft` decimal(10,2) DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `status_id` int(11) NOT NULL,
  `remarks` text DEFAULT NULL,
  `cancelled` tinyint(1) DEFAULT 0,
  `cancelled_at` datetime DEFAULT NULL,
  `cancelled_reason` text DEFAULT NULL,
  `client_name` varchar(255) DEFAULT NULL,
  `client_email` varchar(255) DEFAULT NULL,
  `client_phone` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_requests`
--

INSERT INTO `service_requests` (`request_id`, `user_id`, `request_code`, `location`, `area_sqft`, `requested_at`, `status_id`, `remarks`, `cancelled`, `cancelled_at`, `cancelled_reason`, `client_name`, `client_email`, `client_phone`, `description`) VALUES
(1, 4, 'REQ2025001', 'Lavington, Nairobi', 1800.00, '2025-01-15 09:30:00', 1, 'Complete home renovation for 4-bedroom house. Client wants modern kitchen and living room updates.', 0, NULL, NULL, 'James Muthoni', 'james.muthoni@outlook.com', '+254-700-123-456', 'Complete home renovation for my 4-bedroom house in Lavington. Need modern kitchen design, living room furniture, and lighting solutions. The house was built in 2010 and needs contemporary updates.'),
(2, 5, 'REQ2025002', 'Runda Estate, Nairobi', 2500.00, '2025-01-20 14:15:00', 3, 'New office setup for fintech company. Approved for design phase.', 0, NULL, NULL, 'Wanjiru Odhiambo', 'wanjiru.odhiambo@gmail.com', '+254-711-987-654', 'New office setup for our growing fintech company. Need professional workspace for 25 employees including executive offices, meeting rooms, and collaborative spaces. Modern and tech-friendly design preferred.'),
(3, 6, 'REQ2025003', 'Nyali, Mombasa', 1200.00, '2025-01-25 11:45:00', 1, 'Seaside restaurant design. Waiting for client to provide additional requirements.', 0, NULL, NULL, 'Kamar Akinyi', 'kamar.akinyi@yahoo.com', '+254-722-876-543', 'Design for new seaside restaurant in Nyali. Need elegant dining area, bar counter, and outdoor seating. Coastal theme with modern touches.'),
(4, 7, 'REQ2025004', 'Kilimani, Nairobi', 950.00, '2025-02-01 16:20:00', 2, 'Apartment renovation. Client requested eco-friendly materials.', 0, NULL, NULL, 'Brian Chege', 'brian.chege@hotmail.com', '+254-733-765-432', 'Renovation of my 2-bedroom apartment in Kilimani. Focus on space optimization, built-in storage, and sustainable materials. Open concept living area preferred.'),
(5, 8, 'REQ2025005', 'Thika Road, Nairobi', 3000.00, '2025-02-10 10:00:00', 3, 'Wedding venue decoration. Design approved, ready for implementation.', 0, NULL, NULL, 'Faith Wambui', 'faith.wambui@company.co.ke', '+254-744-654-321', 'Decoration of banquet hall for wedding events. Need elegant and romantic atmosphere with capacity for 200 guests. Flexible setup for different event types.'),
(6, 9, 'REQ2025006', 'Kisumu City', 1800.00, '2025-02-15 13:30:00', 4, 'Law firm office completed successfully. Client satisfied with results.', 0, NULL, NULL, 'David Omondi', 'david.omondi@business.com', '+254-755-543-210', 'Professional office design for law firm in Kisumu. Need traditional yet modern look with private consultation rooms and library space.'),
(7, 10, 'REQ2025007', 'Karen, Nairobi', 2200.00, '2025-02-20 15:45:00', 5, 'Luxury villa interior design. Work in progress.', 0, NULL, NULL, 'Linda Atieno', 'linda.atieno@enterprise.co.ke', '+254-766-432-109', 'Interior design for newly built villa in Karen. High-end finishes, smart home integration, and custom furniture throughout.'),
(8, 11, 'REQ2025008', 'Westlands, Nairobi', 1500.00, '2025-02-25 12:10:00', 6, 'Coffee shop design completed successfully.', 0, NULL, NULL, 'Peter Kamau', 'peter.kamau@industry.org', '+254-777-321-098', 'Modern coffee shop design in Westlands. Industrial theme with cozy seating, proper workflow for baristas, and outdoor patio.'),
(9, 12, 'REQ2025009', 'Nakuru Town', 2000.00, '2025-03-01 09:15:00', 6, 'Conference hall completed on time. Excellent client feedback.', 0, NULL, NULL, 'Mercy Jepkorir', 'mercy.jepkorir@corporation.com', '+254-788-210-987', 'Multi-purpose conference hall for corporate events and seminars. Need professional setup with audio-visual integration and flexible seating.'),
(10, 13, 'REQ2025010', 'Upper Hill, Nairobi', 5000.00, '2025-03-05 14:50:00', 5, 'Tech company headquarters. Construction in progress.', 0, NULL, NULL, 'Samuel Gitonga', 'samuel.gitonga@firm.co.ke', '+254-799-109-876', 'Complete office design for new tech company headquarters. Need innovative spaces for 100+ employees, including labs, collaboration zones, and recreational areas.'),
(11, 14, 'REQ2025011', 'Nyali, Mombasa', 3500.00, '2025-03-10 11:30:00', 3, 'Beach hotel renovation. Design approved.', 0, NULL, NULL, 'TechInnovate Kenya Ltd', 'info@techinnovate.co.ke', '+254-20-456-7890', 'Renovation of beachfront hotel lobby and common areas. Coastal luxury theme with local cultural elements. Need durable materials for high-traffic areas.'),
(12, 15, 'REQ2025012', 'Westlands, Nairobi', 1200.00, '2025-03-15 10:20:00', 4, 'Restaurant interior completed. Payment received.', 0, NULL, NULL, 'Sanctuary Hotels Group', 'management@sanctuaryhotels.com', '+254-41-123-4567', 'Complete interior design for new Asian fusion restaurant. Need sophisticated atmosphere with open kitchen concept and private dining area.');

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `setting_id` int(11) NOT NULL,
  `site_name` varchar(100) DEFAULT 'Alluring Decors',
  `tagline` varchar(255) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `favicon_url` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `support_email` varchar(100) DEFAULT NULL,
  `currency_symbol` varchar(5) DEFAULT 'KES',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`setting_id`, `site_name`, `tagline`, `logo_url`, `favicon_url`, `email`, `phone`, `support_email`, `currency_symbol`, `updated_at`, `updated_by`) VALUES
(1, 'Alluring Decors', 'Transforming Spaces, Creating Dreams', NULL, NULL, NULL, NULL, NULL, 'KES', '2025-11-05 18:46:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE `statuses` (
  `status_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `is_editable` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `statuses`
--

INSERT INTO `statuses` (`status_id`, `name`, `description`, `is_editable`) VALUES
(1, 'Request Received', 'Service request received', 1),
(2, 'Rejected', 'Service cannot be provided', 1),
(3, 'Accepted', 'Request accepted, awaiting payment', 1),
(4, 'Payment Received', 'Payment completed', 1),
(5, 'Service Began', 'Work started', 1),
(6, 'Service Completed', 'Project finished', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` enum('client','admin') DEFAULT 'client',
  `is_active` tinyint(1) DEFAULT 1,
  `registration_date` datetime DEFAULT current_timestamp(),
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `full_name`, `phone`, `address`, `role`, `is_active`, `registration_date`, `last_login`) VALUES
(1, 'admin', 'admin123', 'admin@alluringdecors.com', 'Administrator', NULL, NULL, 'admin', 1, '2025-11-05 18:46:10', NULL),
(2, 'evans', 'ubA3M497cz7y3KE', 'osumbaevans21@gmail.com', 'Evans Osumba', '0707868194', '40100', 'client', 1, '2025-11-05 19:15:49', NULL),
(3, 'james.muthoni', '$2y$10$5rK8mN7sP3wV2qY9zX6bL4cH8jM1pQwR0tY3nB6nF9vG7hR5dC3x', 'james.muthoni@outlook.com', 'James Muthoni', '+254-700-123-456', 'Lavington, Nairobi', 'client', 1, '2025-11-24 12:27:06', NULL),
(4, 'wanjiru.odhiambo', '$2y$10$9tL3qN8rP4wV7xY2zK6bM5cH1jL8pQwR0tY4nB7nF9vG6hR5dC2x', 'wanjiru.odhiambo@gmail.com', 'Wanjiru Odhiambo', '+254-711-987-654', 'Runda Estate, Nairobi', 'client', 1, '2025-11-24 12:27:06', NULL),
(5, 'kamar.akinyi', '$2y$10$4rM7nP8sQ3wV6xY1zK9bL5cH2jM8pQwR1tY5nC7nG0vH7iS6dC4x', 'kamar.akinyi@yahoo.com', 'Kamar Akinyi', '+254-722-876-543', 'Nyali, Mombasa', 'client', 1, '2025-11-24 12:27:06', NULL),
(6, 'brian.chege', '$2y$10$8tN2qP7sR4wV9xY3zL6bM5cH1jK8pQwS0tY4nC7nG0vH6iR5dC3x', 'brian.chege@hotmail.com', 'Brian Chege', '+254-733-765-432', 'Kilimani, Nairobi', 'client', 1, '2025-11-24 12:27:06', NULL),
(7, 'faith.wambui', '$2y$10$6rK9mP8sT4wV2xY7zL6bN5cH3jM9pQwR2tY5nC8nG1vH8iS7dC4x', 'faith.wambui@company.co.ke', 'Faith Wambui', '+254-744-654-321', 'Thika Road, Nairobi', 'client', 1, '2025-11-24 12:27:06', NULL),
(8, 'david.omondi', '$2y$10$3tL5qN7sR2wV8xY4zK9bM6cH1jL7pQwS1tY3nC6nF9vG5hR4dC2x', 'david.omondi@business.com', 'David Omondi', '+254-755-543-210', 'Kisumu City', 'client', 1, '2025-11-24 12:27:06', NULL),
(9, 'linda.atieno', '$2y$10$7rM4nP9sT5wV1xY6zL8bM7cH2jK9pQwR3tY4nC7nG0vH8iS6dC5x', 'linda.atieno@enterprise.co.ke', 'Linda Atieno', '+254-766-432-109', 'Karen, Nairobi', 'client', 1, '2025-11-24 12:27:06', NULL),
(10, 'peter.kamau', '$2y$10$2tN6qP8sR3wV5xY9zL7bM4cH1jK8pQwS2tY3nC6nF9vG7hR5dC4x', 'peter.kamau@industry.org', 'Peter Kamau', '+254-777-321-098', 'Westlands, Nairobi', 'client', 1, '2025-11-24 12:27:06', NULL),
(11, 'mercy.jepkorir', '$2y$10$5rK3mN7sP4wV8xY2zL9bM6cH3jK7pQwR4tY5nC8nG1vH9iS7dC6x', 'mercy.jepkorir@corporation.com', 'Mercy Jepkorir', '+254-788-210-987', 'Nakuru Town', 'client', 1, '2025-11-24 12:27:06', NULL),
(12, 'samuel.gitonga', 'samuel.gitonga', 'samuel.gitonga@firm.co.ke', 'Samuel Gitonga', '+254-799-109-876', 'Eldoret Town', 'client', 1, '2025-11-24 12:27:06', NULL),
(13, 'techinnovate.hr', '$2y$10$8rZJq9TkLmh6vNc8wF3B7eR2gY5xV1pQwK4nH7sM9zL6bRtC8vD', 'info@techinnovate.co.ke', 'TechInnovate Kenya Ltd', '+254-20-456-7890', 'Upper Hill, Nairobi', 'client', 1, '2025-11-24 12:27:06', NULL),
(14, 'sanctuary.hotels', '$2y$10$3tK9mR7sP2wV5qY8zX6bN4cH7jL1pQwK9rT2yM5nB8vF6gR3dC4x', 'management@sanctuaryhotels.com', 'Sanctuary Hotels Group', '+254-41-123-4567', 'Nyali, Mombasa', 'client', 1, '2025-11-24 12:27:06', NULL),
(15, 'flavors.fusion', 'flavors.fusion', 'admin@flavorsfusion.co.ke', 'Flavors Fusion Restaurant', '+254-711-555-1234', 'Westlands, Nairobi', 'client', 1, '2025-11-24 12:27:06', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`bill_id`),
  ADD UNIQUE KEY `bill_number` (`bill_number`),
  ADD KEY `request_id` (`request_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `content_sections`
--
ALTER TABLE `content_sections`
  ADD PRIMARY KEY (`section_id`),
  ADD UNIQUE KEY `section_key` (`section_key`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `domains`
--
ALTER TABLE `domains`
  ADD PRIMARY KEY (`domain_id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`faq_id`);

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `heroes`
--
ALTER TABLE `heroes`
  ADD PRIMARY KEY (`hero_id`);

--
-- Indexes for table `media_uploads`
--
ALTER TABLE `media_uploads`
  ADD PRIMARY KEY (`media_id`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `recorded_by` (`recorded_by`),
  ADD KEY `payments_ibfk_1` (`bill_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_id`);

--
-- Indexes for table `project_images`
--
ALTER TABLE `project_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `project_images_ibfk_1` (`project_id`);

--
-- Indexes for table `request_services`
--
ALTER TABLE `request_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `domain_id` (`domain_id`),
  ADD KEY `model_id` (`model_id`),
  ADD KEY `request_services_ibfk_3` (`service_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `domain_id` (`domain_id`);

--
-- Indexes for table `service_models`
--
ALTER TABLE `service_models`
  ADD PRIMARY KEY (`model_id`),
  ADD KEY `service_models_ibfk_1` (`service_id`);

--
-- Indexes for table `service_requests`
--
ALTER TABLE `service_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD UNIQUE KEY `request_code` (`request_code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `content_sections`
--
ALTER TABLE `content_sections`
  MODIFY `section_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `domains`
--
ALTER TABLE `domains`
  MODIFY `domain_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `faq_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `heroes`
--
ALTER TABLE `heroes`
  MODIFY `hero_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `media_uploads`
--
ALTER TABLE `media_uploads`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `project_images`
--
ALTER TABLE `project_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_services`
--
ALTER TABLE `request_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `service_models`
--
ALTER TABLE `service_models`
  MODIFY `model_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `service_requests`
--
ALTER TABLE `service_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `statuses`
--
ALTER TABLE `statuses`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `content_sections`
--
ALTER TABLE `content_sections`
  ADD CONSTRAINT `content_sections_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `media_uploads`
--
ALTER TABLE `media_uploads`
  ADD CONSTRAINT `media_uploads_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `project_images`
--
ALTER TABLE `project_images`
  ADD CONSTRAINT `project_images_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE;

--
-- Constraints for table `request_services`
--
ALTER TABLE `request_services`
  ADD CONSTRAINT `request_services_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `request_services_ibfk_4` FOREIGN KEY (`model_id`) REFERENCES `service_models` (`model_id`) ON DELETE SET NULL;

--
-- Constraints for table `service_models`
--
ALTER TABLE `service_models`
  ADD CONSTRAINT `service_models_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON UPDATE CASCADE;

--
-- Constraints for table `service_requests`
--
ALTER TABLE `service_requests`
  ADD CONSTRAINT `service_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `service_requests_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`status_id`);

--
-- Constraints for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD CONSTRAINT `site_settings_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
