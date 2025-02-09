using ExercitiuLaborator12.Models;
using Microsoft.EntityFrameworkCore;

namespace ExercitiuLaborator12.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Membership> Memberships { get; set; }
        public DbSet<Gym> Gyms { get; set; }


    }
}