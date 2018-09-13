DROP table users;
CREATE TABLE `Users` (
  `userid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(200) NOT NULL DEFAULT '',
  `userRole` varchar(20) DEFAULT NULL,
  `email` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SET sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

Drop table Tasks;
CREATE TABLE `Tasks` (
  `taskId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `taskName` varchar(1000) NOT NULL DEFAULT '',
  `addedBy` varchar(400) NOT NULL DEFAULT '',
  `status` varchar(50) NOT NULL DEFAULT '',
  `assignee` varchar(400) ,
  `percentComplete` INT NOT NULL DEFAULT 0,
  `updatedBy` varchar(400) NOT NULL DEFAULT '',
  `priority` varchar(40),
  `project` varchar(40),
  `description` text,
  `createdDate` timestamp DEFAULT current_timestamp,
  `updatedDate` timestamp,
  PRIMARY KEY (`taskId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

drop table Task_History;
CREATE TABLE `Task_History` (
  `taskHistoryId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `taskId` int(11) unsigned NOT NULL,
  `taskHistoryAddedBy` varchar(400) NOT NULL DEFAULT '',
  `taskHistoryDescription` text,
  `createdDate` timestamp DEFAULT current_timestamp,
  PRIMARY KEY (`taskHistoryId`),
  KEY `taskId` (`taskId`),
  CONSTRAINT `TaskHistory_fk_1` FOREIGN KEY (`taskId`)
  REFERENCES `Tasks` (`taskId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

drop table bugs;
CREATE TABLE `Bugs` (
  `bugId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `bugName` varchar(1000) NOT NULL DEFAULT '',
  `addedBy` varchar(400) NOT NULL DEFAULT '',
  `status` varchar(50) NOT NULL DEFAULT '',
  `updatedBy` varchar(400) NOT NULL DEFAULT '',
  `description` text,
  `resolution` text,
  `createdDate` timestamp DEFAULT current_timestamp,
  `updatedDate` timestamp,
  PRIMARY KEY (`bugId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Leaves` (
  `leaveId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `reason` varchar(1000) NOT NULL DEFAULT '',
  `addedBy` int(11) unsigned,
  `status` varchar(50) NOT NULL DEFAULT '',
  `days` int(11) unsigned,
  `startDate` DATE ,
  `endDate` DATE ,
  `updatedDate` timestamp DEFAULT current_timestamp,
  PRIMARY KEY (`leaveId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

drop table ref_links;
CREATE TABLE `ref_links` (
`refId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `addedBy` varchar(400) NOT NULL DEFAULT '',
  `reference` varchar(1000) NOT NULL,
   `updatedDate` timestamp DEFAULT current_timestamp,
  PRIMARY KEY (`refId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
