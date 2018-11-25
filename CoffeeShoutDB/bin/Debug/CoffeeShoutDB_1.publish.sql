﻿/*
Deployment script for CoffeeShoutDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar LoadTestData "true"
:setvar DatabaseName "CoffeeShoutDB"
:setvar DefaultFilePrefix "CoffeeShoutDB"
:setvar DefaultDataPath "C:\Users\ishmyles\AppData\Local\Microsoft\VisualStudio\SSDT"
:setvar DefaultLogPath "C:\Users\ishmyles\AppData\Local\Microsoft\VisualStudio\SSDT"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF '$(LoadTestData)' = 'true'

DELETE FROM CoffeeDate;
DELETE FROM Member;

BEGIN

--Not Pending = 0
--Pending = 1
INSERT INTO Member(ID, FirstName, LastName, PendingApproval) VALUES
('101571963', 'Myles', 'Gaerlan', 0),
('101664287', 'Michelle', 'Hughes', 1),
('101644810', 'Kristian', 'Ybanez', 0),
('101604238', 'Nicholas', 'Ainsworth', 1);

--Not Upcoming = 0
INSERT INTO CoffeeDate([Date], [Time], Venue, IsPending, ShoutedBy, ShoutedAmount) VALUES
('16/11/2018', '09:32 AM', 'Cafe Gomez', 0, '101571963', 12.00),
('23/11/2018', '09:12 AM', 'Cafe Gomez', 0, '101571963', 12.00),
('30/11/2018', '08:50 AM', 'Cafe Gomez', 1, NULL, NULL);

END;
GO

GO
PRINT N'Update complete.';


GO
