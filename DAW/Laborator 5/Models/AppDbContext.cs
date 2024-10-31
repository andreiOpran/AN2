using Microsoft.EntityFrameworkCore;

namespace Laborator_5.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) {} // constructor
     
        public DbSet<Article> Articles { get; set; }
 
        public DbSet<Category> Categories { get; set; }
    }
}
