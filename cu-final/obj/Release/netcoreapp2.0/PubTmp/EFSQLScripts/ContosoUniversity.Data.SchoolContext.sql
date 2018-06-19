IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816151242_InitialCreate')
BEGIN
    CREATE TABLE [Course] (
        [CourseID] int NOT NULL,
        [Credits] int NOT NULL,
        [Title] nvarchar(max) NULL,
        CONSTRAINT [PK_Course] PRIMARY KEY ([CourseID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816151242_InitialCreate')
BEGIN
    CREATE TABLE [Student] (
        [ID] int NOT NULL IDENTITY,
        [EnrollmentDate] datetime2 NOT NULL,
        [FirstMidName] nvarchar(max) NULL,
        [LastName] nvarchar(max) NULL,
        CONSTRAINT [PK_Student] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816151242_InitialCreate')
BEGIN
    CREATE TABLE [Enrollment] (
        [EnrollmentID] int NOT NULL IDENTITY,
        [CourseID] int NOT NULL,
        [Grade] int NULL,
        [StudentID] int NOT NULL,
        CONSTRAINT [PK_Enrollment] PRIMARY KEY ([EnrollmentID]),
        CONSTRAINT [FK_Enrollment_Course_CourseID] FOREIGN KEY ([CourseID]) REFERENCES [Course] ([CourseID]) ON DELETE CASCADE,
        CONSTRAINT [FK_Enrollment_Student_StudentID] FOREIGN KEY ([StudentID]) REFERENCES [Student] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816151242_InitialCreate')
BEGIN
    CREATE INDEX [IX_Enrollment_CourseID] ON [Enrollment] ([CourseID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816151242_InitialCreate')
BEGIN
    CREATE INDEX [IX_Enrollment_StudentID] ON [Enrollment] ([StudentID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816151242_InitialCreate')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20170816151242_InitialCreate', N'2.0.1-rtm-125');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816154125_MaxLengthOnNames')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'Student') AND [c].[name] = N'LastName');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Student] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Student] ALTER COLUMN [LastName] nvarchar(50) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816154125_MaxLengthOnNames')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'Student') AND [c].[name] = N'FirstMidName');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Student] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [Student] ALTER COLUMN [FirstMidName] nvarchar(50) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816154125_MaxLengthOnNames')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20170816154125_MaxLengthOnNames', N'2.0.1-rtm-125');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816154807_ColumnFirstName')
BEGIN
    EXEC sp_rename N'Student.FirstMidName', N'FirstName', N'COLUMN';
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816154807_ColumnFirstName')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20170816154807_ColumnFirstName', N'2.0.1-rtm-125');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'Student') AND [c].[name] = N'LastName');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Student] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [Student] ALTER COLUMN [LastName] nvarchar(50) NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'Student') AND [c].[name] = N'FirstName');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Student] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [Student] ALTER COLUMN [FirstName] nvarchar(50) NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'Course') AND [c].[name] = N'Title');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Course] DROP CONSTRAINT [' + @var4 + '];');
    ALTER TABLE [Course] ALTER COLUMN [Title] nvarchar(50) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    CREATE TABLE [Instructor] (
        [ID] int NOT NULL IDENTITY,
        [FirstName] nvarchar(50) NOT NULL,
        [HireDate] datetime2 NOT NULL,
        [LastName] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Instructor] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    CREATE TABLE [CourseAssignment] (
        [CourseID] int NOT NULL,
        [InstructorID] int NOT NULL,
        CONSTRAINT [PK_CourseAssignment] PRIMARY KEY ([CourseID], [InstructorID]),
        CONSTRAINT [FK_CourseAssignment_Course_CourseID] FOREIGN KEY ([CourseID]) REFERENCES [Course] ([CourseID]) ON DELETE CASCADE,
        CONSTRAINT [FK_CourseAssignment_Instructor_InstructorID] FOREIGN KEY ([InstructorID]) REFERENCES [Instructor] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    CREATE TABLE [Department] (
        [DepartmentID] int NOT NULL IDENTITY,
        [Budget] money NOT NULL,
        [InstructorID] int NULL,
        [Name] nvarchar(50) NULL,
        [StartDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Department] PRIMARY KEY ([DepartmentID]),
        CONSTRAINT [FK_Department_Instructor_InstructorID] FOREIGN KEY ([InstructorID]) REFERENCES [Instructor] ([ID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    INSERT INTO dbo.Department (Name, Budget, StartDate) VALUES ('Temp', 0.00, GETDATE())
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    ALTER TABLE [Course] ADD [DepartmentID] int NOT NULL DEFAULT 1;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    CREATE TABLE [OfficeAssignment] (
        [InstructorID] int NOT NULL,
        [Location] nvarchar(50) NULL,
        CONSTRAINT [PK_OfficeAssignment] PRIMARY KEY ([InstructorID]),
        CONSTRAINT [FK_OfficeAssignment_Instructor_InstructorID] FOREIGN KEY ([InstructorID]) REFERENCES [Instructor] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    CREATE INDEX [IX_Course_DepartmentID] ON [Course] ([DepartmentID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    CREATE INDEX [IX_CourseAssignment_InstructorID] ON [CourseAssignment] ([InstructorID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    CREATE INDEX [IX_Department_InstructorID] ON [Department] ([InstructorID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    ALTER TABLE [Course] ADD CONSTRAINT [FK_Course_Department_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [Department] ([DepartmentID]) ON DELETE CASCADE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816155401_ComplexDataModel')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20170816155401_ComplexDataModel', N'2.0.1-rtm-125');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816180112_RowVersion')
BEGIN
    ALTER TABLE [Department] ADD [RowVersion] rowversion NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816180112_RowVersion')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20170816180112_RowVersion', N'2.0.1-rtm-125');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    ALTER TABLE [Enrollment] DROP CONSTRAINT [FK_Enrollment_Student_StudentID];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    DROP INDEX [IX_Enrollment_StudentID] ON [Enrollment];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    EXEC sp_rename N'Instructor', N'Person';
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    ALTER TABLE [Person] ADD [EnrollmentDate] datetime2 NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    ALTER TABLE [Person] ADD [Discriminator] nvarchar(128) NOT NULL DEFAULT N'Instructor';
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'Person') AND [c].[name] = N'HireDate');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Person] DROP CONSTRAINT [' + @var5 + '];');
    ALTER TABLE [Person] ALTER COLUMN [HireDate] datetime2 NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    ALTER TABLE [Person] ADD [OldId] int NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    INSERT INTO dbo.Person (LastName, FirstName, HireDate, EnrollmentDate, Discriminator, OldId) SELECT LastName, FirstName, null AS HireDate, EnrollmentDate, 'Student' AS Discriminator, ID AS OldId FROM dbo.Student
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    UPDATE dbo.Enrollment SET StudentId = (SELECT ID FROM dbo.Person WHERE OldId = Enrollment.StudentId AND Discriminator = 'Student')
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'Person') AND [c].[name] = N'OldID');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [Person] DROP CONSTRAINT [' + @var6 + '];');
    ALTER TABLE [Person] DROP COLUMN [OldID];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    DROP TABLE [Student];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    CREATE INDEX [IX_Enrollment_StudentID] ON [Enrollment] ([StudentID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    ALTER TABLE [Enrollment] ADD CONSTRAINT [FK_Enrollment_Person_StudentID] FOREIGN KEY ([StudentID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20170816195930_Inheritance')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20170816195930_Inheritance', N'2.0.1-rtm-125');
END;

GO

