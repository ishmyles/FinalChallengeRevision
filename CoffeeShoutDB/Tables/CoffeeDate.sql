CREATE TABLE [dbo].[CoffeeDate]
(
	[CoffeeDateNo] INT NOT NULL,
	[Date] NVARCHAR(15) NOT NULL,
	[Time] NVARCHAR(15) NOT NULL,
	[Venue] NVARCHAR(50) NULL,
	[ShoutedBy] NVARCHAR(10) NULL,
	[ShoutedAmount] MONEY NULL,
	[IsPending] INT NULL,
	CONSTRAINT PK_CoffeeDate PRIMARY KEY (CoffeeDateNo),
	CONSTRAINT FK_CofeeDate_Member FOREIGN KEY (ShoutedBy) REFERENCES Member(ID)
)
