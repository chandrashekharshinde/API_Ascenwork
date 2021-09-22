



CREATE VIEW [dbo].[OrderGridViewNew]
AS
SELECT        OrderId, EnquiryId, OrderType, OrderNumber, ModifiedDate, HoldStatus, TotalPrice, SalesOrderNumber, SOGratisNumber, PurchaseOrderNumber, ProposedShift, ProposedTimeOfAction, 
                         StatusForChangeInPickShift, OrderDate, LocationName, DeliveryLocation, CompanyName, ShortCompanyName,CompanyMnemonic, SupplierName, SupplierCode, UserName, ExpectedTimeOfDelivery, RequestDate, 
                         ReceivedCapacityPalettes, Capacity, IsRPMPresent, EnquiryAutoNumber, GratisCode, Province, OrderedBy, LoadNumber, Description1, Description2, CarrierNumberValue, Field1, Remarks, CurrentState, Status, 
                         Class, ShipTo, SoldTo, OrderCompanyId, ReceivedCapacityPalettesCheck, PrimaryAddressId, SecondaryAddressId, PrimaryAddress, SecondaryAddress, BranchPlantName, BranchPlantCode, 
                         DeliveryLocationBranchName, Empties, EmptiesLimit, ActualEmpties, AssociatedOrder, PreviousState, TruckSizeId, TruckCapacityWeight, TruckSize, Email, TripCost, TripRevenue,
                             (SELECT        TOP (1) TruckInDataTime
                               FROM            dbo.TruckInOrder AS tio
                               WHERE        (OrderNumber = dbo.OrderGridView.OrderNumber)) AS TruckInDataTime,
(Select top 1 wal.Username from [dbo].[WorkFlowActivityLog] wal where wal.WorkFlowCurrentStatusCode=320 and wal.EnquiryId=dbo.OrderGridView.EnquiryId) as ApprovedBy,
                             (SELECT        TOP (1) TruckOutDataTime
                               FROM            dbo.TruckInOrder AS tio
                               WHERE        (OrderNumber = dbo.OrderGridView.OrderNumber)) AS TruckOutDataTime, TripRevenue - TripCost AS TripProfit,InvoiceNumber, CASE WHEN isnull([TripRevenue], 0) = 0 THEN 0 ELSE CONVERT(decimal(18, 2), 
                         (([TripRevenue] - [TripCost]) * 100 / [TripRevenue])) END AS TripProfitPerCent, PaymentAdvanceAmount, PaymentRequestDate, PaymentRequestStatus, BillingStatus, BillingCreditedAmount, 
                         BillingCreditedAmountStatus, BillingCreditedAmountDate, TotalAmountRequested, TotalPaidAmountRequested, TotalAmountRequested - TotalPaidAmountRequested AS BalanceAmount, GETDATE() 
                         AS BalanceAmountDate, CASE WHEN [TripCost] = 0 THEN 'Trip Cost Not Assign' ELSE CASE WHEN (TotalAmountRequested - TotalPaidAmountRequested) 
                         = 0 THEN 'PAID' ELSE 'PENDING' END END AS BalAmtStatus, PlateNumberData, DeliveryPersonName, PlateNumber, PreviousPlateNumber, DriverName, ProfileId, TruckInPlateNumber, TruckOutPlateNumber, 
                         TruckInDateTime, TruckOutDateTime,CarrierNumber,CarrierCode, TruckRemark, ExpectedShift, ExpectedTimeOfAction, CollectedDate, EnquiryDate, DeliveredDate, PlanCollectionDate, PlanDeliveryDate, 
                         CASE WHEN [PlanDeliveryDate] IS NULL THEN '1' WHEN ISNULL([PlanDeliveryDate], '') >= ISNULL([DeliveredDate], GETDATE()) THEN '1' ELSE '-1' END AS IsLate, IsCompleted, ExpectedTimeOfActionValue, 
                         DeliveryPersonnelId, PickDateTime, ExpectedTimeOfDeliveryFromOM, PickDateTimeFromOM, ExpectedTimeOfDeliveryValue, PickDateTimeValue, IsSelfCollect, ISNULL
                             ((SELECT        TOP (1) TruckInDeatilsId
                                 FROM            dbo.TruckInDeatils AS tid
                                 WHERE        (PlateNumber = dbo.OrderGridView.PlateNumber) AND (DriverId = dbo.OrderGridView.DeliveryPersonnelId) AND (TruckInDataTime IS NOT NULL) AND (TruckOutDataTime IS NULL)), 0) 
                         AS TruckInDeatilsId, ISNULL
                             ((SELECT        TOP (1) TruckInOrderId
                                 FROM            dbo.TruckInOrder AS tio
                                 WHERE        (OrderNumber = dbo.OrderGridView.OrderNumber)), 0) AS TruckInOrderId, ShipToCode
FROM            dbo.OrderGridView

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
         Begin Table = "OrderGridView"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 304
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'OrderGridViewNew';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'OrderGridViewNew';

