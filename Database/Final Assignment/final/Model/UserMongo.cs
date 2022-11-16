using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MongoDB.Bson.Serialization.Attributes;

namespace final.Model
{
    [BsonIgnoreExtraElements]
    public class UserMongo
    {
        [BsonId]
        [BsonRepresentation(MongoDB.Bson.BsonType.ObjectId)]
        public string Id { get; set; }

        [BsonElement("user_email")]
        public string user_email { get; set; }

        [BsonElement("user_password")]
        public string user_password { get; set; }

        [BsonElement("login_attempts")]
        public int login_attempts { get; set; }

        [BsonElement("activation_date")]
        public DateTime activation_date { get; set; }



        [BsonElement("is_blocked")]
        public bool is_blocked { get; set; }

        [BsonElement("subscription")]
        public double subscription { get; set; }

        [BsonElement("included_quality")]
        public string included_quality { get; set; }
    }
}
