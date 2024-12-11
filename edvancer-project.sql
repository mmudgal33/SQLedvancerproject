CREATE DATABASE TENANT;
DROP DATABASE TENANT;
SELECT * FROM dbo.Profiles
USE TENANT
SELECT *
INTO Person.PasswordCopy
FROM Person.Password;
USE TENANT1

IF OBJECT_ID('Tenancy_histories','U') IS NOT NULL
DROP TABLE Tenancy_histories;
CREATE TABLE Tenancy_histories (
Tenancy_histories_ID BIGINT NOT NULL IDENTITY,
CONSTRAINT PK_Tenancy_histories_ID PRIMARY KEY CLUSTERED (Tenancy_histories_ID),
PROFILE_ID BIGINT NOT NULL REFERENCES Profiles (PROFILE_ID),
HOUSE_ID BIGINT NOT NULL REFERENCES Houses (HOUSE_ID),
MOVE_IN_DATE DATE NOT NULL,
MOVE_OUT_DATE VARCHAR(255) NULL,
RENT BIGINT NOT NULL,
BED_TYPE VARCHAR(255) NULL,
MOVE_OUT_REASON VARCHAR(255) NULL);

ALTER TABLE Tenancy_histories NOCHECK CONSTRAINT ALL
ALTER TABLE Referrals WITH CHECK CHECK CONSTRAINT ALL


UPDATE [dbo].[Employment_details]
SET [YRS_EXPERIENCE] = NULL 
WHERE  [YRS_EXPERIENCE] = 'NULL';

ALTER TABLE Tenancy_histories
ALTER COLUMN MOVE_OUT_DATE DATE NULL;

MOVE_OUT_DATE VARCHAR(255) NULL,
/*Field Type Null Key Default
id int(11) NO PRI auto_increment
profile_id int(11) NO FK
house_id int(11) NO FK
move_in_date date NO
move_out_date date YES
rent int(11) NO
Bed_type varchar(255) YES
move_out_reason varchar(255) YES*/


IF OBJECT_ID('Profiles','U') IS NOT NULL
DROP TABLE Profiles;
CREATE TABLE Profiles (
PROFILE_ID BIGINT NOT NULL IDENTITY,
CONSTRAINT PK_PROFILE_ID PRIMARY KEY CLUSTERED (PROFILE_ID),
FIRST_NAME VARCHAR(255) NULL,
LAST_NAME VARCHAR(255) NULL,
EMAIL VARCHAR(255) NOT NULL,
PHONE VARCHAR(255) NOT NULL,
CITY_HOMETOWN VARCHAR(255) NULL,
PAN_CARD VARCHAR(255) NULL,
CREATED_AT DATE NOT NULL,
GENDER VARCHAR(255) NOT NULL,
REFERRAL_CODE VARCHAR(255) NULL,
MARITAL_STATUS VARCHAR(255) NULL);

ALTER TABLE Profiles NOCHECK CONSTRAINT ALL
ALTER TABLE Referrals WITH CHECK CHECK CONSTRAINT ALL

ALTER TABLE Profiles
ALTER COLUMN PROFILE_ID CONSTRAINT PK_PROFILE_ID PRIMARY KEY CLUSTERED PROFILE_ID;

/*Profiles
Field Type Null Key Default
profile_id int(11) NO PRI auto_increment
first_name varchar(255) YES
last_name varchar(255) YES
email varchar(255) NO
phone varchar(255) NO
city(hometown) varchar(255) YES
pan_card varchar(255) YES
created_at date NO
gender varchar(255) NO
referral_code varchar(255) YES
marital_status varchar(255) YES*/


IF OBJECT_ID('Houses','U') IS NOT NULL
DROP TABLE Houses;
CREATE TABLE Houses (
HOUSE_ID BIGINT NOT NULL IDENTITY,
CONSTRAINT PK_HOUSE_ID PRIMARY KEY CLUSTERED (HOUSE_ID),
HOUSE_TYPE VARCHAR(255) NULL,
BHK_DETAILS VARCHAR(255) NULL,
BED_COUNT BIGINT NOT NULL,
FURNISHING_TYPE VARCHAR(255) NULL,
BEDS_VACANT BIGINT NOT NULL);

ALTER TABLE Tenancy_histories
ALTER COLUMN MOVE_OUT_DATE DATE NULL;

ALTER TABLE Houses NOCHECK CONSTRAINT ALL
ALTER TABLE Referrals WITH CHECK CHECK CONSTRAINT ALL

ALTER TABLE Houses
DROP COLUMN BHK_DETAILS;

ALTER TABLE Houses
ADD BHK_DETAILS  VARCHAR(255) NULL;

TRUNCATE TABLE dbo.Houses;

/*Houses
Field Type Null Key Default
house_id int(11) NO PRI auto_increment
house_type varchar(255) YES
bhk_details varchar(255) YES
bed_count int(11) NO
furnishing_type varchar(255) YES
Beds_vacant int(11) NO*/


