using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace final.Model
{
    [Table("User")]
    public class UserEntity
    {
        [Key]
        public int user_id { get; set; }
        public string user_email { get; set; }
        public string user_password { get; set; }
        public byte? login_attempts { get; set; }
        public bool is_blocked { get; set; }

        public int subscription_id { get; set; }

        //[ForeignKey("subscription_id")]
        //public SubscriptionEntity subscription_id { get; set; }
    }
}
