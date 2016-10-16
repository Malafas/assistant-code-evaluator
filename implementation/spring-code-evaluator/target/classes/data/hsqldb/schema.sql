/*
 * HSQLDB script.
 * Create the database schema for the application.
 */

DROP TABLE Greeting IF EXISTS;

CREATE TABLE Greeting (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL,
  referenceId VARCHAR(255) NOT NULL,
  text VARCHAR(100) NOT NULL,
  version INT NOT NULL,
  createdBy VARCHAR(100) NOT NULL,
  createdAt DATETIME NOT NULL,
  updatedBy VARCHAR(100) DEFAULT NULL,
  updatedAt DATETIME DEFAULT NULL,
  PRIMARY KEY(id),
  CONSTRAINT UQ_Greeting_ReferenceId UNIQUE (referenceId)
);


DROP TABLE AccountRole IF EXISTS;
DROP TABLE Account IF EXISTS;
DROP TABLE Role IF EXISTS;

CREATE TABLE Account (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL,
  referenceId VARCHAR(255) NOT NULL,
  username VARCHAR(100) NOT NULL,
  password VARCHAR(200) NOT NULL,
  enabled BOOLEAN DEFAULT true NOT NULL,
  credentialsexpired BOOLEAN DEFAULT false NOT NULL,
  expired BOOLEAN DEFAULT false NOT NULL,
  locked BOOLEAN DEFAULT false NOT NULL,
  version INT NOT NULL,
  createdBy VARCHAR(100) NOT NULL,
  createdAt DATETIME NOT NULL,
  updatedBy VARCHAR(100) DEFAULT NULL,
  updatedAt DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT UQ_Account_ReferenceId UNIQUE (referenceId),
  CONSTRAINT UQ_Account_Username UNIQUE (username)
);

CREATE TABLE Role (
  id BIGINT NOT NULL,
  code VARCHAR(50) NOT NULL,
  label VARCHAR(100) NOT NULL,
  ordinal INT NOT NULL,
  effectiveAt DATETIME NOT NULL,
  expiresAt DATETIME DEFAULT NULL,
  createdAt DATETIME NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT UQ_Role_Code UNIQUE (code)
);

CREATE TABLE AccountRole (
  accountId BIGINT NOT NULL,
  roleId BIGINT NOT NULL,
  PRIMARY KEY (accountId, roleId),
  CONSTRAINT FK_AccountRole_AccountId FOREIGN KEY (accountId) REFERENCES Account (id),
  CONSTRAINT FK_AccountRole_RoleId FOREIGN KEY (roleId) REFERENCES Role (id)
);