IF OBJECT_ID('Addresses','U') IS NOT NULL
DROP TABLE Addresses;
CREATE TABLE Addresses (
AD_ID BIGINT NOT NULL IDENTITY,
CONSTRAINT PK_AD_ID PRIMARY KEY CLUSTERED (AD_ID),
NAME_ VARCHAR(255) NULL,
DESCRIPTION_ TEXT NULL,
PINCODE BIGINT NULL,
CITY VARCHAR(255) NULL,
ADD_HOUSE_ID BIGINT NOT NULL REFERENCES Houses (HOUSE_ID));

ALTER TABLE Addresses NOCHECK CONSTRAINT ALL
ALTER TABLE Referrals WITH CHECK CHECK CONSTRAINT ALL

/*Addresses
Field Type Null Key Default
ad_id int(11) NO PRI auto_increment
name varchar(255) YES
description text YES
pincode int(11) YES
city varchar(255) YES
house_id int(11) NO FK*/

IF OBJECT_ID('Referrals','U') IS NOT NULL
DROP TABLE Referrals;
CREATE TABLE Referrals (
REF_ID BIGINT NOT NULL IDENTITY,
CONSTRAINT PK_REF_ID PRIMARY KEY CLUSTERED (REF_ID),
REFERRER_ID BIGINT NOT NULL REFERENCES Profiles (PROFILE_ID),
REFERRER_BONUS_AMOUNT FLOAT NULL,
REFERRAL_VALID BIT NULL, 
VALID_FROM DATE NULL,
VALID_TILL DATE NULL);

ALTER TABLE Referrals NOCHECK CONSTRAINT ALL
ALTER TABLE Referrals WITH CHECK CHECK CONSTRAINT ALL

ALTER TABLE Referrals
ALTER COLUMN Last_Name VARCHAR(75) NULL;

/*Referrals
Field Type Null Key Default
ref_id int(11) NO PRI auto_increment
referrer_id(same as profile id) int(11) NO FK
referrer_bonus_amount float YES
referral_valid tinyint(1) YES 0/1
valid_from date YES
valid_till date YES*/


IF OBJECT_ID('Employment_details','U') IS NOT NULL
DROP TABLE Employment_details;
CREATE TABLE Employment_details (
EMP_ID BIGINT NOT NULL IDENTITY,
CONSTRAINT PK_ID PRIMARY KEY CLUSTERED (EMP_ID),
EMP_PROFILE_ID BIGINT NOT NULL REFERENCES Profiles (PROFILE_ID),
LATEST_EMPLOYER VARCHAR(255) NULL,
OFFICIAL_MAIL_ID VARCHAR(255) NULL,
YRS_EXPERIENCE VARCHAR(255) NULL,
OCCUPATIONAL_CATEGORY VARCHAR(255) NULL);

ALTER TABLE Employment_details NOCHECK CONSTRAINT ALL
ALTER TABLE Referrals WITH CHECK CHECK CONSTRAINT ALL

drop table dbo.Employment_details;
/*Employment_details
Field Type Null Key Default
id int(11) NO PRI auto_increment
profile_id int(11) NO FK
latest_employer varchar(255) YES
official_mail_id varchar(255) YES
yrs_experience int(11) YES
Occupational_category varchar(255) YES*/




IF OBJECT_ID('Profiles','U') IS NOT NULL
DROP TABLE Profiles;
CREATE TABLE Profiles (
PROFILE_ID BIGINT NOT NULL IDENTITY,
CONSTRAINT PK_PROFILE_ID PRIMARY KEY CLUSTERED (PROFILE_ID),
FIRST_NAME VARCHAR(255) NULL,
LAST_NAME VARCHAR(255) NULL,
EMAIL VARCHAR(255) NOT NULL,
PHONE VARCHAR(255) NOT NULL,
CITY_HOMETOWN VARCHAR(255) NULL,
PAN_CARD VARCHAR(255) NULL,
CREATED_AT DATE NOT NULL,
GENDER VARCHAR(255) NOT NULL,
REFERRAL_CODE VARCHAR(255) NULL,
MARITAL_STATUS VARCHAR(255) NULL);


truncate table dbo.Houses;

alter table [dbo].[Employment_details]
add constraint Employment_details_profiles_fk
foreign key ([PROFILE_ID]) references [dbo].[Profiles]([PROFILE_ID])

alter table [dbo].[Referrals]
add constraint Referrals_profiles_fk
foreign key ([PROFILE_ID]) references [dbo].[Profiles]([PROFILE_ID])

alter table [dbo].[Tenancy_histories]
add constraint Tenancy_histories_profiles_fk
foreign key ([PROFILE_ID]) references [dbo].[Profiles]([PROFILE_ID])

alter table [dbo].[Addresses]
add constraint Addresses_Houses_fk
foreign key ([HOUSE_ID]) references [dbo].[Houses]([HOUSE_ID])

alter table [dbo].[Tenancy_histories]
add constraint Tenancy_histories_Houses_fk
foreign key ([HOUSE_ID]) references [dbo].[Houses]([HOUSE_ID])


