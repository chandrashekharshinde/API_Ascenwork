
CREATE VIEW dbo.OrderHeader
AS
SELECT        e.EnquiryAutoNumber AS OrderNumber, e.EnquiryDate AS OrderDate, dl1.LocationName AS FromName, dl1.LocationCode AS FromCode, dl.LocationName AS ToName, 
                         dl.LocationCode AS ToCode, e.EnquiryType, l.Name AS Status
FROM            dbo.Enquiry AS e INNER JOIN
                         dbo.Location AS dl1 ON dl1.LocationId = e.SoldTo INNER JOIN
                         dbo.Location AS dl ON dl.LocationId = e.ShipTo INNER JOIN
                         dbo.TruckSize AS ts ON ts.TruckSizeId = e.TruckSizeId INNER JOIN
                         dbo.LookUp AS l ON l.LookUpId = e.CurrentState
WHERE        (e.EnquiryType = 'ST')

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[6] 2[17] 3) )"
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
         Begin Table = "l"
            Begin Extent = 
               Top = 162
               Left = 426
               Bottom = 292
               Right = 603
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dl"
            Begin Extent = 
               Top = 177
               Left = 57
               Bottom = 307
               Right = 266
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ts"
            Begin Extent = 
               Top = 6
               Left = 682
               Bottom = 136
               Right = 888
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 314
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dl1"
            Begin Extent = 
               Top = 6
               Left = 926
               Bottom = 136
               Right = 1135
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1980
         Width = 1680
         Width = 1140
         Width = 1680
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Tab', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'OrderHeader';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'le = 1170
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'OrderHeader';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'OrderHeader';

