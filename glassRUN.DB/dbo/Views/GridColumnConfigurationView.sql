CREATE VIEW dbo.GridColumnConfigurationView
AS
SELECT DISTINCT 
                         GC.GridColumnId, ISNULL(GCC.SequenceNumber, '0') AS visibleIndex, GC.ObjectId, GC.PropertyName AS dataField, GC.PropertyType AS dataType, GC.PropertyName, GC.PropertyType, GC.Format, GC.FilterOperations, 
                         GC.Alignment, ISNULL(GC.ResourceKey, GC.PropertyName) AS caption, ISNULL(GC.ResourceKey, GC.PropertyName) AS ResourceValue, GC.ResourceKey, GCC.LoginId, GCC.ResourceId, GCC.PageId, GC.CellTemplate, 
                         GC.CssClass, CASE WHEN ISNULL(GCC.IsPinned, '0') = 1 THEN 'true' ELSE '' END AS fixed, CASE WHEN ISNULL(GCC.IsAvailable, '0') = 1 THEN 'true' ELSE 'false' END AS visible, CASE WHEN ISNULL(GCC.IsMandatory, '0') 
                         = 1 THEN 'true' ELSE 'false' END AS allowHiding, CASE WHEN ISNULL(GCC.IsGrouped, '0') = 1 THEN 'true' ELSE 'false' END AS groupIndex, ISNULL(GCC.IsPinned, '0') AS IsPinned, ISNULL(GCC.IsExportAvailable, '0') 
                         AS IsExportAvailable, ISNULL(GCC.IsAvailable, '0') AS IsAvailable, ISNULL(GCC.IsMandatory, '0') AS IsMandatory, ISNULL(GCC.IsDefault, '0') AS IsDefault, ISNULL(GCC.IsSystemMandatory, '0') AS IsSystemMandatory, 
                         ISNULL(GCC.SequenceNumber, '0') AS SequenceNumber, ISNULL(GCC.IsDetailsViewAvailable, '0') AS IsDetailsViewAvailable, ISNULL(GCC.IsGrouped, '0') AS IsGrouped, ISNULL(GCC.GroupSequence, '0') AS GroupSequence, 
                         GCC.IsActive, GCC.RoleId, pc.ControlName, p.PageName, p.ControllerName
FROM            dbo.GridColumn AS GC LEFT OUTER JOIN
                         dbo.GridColumnConfiguration AS GCC ON GC.GridColumnId = GCC.GridColumnId AND GCC.IsActive = 1 LEFT OUTER JOIN
                         dbo.PageControl AS pc ON pc.PageControlId = GCC.ObjectId LEFT OUTER JOIN
                         dbo.Pages AS p ON p.PageId = pc.PageId AND GCC.PageId = p.PageId
WHERE        (GC.IsActive = 1) AND (GCC.IsActive = 1) AND (GCC.IsAvailable = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "GC"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GCC"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 276
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pc"
            Begin Extent = 
               Top = 6
               Left = 292
               Bottom = 136
               Right = 462
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'GridColumnConfigurationView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'GridColumnConfigurationView';

