DROP TABLE IF EXISTS `billing`;
CREATE TABLE `billing` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(255) default '',
  `foreign_id` int(11) NOT NULL,
  `title` varchar(255) default '',
  `description` text NOT NULL,

  
  `credit` float(11) NOT NULL,
  `debit` float(11) NOT NULL,

  `create_by` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_by` int(11) NOT NULL,
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;