using System;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "Note", IsNullable = false)]
    public class NoteDTO
    {

        public long? NoteId { get; set; }
        public string Note { get; set; }
        public long? ObjectId { get; set; }
        public long? ObjectType { get; set; }
        public string IsActive { get; set; }
        public long? RoleId { get; set; }
        public long? CreatedBy { get; set; }
        public long? ModifiedBy { get; set; }
    }
}
