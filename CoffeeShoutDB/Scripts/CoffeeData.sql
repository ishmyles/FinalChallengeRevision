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

--Approved = 0
--Pending = 1
--Rejected = 2
INSERT INTO Member(ID, FirstName, LastName, PendingApproval) VALUES
('101571963', 'Myles', 'Gaerlan', 0),
('101664287', 'Michelle', 'Hughes', 1),
('101644810', 'Kristian', 'Ybanez', 0),
('101604238', 'Nicholas', 'Ainsworth', 1);

--Not Upcoming = 0
INSERT INTO CoffeeDate(CoffeeDateNo, [Date], [Time], Venue, IsPending, ShoutedBy, ShoutedAmount) VALUES
(1, '16/11/2018', '09:32 AM', 'Cafe Gomez', 0, '101571963', 12.00),
(2, '23/11/2018', '09:12 AM', 'Cafe Gomez', 0, '101571963', 12.00),
(3, '30/11/2018', '08:50 AM', 'Cafe Gomez', 1, NULL, NULL);

END;