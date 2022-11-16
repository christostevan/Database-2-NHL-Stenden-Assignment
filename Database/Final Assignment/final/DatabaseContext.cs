using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using final.Model;

namespace final
{
    public class DatabaseContext : DbContext
    {
        public virtual DbSet<UserEntity> Users { get; set; }

        public virtual DbSet<SubscriptionEntity> Subscriptions { get; set; }
        public DatabaseContext() : base("connection")
        {
            Database.SetInitializer(
                    /*new DropCreateDatabaseAlways<DatabaseContext>()*/
                    new CreateDatabaseIfNotExists<DatabaseContext>()
                );
        }

        /*        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
                {

                }*/
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserEntity>().Map(m =>
            {
                m.ToTable("User");
            });
            modelBuilder.Entity<SubscriptionEntity>().Map(m =>
            {
                m.ToTable("Subscription");
            });
/*            modelBuilder.Entity<UserEntity>().HasRequired(h => h.subscription_id)
                .WithMany()
                .HasForeignKey(e => e.subscription_id);*/
            //modelBuilder.Entity<UserEntity>().HasOptional(e => e.subscription_id);

            //modelBuilder.Entity<User>().HasOptional<Subscription>();

            //base.Entry(modelBuilder);
        }
    }
}
