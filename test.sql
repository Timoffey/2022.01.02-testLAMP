
CREATE TABLE IF NOT EXISTS `news` (
  `id` int(7) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

INSERT INTO `news` (`id`, `title`, `description`, `date`) VALUES
(1, 'Nullam mattis adipiscing convallis', 'Pellentesque mollis quam eu metus vestibulum ut aliquet purus mattis. Vestibulum dignissim eros felis. Mauris in mauris sit amet velit consequat vulputate ac quis enim. Nam vel elit eu neque scelerisque auctor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec eleifend commodo posuere. Donec sed odio elit. Cras ut quam massa, vel luctus metus. ', '2013-01-04 12:48:19'),
(2, 'Aenean quis massa augue', 'Sed non arcu imperdiet eros ultrices ultricies. Fusce sit amet augue felis, venenatis posuere ipsum. Sed sem est, dictum id iaculis quis, ullamcorper sit amet lorem. Maecenas quis tellus neque. Nullam metus lorem, tristique ut rhoncus nec, faucibus quis enim. Praesent blandit eros ac nulla pellentesque laoreet. Donec eget tortor sit amet velit dignissim ultrices quis non nulla. Morbi tristique laoreet fermentum. Proin nisl lorem, congue a tincidunt et, cursus sit amet velit. Morbi placerat, quam a iaculis molestie, quam tortor dictum libero, non eleifend magna magna gravida est. Proin nec sodales ante. Donec eu leo vitae justo varius sagittis id quis nunc. ', '2013-02-12 17:22:50'),
(7, 'Mauris iaculis sagittis risus', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse non nisl risus, sed interdum sapien. Nulla quis orci ut eros gravida tincidunt. Pellentesque ac luctus est. Donec iaculis augue non nisi aliquam vitae iaculis nisl lacinia. Suspendisse ultrices cursus elit, quis fermentum nibh lacinia ut. Cras malesuada, dui eget ullamcorper auctor, magna purus convallis magna, vel tempor orci lacus non lectus. Morbi pulvinar, nibh non lacinia imperdiet, elit magna facilisis enim, at molestie nibh dolor sed augue. Pellentesque tristique interdum viverra.', '2013-02-04 08:14:12');
