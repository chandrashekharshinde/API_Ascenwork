using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using glassRUN.Framework.Serializer;
using glassRUNService.WebApi.VehicleMaster.DTO;
using glassRUNService.WebApi.VehicleMaster.DataAccess;
using APIController.Framework.AppLogger;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using glassRUN.Framework;
//using glassRUNService.WebApi.Configurations.DTO;
using System.Text.RegularExpressions;
using glassRUNProduct.DataAccess.Common;
using System.Dynamic;

namespace glassRUNService.WebApi.VehicleMaster.Business
{
    public class ManageVehicle : IManageVehicle
    {

        BaseAppLogger _loggerInstance;
        public ManageVehicle(BaseAppLogger loggerInstance)
        {
            _loggerInstance = loggerInstance;
        }

        public ManageVehicle()
        {

        }


        public bool ValidateDTO()
        {
            return true;
        }

        //Load Transport Vehicle Details
        public JObject LoadTransportVehicleDetails(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.LoadTransportVehicleDetails_getPagging(Json);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Check Duplicate Transport Vehicale
        public JObject CheckDuplicateTransportVehicale(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.CheckDuplicateTransportVehicale(Json);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Save the Vehicle
        public JObject SaveVehicle(string vehicleDTO)
        {
            //JObject returnObject = new JObject();
            string notValidFields = "";
            string output = "";

            dynamic returnObject = new ExpandoObject();
            //notValidFields = _GRValidations.ValidateAllFields(newObj);

            JObject jsonObj = JObject.Parse(vehicleDTO);
            string Input = JsonConvert.SerializeObject(jsonObj);
            var transporterVehicleId = Convert.ToString(jsonObj["Json"]["TransportVehicleList"]["TransportVehicleId"]);

            if (notValidFields == "")
            {
                //string vehicleDTOXML = ObjectXMLSerializer<VehicleDTO>.Save(vehicleDTO);
                if (transporterVehicleId == "0")
                {
                    output = TransportVehicleDataAccessLayer.Insert<String>(vehicleDTO);
                }
                else
                {
                    output = TransportVehicleDataAccessLayer.Update<String>(vehicleDTO);
                }
                if (output != null)
                {
                    string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                    returnObject = (JObject)JsonConvert.DeserializeObject(jsonOutput);
                }
            }
            else
            {
                returnObject.ErrorValidationMessage = notValidFields;
            }

            return returnObject;
        }

        //Get All Transport Vehicle Paging
        public JObject GetTransportVehiclePaging(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            dynamic rspjsonobjTrans = new ExpandoObject();
            DataSet dt = TransportVehicleDataAccessLayer.GetAllTransportVehicle_Paging<DataSet>(Json);
            if (dt != null)
            {
                rspjsonobjTrans.TransportVehicleList = DataTableToJsonObject(dt.Tables[0]);
                returnObject = (JObject)JsonConvert.SerializeObject(rspjsonobjTrans);

            }
            return returnObject;
        }

        public object DataTableToJsonObject(DataTable dt)
        {
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return rows;
        }


        //Get TransportVehicle By ID
        public JObject GetVehicleByID(string vehicleDTO)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.GetTransportVehicleById(vehicleDTO);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Delete TransportVehicle By ID
        public JObject DeleteVehicleByID(string vehicleDTO)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.DeleteTransportVehicleById(vehicleDTO);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Load Transport Vehicle By Transport Vehicle Id
        public JObject LoadTransportVehicleById(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.LoadTransportVehicleByTransportVehicleId(Json);
            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Get Transport Vehicle Details By Id
        public JObject GetTransportVehicleDetailsById(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.GetTransportVehicleDetailsById(Json);
            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Delete Transport Vehicle
        public JObject DeleteTransportVehicle(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.Delete(Json);
            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }


        //Get Plate Number By Carrier ID
        public JObject GetPlateNumberByCarrier(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.GetPlateNumberByCarrierId(Json);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Get Driver By Plate Number
        public JObject GetDriverByPlateNumberId(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.GetDriverByPlateNoId(Json);
            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Get All PlateNumber For Security App
        public JObject GetAllPlateNumberForSecurityApp(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.GetAllPlateNumberForSecurityApp(Json);
            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        //Get All Country Details
        public JObject GetCountry()
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.GetCountryDetails();
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }

        public JObject GetAllVehicleForThirdPartySync()
        {
            dynamic returnObject = new ExpandoObject();
            string output = TransportVehicleDataAccessLayer.GetAllTransportVehicleToSync();
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }
    }
}
