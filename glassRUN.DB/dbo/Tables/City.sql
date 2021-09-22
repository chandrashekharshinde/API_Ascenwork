CREATE TABLE [dbo].[City] (
    [CityId]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [StateId]     BIGINT        NOT NULL,
    [CityName]    NVARCHAR (50) NULL,
    [CityCode]    NVARCHAR (50) NULL,
    [IsActive]    BIT           NOT NULL,
    [CreatedBy]   BIGINT        NOT NULL,
    [CreatedDate] DATETIME      NOT NULL,
    [UpdatedBy]   BIGINT        NULL,
    [UpdatedDate] DATETIME      NULL,
    CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED ([CityId] ASC),
    CONSTRAINT [FK_City_State] FOREIGN KEY ([StateId]) REFERENCES [dbo].[State] ([StateId])
);


GO
CREATE NONCLUSTERED INDEX [ID_City_StateId]
    ON [dbo].[City]([StateId] ASC);

