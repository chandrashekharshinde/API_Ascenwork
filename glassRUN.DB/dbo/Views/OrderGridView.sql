



CREATE VIEW [dbo].[OrderGridView]
AS
SELECT        tmp.OrderId, tmp.OrderType, [TripCost], [TripRevenue],[InvoiceNumber], PaymentAdvanceAmount, PaymentRequestDate, PaymentRequestStatus, IsSelfCollect, BillingStatus, BillingCreditedAmount, BillingCreditedAmountStatus, 
                         BillingCreditedAmountDate, TotalAmountRequested, TotalPaidAmountRequested, tmp.EnquiryId, tmp.OrderNumber, ModifiedDate, HoldStatus, ISNULL(TotalPrice, 0) AS TotalPrice, tmp.SalesOrderNumber, 
                         tmp.SalesOrderNumber AS SOGratisNumber, PurchaseOrderNumber, ISNULL(PraposedShift, '') AS ProposedShift, ISNULL(PraposedTimeOfAction, '') AS ProposedTimeOfAction, StatusForChangeInPickShift, 
                         OrderDate, LocationName, CASE WHEN LEN(LocationCode) > 15 THEN LEFT(LocationCode, 15) + '...' ELSE LocationCode END AS DeliveryLocation, CompanyName, ShortCompanyName,CompanyMnemonic, SupplierName, 
                         SupplierCode, UserName, ISNULL(tmp.ExpectedTimeOfDelivery, '') AS ExpectedTimeOfDelivery, ISNULL(tmp.ExpectedTimeOfDelivery, '') AS ExpectedTimeOfDeliveryValue, 
                         ISNULL(tmp.ExpectedTimeOfDeliveryFromOM, '') AS ExpectedTimeOfDeliveryFromOM, ISNULL(tmp.ExpectedTimeOfDelivery, '') AS RequestDate, ISNULL(tmp.PickDateTime, '') AS PickDateTime, 
                         ISNULL(tmp.PickDateTime, '') AS PickDateTimeValue, ISNULL(tmp.PickDateTimeFromOM, '') AS PickDateTimeFromOM,
                             (SELECT        [dbo].[fn_GetTotalRecivingCapacityPalettes](ExpectedTimeOfDelivery, ShipTo, SoldTo, ISNULL(CONVERT(bigint, Capacity), 0))) AS ReceivedCapacityPalettes, ISNULL(CONVERT(bigint, Capacity), 0) 
                         AS Capacity, IsRPMPresent, EnquiryAutoNumber, EnquiryDate, GratisCode, Province, OrderedBy, LoadNumber, Description1, Description2, CarrierNumberValue, Field1, Remarks, CurrentState, Status, Class, 
                         ShipTo, SoldTo, OrderCompanyId, ReceivedCapacityPalettesCheck, PrimaryAddressId, [SecondaryAddressId], [PrimaryAddress], [SecondaryAddress], BranchPlantName, DeliveryLocationBranchName, 
                         BranchPlantCode, Empties, IsNull(EmptiesLimit, 0) AS EmptiesLimit, IsNull(ActualEmpties, 0) AS ActualEmpties, AssociatedOrder, [PreviousState], [TruckSizeId], [TruckSize], [TruckCapacityWeight], Email, 
                         PlateNumberData, ISNULL(DeliveryPersonName, DriverName) AS DeliveryPersonName, PlateNumber, PreviousPlateNumber, ISNULL(DriverName, '-') AS DriverName, ISNULL(ProfileId, 0) AS ProfileId, 
                         ISNULL(TruckInPlateNumber, '') AS TruckInPlateNumber, ISNULL(TruckOutPlateNumber, '') AS TruckOutPlateNumber, ISNULL(TruckInDateTime, '') AS TruckInDateTime, ISNULL(TruckOutDateTime, '') 
                         AS TruckOutDateTime, CarrierNumber,CarrierCode, TruckRemark, ISNULL(ExpectedShift, '') AS ExpectedShift, DeliveredDate AS DeliveredDate, CollectedDate AS CollectedDate, PlanCollectionDate, PlanDeliveryDate, 
                         IsCompleted, ISNULL(ExpectedTimeOfAction, '') AS ExpectedTimeOfAction, ExpectedTimeOfAction AS ExpectedTimeOfActionValue, ISNULL(DeliveryPersonnelId, 0) AS DeliveryPersonnelId  , ShipToCode
