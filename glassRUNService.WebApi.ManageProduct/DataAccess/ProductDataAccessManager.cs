using glassRUN.Framework.DataAccess;
using glassRUN.Framework.Serializer;
using glassRUNService.WebApi.ManageProduct.DTO;

using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;


namespace glassRUNService.WebApi.ManageProduct.DataAccess
{
    public class ProductDataAccessManager
    {
        /// <summary>
        /// implementation for the save product 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="saveProduct"></param>
        /// <returns></returns>
        public static T SaveProduct<T>(ProductDTO saveProduct)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseWriteConnection))
            {
                IDbCommand command = new SqlCommand("ISP_SaveProductV2", connection);
                command.CommandType = CommandType.StoredProcedure;
                #region Parameter

                //command.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.BigInt)
                //{
                //    Value = (saveProduct.ItemId == null ? DBNull.Value as object : saveProduct.ItemId)
                //});
                command.Parameters.Add(new SqlParameter("@ItemName ", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ItemName == null ? DBNull.Value as object : saveProduct.ItemName)
                });
                command.Parameters.Add(new SqlParameter("@ItemNameEnglishLanguage", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ItemNameEnglishLanguage == null ? DBNull.Value as object : saveProduct.ItemNameEnglishLanguage)
                });

                command.Parameters.Add(new SqlParameter("@ItemCode", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ItemCode == null ? DBNull.Value as object : saveProduct.ItemCode)
                });
                command.Parameters.Add(new SqlParameter("@ItemShortCode", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ItemShortCode == null ? DBNull.Value as object : saveProduct.ItemShortCode)
                });
                command.Parameters.Add(new SqlParameter("@PrimaryUnitOfMeasure", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.PrimaryUnitOfMeasure == null ? DBNull.Value as object : saveProduct.PrimaryUnitOfMeasure)
                });
                command.Parameters.Add(new SqlParameter("@SecondaryUnitOfMeasure", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.SecondaryUnitOfMeasure == null ? DBNull.Value as object : saveProduct.SecondaryUnitOfMeasure)
                });
                command.Parameters.Add(new SqlParameter("@ProductType", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ProductType == null ? DBNull.Value as object : saveProduct.ProductType)
                });
                command.Parameters.Add(new SqlParameter("@BussinessUnit", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.BussinessUnit == null ? DBNull.Value as object : saveProduct.BussinessUnit)
                });
                command.Parameters.Add(new SqlParameter("@DangerGoods", SqlDbType.Bit)
                {
                    Value = (saveProduct.DangerGoods == null ? DBNull.Value as object : saveProduct.DangerGoods)
                });
                command.Parameters.Add(new SqlParameter("@Description", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Description == null ? DBNull.Value as object : saveProduct.Description)
                });
                command.Parameters.Add(new SqlParameter("@StockInQuantity", SqlDbType.BigInt)
                {
                    Value = (saveProduct.StockInQuantity == null ? DBNull.Value as object : saveProduct.StockInQuantity)
                });
                command.Parameters.Add(new SqlParameter("@WeightPerUnit", SqlDbType.BigInt)
                {
                    Value = (saveProduct.WeightPerUnit == null ? DBNull.Value as object : saveProduct.WeightPerUnit)
                });
                command.Parameters.Add(new SqlParameter("@ImageUrl", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ImageUrl == null ? DBNull.Value as object : saveProduct.ImageUrl)
                });
                command.Parameters.Add(new SqlParameter("@PackSize", SqlDbType.BigInt)
                {
                    Value = (saveProduct.PackSize == null ? DBNull.Value as object : saveProduct.PackSize)
                });
                command.Parameters.Add(new SqlParameter("@BranchPlant", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.BranchPlant == null ? DBNull.Value as object : saveProduct.BranchPlant)
                });
                command.Parameters.Add(new SqlParameter("@CreatedBy", SqlDbType.BigInt)
                {
                    Value = (saveProduct.CreatedBy == null ? DBNull.Value as object : saveProduct.CreatedBy)
                });
                command.Parameters.Add(new SqlParameter("@CreatedDate", SqlDbType.DateTime)
                {
                    Value = (saveProduct.CreatedDate == null ? DBNull.Value as object : saveProduct.CreatedDate)
                });
                command.Parameters.Add(new SqlParameter("@ModifiedBy", SqlDbType.BigInt)
                {
                    Value = (saveProduct.ModifiedBy == null ? DBNull.Value as object : saveProduct.ModifiedBy)
                });
                command.Parameters.Add(new SqlParameter("@ModifiedDate", SqlDbType.DateTime)
                {
                    Value = (saveProduct.ModifiedDate == null ? DBNull.Value as object : saveProduct.ModifiedDate)
                });
                command.Parameters.Add(new SqlParameter("@IsActive", SqlDbType.Bit)
                {
                    Value = (saveProduct.IsActive == null ? DBNull.Value as object : saveProduct.IsActive)
                });
                command.Parameters.Add(new SqlParameter("@SequenceNo", SqlDbType.BigInt)
                {
                    Value = (saveProduct.SequenceNo == null ? DBNull.Value as object : saveProduct.SequenceNo)
                });
                command.Parameters.Add(new SqlParameter("@PricingUnit", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.PricingUnit == null ? DBNull.Value as object : saveProduct.PricingUnit)
                });
                command.Parameters.Add(new SqlParameter("@ShippingUnit", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ShippingUnit == null ? DBNull.Value as object : saveProduct.ShippingUnit)
                });
                command.Parameters.Add(new SqlParameter("@ComponentUnit", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ComponentUnit == null ? DBNull.Value as object : saveProduct.ComponentUnit)
                });
                command.Parameters.Add(new SqlParameter("@ItemClass", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ItemClass == null ? DBNull.Value as object : saveProduct.ItemClass)
                });
                command.Parameters.Add(new SqlParameter("@ShelfLife", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ShelfLife == null ? DBNull.Value as object : saveProduct.ShelfLife)
                });
                command.Parameters.Add(new SqlParameter("@BBD", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.BBD == null ? DBNull.Value as object : saveProduct.BBD)
                });
                command.Parameters.Add(new SqlParameter("@Barcode", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Barcode == null ? DBNull.Value as object : saveProduct.Barcode)
                });
                command.Parameters.Add(new SqlParameter("@ItemOwner", SqlDbType.BigInt)
                {
                    Value = (saveProduct.ItemOwner == null ? DBNull.Value as object : saveProduct.ItemOwner)
                });
                command.Parameters.Add(new SqlParameter("@Field1", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field1 == null ? DBNull.Value as object : saveProduct.Field1)
                });
                command.Parameters.Add(new SqlParameter("@Field2", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field2 == null ? DBNull.Value as object : saveProduct.Field2)
                });
                command.Parameters.Add(new SqlParameter("@Field3", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field3 == null ? DBNull.Value as object : saveProduct.Field3)
                });
                command.Parameters.Add(new SqlParameter("@Field4", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field4 == null ? DBNull.Value as object : saveProduct.Field4)
                });
                command.Parameters.Add(new SqlParameter("@Field5", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field5 == null ? DBNull.Value as object : saveProduct.Field5)
                });
                command.Parameters.Add(new SqlParameter("@Field6", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field6 == null ? DBNull.Value as object : saveProduct.Field6)
                });
                command.Parameters.Add(new SqlParameter("@Field7", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field7 == null ? DBNull.Value as object : saveProduct.Field7)
                });
                command.Parameters.Add(new SqlParameter("@Field8", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field8 == null ? DBNull.Value as object : saveProduct.Field8)
                });
                command.Parameters.Add(new SqlParameter("@Field9", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field9 == null ? DBNull.Value as object : saveProduct.Field9)
                });
                command.Parameters.Add(new SqlParameter("@Field10", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Field10 == null ? DBNull.Value as object : saveProduct.Field10)
                });
                command.Parameters.Add(new SqlParameter("@ItemType", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.ItemType == null ? DBNull.Value as object : saveProduct.ItemType)
                });
                command.Parameters.Add(new SqlParameter("@AutomatedWareHouseUOM", SqlDbType.BigInt)
                {
                    Value = (saveProduct.AutomatedWareHouseUOM == null ? DBNull.Value as object : saveProduct.AutomatedWareHouseUOM)
                });
                command.Parameters.Add(new SqlParameter("@Tax", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Tax == null ? DBNull.Value as object : saveProduct.Tax)
                });
                command.Parameters.Add(new SqlParameter("@Length", SqlDbType.BigInt)
                {
                    Value = (saveProduct.Length == null ? DBNull.Value as object : saveProduct.Length)
                });
                command.Parameters.Add(new SqlParameter("@Breadth", SqlDbType.BigInt)
                {
                    Value = (saveProduct.Breadth == null ? DBNull.Value as object : saveProduct.Breadth)
                });
                command.Parameters.Add(new SqlParameter("@Height", SqlDbType.BigInt)
                {
                    Value = (saveProduct.Height == null ? DBNull.Value as object : saveProduct.Height)
                });
                command.Parameters.Add(new SqlParameter("@Brand", SqlDbType.NVarChar)
                {
                    Value = (saveProduct.Brand == null ? DBNull.Value as object : saveProduct.Brand)
                });


                #endregion
                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }

        
    }
}
