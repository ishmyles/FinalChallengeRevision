CREATE TABLE [dbo].[Member]
(
	[ID] NVARCHAR(10) NOT NULL,
	[FirstName] NVARCHAR(20),
	[LastName] NVARCHAR(20),
	[PendingApproval] INT,
	CONSTRAINT PK_Member PRIMARY KEY (ID)
)