FROM            (SELECT        o.OrderId, o.OrderType, o.OrderNumber, o.EnquiryId, (CASE WHEN o.HoldStatus IS NULL OR
                                                    o.HoldStatus = '' THEN '-' ELSE o.HoldStatus END) AS HoldStatus,
                                                        (SELECT        [dbo].[fn_GetTotalAmount](0, o.OrderId)) AS TotalPrice, ISNULL(o.ModifiedDate, o.CreatedDate) AS ModifiedDate, d .LocationName, d .LocationCode,
                                                        /*REPLACE(SUBSTRING((select top 1 CompanyName from [dbo].Company where CompanyId =  o.SoldTo),1,5), '-', '')as CompanyName,*/ (SELECT        TOP 1 CompanyName
                                                                   
																   
																   
																                                                                                                                                                                                                                                                                                                FROM            [dbo].Company
                                                                                                                                                                                                                                                                                                                                                                WHERE        CompanyId = o.SoldTo) AS CompanyName,
isnull(SUBSTRING((Select top 1 CompanyName from Company where companyid= o.SoldTo), 0, 
                                              CHARINDEX('-', (Select top 1 CompanyName from Company where companyid= o.SoldTo))), SUBSTRING((Select top 1 CompanyName from Company where companyid= o.SoldTo), 0, 5)) AS ShortCompanyName,

                                                        (SELECT        TOP 1 CompanyMnemonic
                                                          FROM            [dbo].Company
                                                          WHERE        CompanyId = o.SoldTo) AS CompanyMnemonic,

                                                        (SELECT        TOP 1 CompanyName
                                                          FROM            [dbo].Company
                                                          WHERE        CompanyId = o.CompanyId) AS SupplierName, o.CompanyCode AS SupplierCode,
                                                        (SELECT        TOP 1 UserName
                                                          FROM            [dbo].Login
                                                          WHERE        LoginId = o.CreatedBy) AS UserName, o.ExpectedTimeOfDelivery AS ExpectedTimeOfDelivery,
                                                        (SELECT        PraposedTimeOfAction
                                                          FROM            [OrderMovement]
                                                          WHERE        OrderId = o.OrderId AND LocationType = 2) AS ExpectedTimeOfDeliveryFromOM, o.ExpectedTimeOfDelivery AS RequestDate, 
                                                    /*o.PickDateTime as PickDateTime,*/ o.PickDateTime AS PickDateTime,
                                                        (SELECT        PraposedTimeOfAction
                                                          FROM            [OrderMovement]
                                                          WHERE        OrderId = o.OrderId AND LocationType = 1) AS PickDateTimeFromOM, IsNULl(o.SalesOrderNumber, '-') AS SalesOrderNumber, IsNULl(o.PurchaseOrderNumber, '-') 
                                                    AS PurchaseOrderNumber, om.PraposedShift AS PraposedShift, om.PraposedTimeOfAction AS PraposedTimeOfAction, o.OrderDate, d .Capacity, CASE WHEN
                                                        (SELECT        Count(ReturnPakageMaterialId)
                                                          FROM            [dbo].ReturnPakageMaterial rpm
                                                          WHERE        rpm.EnquiryId = o.EnquiryId AND IsActive = 1) > 0 THEN 1 ELSE 0 END AS IsRPMPresent, o.Remarks, o.CurrentState,
                                                        /*S(ELECT [dbo].[fn_RoleWiseClass] (3,o.CurrentState)) AS 'Class',*/ (SELECT        TOP 1 [ResourceValue]
                                                                                                                                                                                                              FROM            [dbo].[RoleWiseStatusView]
                                                                                                                                                                                                              WHERE        [RoleId] = 3 AND [StatusId] = o.CurrentState AND [CultureId] = 1101) AS [Status],
                                                        (SELECT        TOP 1 [Class]
                                                          FROM            [dbo].[RoleWiseStatusView]
                                                          WHERE        [RoleId] = 3 AND [StatusId] = o.CurrentState) AS 'Class', ISNULL
                                                        ((SELECT        EnquiryAutoNumber
                                                            FROM            [dbo].Enquiry
                                                            WHERE        EnquiryId = o.EnquiryId), '-') AS EnquiryAutoNumber, ISNULL
                                                        ((SELECT        EnquiryDate
                                                            FROM            [dbo].Enquiry
                                                            WHERE        EnquiryId = o.EnquiryId), NULL) AS EnquiryDate, o.ShipTo, o.GratisCode, o.Province, o.OrderedBy, o.LoadNumber, o.Description1, o.Description2, ISNULL(d .Field1, '') AS Field1, 
                                                    o.SoldTo, o.CompanyId AS OrderCompanyId, CASE WHEN
                                                        ((SELECT        [dbo].[fn_GetTotalRecivingCapacityPalettes](ExpectedTimeOfDelivery, o.ShipTo, o.SoldTo, ISNULL(CONVERT(bigint, Capacity), 0)))) 
                                                    < 0 THEN '0' ELSE '1' END AS ReceivedCapacityPalettesCheck, o.PrimaryAddressId, [SecondaryAddressId], [PrimaryAddress], [SecondaryAddress],
                                                        (SELECT        TOP 1 l1.LocationId
                                                          FROM            [Location] l1
                                                          WHERE        l1.LocationCode = o.StockLocationId) AS StockLocationId,
                                                        /*''as StockLocationId,*/ (SELECT        TOP 1 l1.LocationName
                                                                                                               FROM            [Location] l1
                                                                                                               WHERE        l1.LocationCode = o.StockLocationId) AS DeliveryLocationBranchName,
                                                        (SELECT        TOP 1 l1.LocationName
                                                          FROM            [Location] l1
                                                          WHERE        l1.LocationCode = o.StockLocationId) AS BranchPlantName,
                                                        (SELECT        TOP 1 l1.LocationCode
                                                          FROM            [Location] l1
                                                          WHERE        l1.LocationCode = o.StockLocationId) AS BranchPlantCode, CASE WHEN (c.ActualEmpties < 0) THEN 'C' ELSE 'W' END AS Empties, 
                                                    (CASE WHEN PraposedTimeOfAction != ExpectedTimeOfAction OR
                                                    PraposedShift != ExpectedShift THEN '1' ELSE '0' END) AS StatusForChangeInPickShift,
                                                        (SELECT        TOP 1 EmptiesLimit
                                                          FROM            [dbo].Company
                                                          WHERE        companyid = o.SoldTo) AS EmptiesLimit,
                                                        (SELECT        TOP 1 ActualEmpties
                                                          FROM            [dbo].Company
                                                          WHERE        companyid = o.SoldTo) AS ActualEmpties,
                                                        (SELECT        STUFF
                                                                                        ((SELECT        (SELECT        ',' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()]
                                                                                                                      FROM            [dbo].[order] WITH (NOLOCK)
                                                                                                                      WHERE        IsActive = 1 AND orderId IN
                                                                                                                                                    (SELECT        AssociatedOrder
                                                                                                                                                      FROM            [dbo].[OrderProduct] op
                                                                                                                                                      WHERE        op.IsActive = 1 AND OrderId = o.OrderId AND AssociatedOrder IS NOT NULL AND AssociatedOrder <> 0) FOR XML PATH(''))), 1, 1, '')) 
                                                    AS AssociatedOrder, [PreviousState], o.[TruckSizeId], ts .TruckCapacityWeight, ts .TruckSize,
                                                        /*c.Email,*/ (SELECT        STUFF
                                                                                                                 ((SELECT        (SELECT        ',' + CAST(Contacts AS VARCHAR(max)) [text()]
                                                                                                                                               FROM            [dbo].contactinformation
                                                                                                                                               WHERE        IsActive = 1 AND ObjectId = o.ShipTO AND ContactType = 'Email' AND (ObjectType = 'SoldTo' OR
                                                                                                                                                                         ObjectType = 'ShipTo') FOR XML PATH(''))), 1, 1, '')) AS Email,
                                                        (SELECT        TOP 1 TruckPlateNumber
                                                          FROM            [dbo].orderlogistics
                                                          WHERE        ordermovementid IN
                                                                                        (SELECT        OrderMovementId
                                                                                          FROM            [dbo].OrderMovement
                                                                                          WHERE        OrderId = o.OrderId AND LocationType = 1)) AS PlateNumberData,
                                                        (SELECT        TOP 1 DeliveryPersonName
                                                          FROM            [dbo].orderlogistics
                                                          WHERE        ordermovementid IN
                                                                                        (SELECT        OrderMovementId
                                                                                          FROM            [dbo].OrderMovement
                                                                                          WHERE        OrderId = o.OrderId AND LocationType = 1)) AS DeliveryPersonName, otv.PlateNumber, otv.PreviousPlateNumber, otv.TruckInPlateNumber, otv.TruckOutPlateNumber, 
                                                    otv.TruckInDateTime, otv.TruckOutDateTime, o.CarrierNumber,o.CarrierCode,
                                                        (SELECT        TOP 1 c1.CompanyName
                                                          FROM            Company c1
                                                          WHERE        c1.CompanyId = o.CarrierNumber) AS CarrierNumberValue, otv.TruckRemark, otv.DriverName,
                                                        (SELECT        ProfileId
                                                          FROM            [dbo].Login
                                                          WHERE        LoginId IN
                                                                                        (SELECT        DeliveryPersonnelId
                                                                                          FROM            [dbo].OrderLogistics
                                                                                          WHERE        OrderMovementId IN
                                                                                                                        (SELECT        TOP 1 OrderMovementId
                                                                                                                          FROM            [dbo].OrderMovement
                                                                                                                          WHERE        OrderId = o.OrderId))) AS ProfileId, (CASE WHEN om.ExpectedShift IS NOT NULL THEN om.ExpectedShift ELSE om.PraposedShift END) AS ExpectedShift, 
                                                    (CASE WHEN
                                                        (SELECT        Name
                                                          FROM            [dbo].lookup
                                                          WHERE        lookupid = om.ExpectedShift) IS NOT NULL THEN
                                                        (SELECT        Name
                                                          FROM            [dbo].lookup
                                                          WHERE        lookupid = om.ExpectedShift) ELSE
                                                        (SELECT        Name
                                                          FROM            [dbo].lookup
                                                          WHERE        lookupid = om.PraposedShift) END) AS ExpectedShiftValue, (CASE WHEN om.ExpectedTimeOfAction IS NOT NULL THEN om.ExpectedTimeOfAction ELSE om.PraposedTimeOfAction END)
                                                     AS ExpectedTimeOfAction, ISNULL(om.ActualTimeOfAction, NULL) AS CollectedDate, ISNULL
                                                        ((SELECT        ISNULL(om1.ActualTimeOfAction, NULL)
                                                            FROM            OrderMovement om1
                                                            WHERE        om1.OrderId = o.OrderId AND om1.LocationType = 2), NULL) AS DeliveredDate, ISNULL(om.ExpectedTimeOfAction, NULL) AS PlanCollectionDate, ISNULL
                                                        ((SELECT        ISNULL(om1.ExpectedTimeOfAction, NULL)
                                                            FROM            OrderMovement om1
                                                            WHERE        om1.OrderId = o.OrderId AND om1.LocationType = 2), NULL) AS PlanDeliveryDate, ISNULL
                                                        ((SELECT        CASE WHEN om1.ActualTimeOfAction IS NULL THEN '0' ELSE '1' END
                                                            FROM            OrderMovement om1
                                                            WHERE        om1.OrderId = o.OrderId AND om1.LocationType = 2), '') AS IsCompleted, om.DeliveryPersonnelId AS DeliveryPersonnelId, 
															--Isnull
                                                        --((SELECT        TOP 1 CONVERT(decimal(18, 2), otc.[TripCost])
                                                        --    FROM            [OrderTripCost] otc
                                                        --    WHERE        otc.[OrderId] = o.[OrderId]), 0) AS [TripCost], Isnull
                                                        --((SELECT        TOP 1 CONVERT(decimal(18, 2), otc.[TripRevenue])
                                                        --    FROM            [OrderTripCost] otc
                                                        --    WHERE        otc.[OrderId] = o.[OrderId]), 0) AS [TripRevenue],

														   0 AS [TripCost], 0 AS [TripRevenue],
														   o.InvoiceNumber,
                                                        (SELECT        TOP 1 isnull(py.PaidAmount, py.Amount)
                                                          FROM            PaymentRequest py
                                                          WHERE        py.IsActive = 1 AND py.Status != 0 AND py.SlabId = 1252 AND py.OrderId = o.OrderId) AS PaymentAdvanceAmount,
                                                        (SELECT        TOP 1 py.RequestDate
                                                          FROM            PaymentRequest py
                                                          WHERE        py.IsActive = 1 AND py.SlabId = 1252 AND py.Status != 0 AND py.OrderId = o.OrderId) AS PaymentRequestDate,
                                                        (SELECT        TOP 1
                                                                                        (SELECT        [dbo].[fn_LookupValueById](py.Status))
                                                          FROM            PaymentRequest py
                                                          WHERE        py.IsActive = 1 AND py.Status != 0 AND py.SlabId = 1252 AND py.OrderId = o.OrderId) AS PaymentRequestStatus, '' AS BillingStatus, '' AS BillingCreditedAmount, 
                                                    '' AS BillingCreditedAmountStatus, '' AS BillingCreditedAmountDate, isnull
                                                        ((SELECT        SUM(pr.Amount)
                                                            FROM            PaymentRequest pr
                                                            WHERE        pr.OrderId = o.OrderId AND pr.IsActive = 1 AND pr.Status != 2203), 0) AS TotalAmountRequested, isnull
                                                        ((SELECT        SUM(pr.PaidAmount)
                                                            FROM            PaymentRequest pr
                                                            WHERE        pr.OrderId = o.OrderId AND pr.IsActive = 1 AND pr.Status != 2203 AND pr.Status = 2202), 0) AS TotalPaidAmountRequested,
															 o.IsSelfCollect,
															 o.ShipToCode
                          FROM            [dbo].[Order] o WITH (NOLOCK) LEFT JOIN
                                                    [dbo].Location d ON o.shipto = d .LocationId LEFT JOIN
                                                    [dbo].Company c ON c.CompanyId = d .CompanyId LEFT JOIN
                                                    [dbo].LookUp l ON l.LookUpId = o.CurrentState LEFT JOIN
                                                    [dbo].TruckSize ts ON ts .TruckSizeId = o.TruckSizeId LEFT JOIN
                                                    [dbo].OrderMovement om WITH (NOLOCK) ON o.OrderId = om.OrderId AND om.Locationtype = 1 LEFT JOIN
                                                    [dbo].OrderTruckInTruckOutView otv WITH (NOLOCK) ON o.OrderId = otv.OrderId
                          WHERE        o.IsActive = 1) AS tmp

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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'OrderGridView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'OrderGridView';

