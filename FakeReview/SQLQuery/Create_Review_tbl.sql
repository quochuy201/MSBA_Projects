USE [YelpResData]
GO

/****** Object:  Table [dbo].[review]    Script Date: 1/21/2020 12:36:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[review](
	[date] [date] NULL,
	[reviewID] [nvarchar](50) NULL,
	[reviewerID] [nvarchar](50) NOT NULL,
	[reviewContent] [varchar](max) NULL,
	[rating] [int] NOT NULL,
	[usefulCount] [int] NOT NULL,
	[coolCount] [int] NOT NULL,
	[funnyCount] [int] NOT NULL,
	[flagged] [nvarchar](50) NOT NULL,
	[restaurantID] [nvarchar](50) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


