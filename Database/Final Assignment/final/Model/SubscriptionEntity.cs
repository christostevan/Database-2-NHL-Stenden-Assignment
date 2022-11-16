using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace final.Model
{
    [Table("Subcription")]
    public class SubscriptionEntity
    {
        [Key]
        public int subscription_id { get; set; }
        public float price { get; set; }

        //[ForeignKey("subscription_ID")]
        //public ICollection<UserEntity> Users { get; set; }
    }
}
